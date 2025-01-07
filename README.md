# TP3 Flutter - UE HAI912I
## TP3 - Flutter Firebase

Ce projet contient une application de quiz développé en Flutter avec `Firebase` pour l'authentification et le stockage des données.

Cet application a été réalisées dans le cadre du TP3 Flutter du cours HAI912I - Développement mobile avancé, IOT et embarqué à l'Université de Montpellier.

## Auteur
- **[Eric Gilles](https://github.com/eric-gilles)**

## Application

### Application de Quiz Firebase - [Quiz App Final](https://github.com/eric-gilles/FlutterTP3/tree/main/quiz_app_final)

Cette application est une évolution de l'application de quiz [quiz_app_v3](https://github.com/eric-gilles/FlutterTP2/tree/main/quiz_app_v3).
qui utilise Firebase pour l'authentification et le stockage des données.
L'application permet à l'utilisateur de s'authentifier avec son compte Google ou avec un email et un mot de passe, de jouer à un quiz et de créer ses propres quiz, une fois authentifié.
Elle possède les fonctionnalités suivantes :
- Authentification avec Google ou email/mot de passe via FirebaseAuth
- Création de quiz
- Stockage des quiz, des questions dans Firebase
- Affichage de la liste des quiz
- Affichage des questions
- Choix de la réponse (oui ou non)
- Affichage de la progression
- Calcul et affichage du score
- Possibilité de recommencer le quiz
- Lancement de son en fonction du résultat de la question


## Accès en ligne

Également disponible en ligne via le lien [Appetize](https://appetize.io/) suivant :
- [Quiz App Final - Appetize](https://appetize.io/app/b_pjtit7m5didap4zmajmlg74d4e)


## Prérequis

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK
- Cli FireBase: [Installation Guide](https://firebase.google.com/docs/cli?hl=fr&authuser=0#install_the_firebase_cli)

## Installation

1. Clonez le dépôt :
    ```bash
    git clone https://github.com/eric-gilles/FlutterTP3
    ```
2. Accédez au répertoire de l'application :
    ```bash
    cd FlutterTP3/quiz_app_final
    ```
3. Créer un nouveau projet Firebase sur la [console Firebase](https://console.firebase.google.com/project/) du nom de votre choix.
4. Activer l'authentification Google (il faudra sélectionnez votre adresse émail en tant que Adresse e-mail d'assistance) et l'authentification par email/mot de passe dans la console Firebase et Cloud Firestore pour la base de données.

   Pour ajouter Google en méthode d'authentification, il faudra aussi lancer la commande suivante :
   ```bash
      keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
    ```
   Et copier la ligne de SHA-1 et le coller dans la console Firebase dans les paramètres de votre projet sous `Empreintes de certificat SHA`.

3. Activer la cli Firebase dans n'importe quel répertoire :
    ```bash
    dart pub global activate flutterfire_cli
    ```
4. Ajouter au PATH :
    ```bash
    export PATH="$PATH":"$HOME/.pub-cache/bin"
    ```
5. Connectez-vous à Firebase :
    ```bash
    firebase login
    ```
6. Initialiser Firebase dans le projet (`nom_de_votre_projet_firebase` correspond au nom de votre projet sur la [console Firebase](https://console.firebase.google.com/project/)) :
    ```bash
    flutterfire configure --project=nom_de_votre_projet_firebase
    ```
   Choisir la plateforme Android en appuyant sur la touche `Entrée` quand vous êtes invité à choisir la plateforme.
   Entrez le nom du package de l'application (ici: `com.example.quiz_app_final`) quand vous êtes invité à le faire.
7. Installez les dépendances :
    ```bash
    flutter pub get
    ```

## Exécution en ligne de commande

Pour exécuter l'application de carte de profil ou l'application de quiz, utilisez la commande suivante dans le répertoire du projet correspondant :

```bash
flutter run -t lib/main.dart
```

## Exécution avec Android Studio

1. Ouvrez le projet de l'application `quiz_app_final` avec Android Studio.
2. Sélectionnez un émulateur ou un appareil physique pour exécuter l'application.
3. Exécutez l'application en cliquant sur le bouton "Run" ou en utilisant le raccourci clavier `Shift + F10`.
