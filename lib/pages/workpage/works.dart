import 'package:meta/meta.dart';

class Project {
  final String image;
  final String title;
  final String description;
  final String githubURL;
  final String webURL;
  Project({
    @required this.image,
    @required this.title,
    @required this.description,
    @required this.githubURL,
    this.webURL,
  });
}

final List<Project> projectList = [
  Project(
      image: "assets/projects/tictactoe.png",
      title: "Tic Tac Toe",
      description: "A simple Tic Tac Toe game made with Flutter framework."
          " Used Bloc pattern for state managment. User can play with human as well as three types of bot. "
          "Difficult level bot uses minimax algorithm for predicting opponents's next move.",
      githubURL: "https://github.com/GajjarMiten/Flutter-tic-tac-toe.git")
];
