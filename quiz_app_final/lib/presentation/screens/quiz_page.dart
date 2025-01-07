import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_final/business_logic/events/quiz_events.dart';
import 'package:quiz_app_final/business_logic/states/quiz_states.dart';
import 'package:quiz_app_final/data/models/category.dart';
import 'package:quiz_app_final/business_logic/blocs/quiz_bloc.dart';
import 'package:quiz_app_final/data/services/quiz_service.dart';
import 'package:quiz_app_final/presentation/widgets/quiz_play_widget.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizPage extends StatefulWidget {
  final String categoryIndex;
  final String title;

  const QuizPage({super.key, required this.title, required this.categoryIndex});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<Category> _categoryFuture;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _categoryFuture = QuizService().getCategoryWithQuestions(widget.categoryIndex);
  }

  /// Méthode pour jouer les sons et afficher les retours de réponse
  Future<void> showAnswerFeedback(BuildContext context, bool isCorrect) async {
    if (isCorrect) {
      await _audioPlayer.play(AssetSource('sound/correct.mp3'));
    } else {
      await _audioPlayer.play(AssetSource('sound/wrong.mp3'));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(
          alignment: Alignment.center,
          child: Text(
            isCorrect ? 'Correct!' : 'Incorrect!',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        duration: const Duration(milliseconds: 500),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Category>(
      future: _categoryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: Center(child: Text('Erreur: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: const Center(child: Text('Aucune catégorie trouvée')),
          );
        }

        Category category = snapshot.data!;

        return BlocProvider(
          create: (context) => QuizBloc(category)..add(StartQuizEvent(category)),
          child: BlocListener<QuizBloc, QuizState>(
            listener: (context, state) {
              if (state is QuizFinishedState) {
                Navigator.pushReplacementNamed(
                  context,
                  '/result',
                  arguments: [state.score.toString(), state.totalQuestions.toString(), widget.categoryIndex],
                );
              }
              if (state is AnswerFeedbackState) {
                showAnswerFeedback(context, state.isCorrect);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                centerTitle: true,
                backgroundColor: Colors.blueGrey[50],
                automaticallyImplyLeading: false,
              ),
              body: BlocBuilder<QuizBloc, QuizState>(
                builder: (context, state) {
                  if (state is QuizInProgressState) {
                    return QuizPlayWidget(state: state);
                  } else if (state is QuizInitialState) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text("Etat inconnu"));
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

