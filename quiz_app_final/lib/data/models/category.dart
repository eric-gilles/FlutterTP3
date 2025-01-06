import 'package:quiz_app_final/data/models/question.dart';

class Category {
  String? id;
  String name;
  List<Question> questions ;
  Category({required this.id,required this.name, required this.questions});
  Category.noid({required this.name, required this.questions});
}