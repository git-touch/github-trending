import 'package:github_trending/github_trending.dart';

void main() async {
  // get trending repositories
  var repos = await getTrendingRepositories();
  print(repos[0].name);

  // specify time period
  var weeklyRepos = await getTrendingRepositories(since: 'weekly');
  print(weeklyRepos[0].name);

  // specify language
  var dartRepos = await getTrendingRepositories(language: 'dart');
  print(dartRepos[0].language); // Dart
  print(dartRepos[0].languageColor); // #00B4AB
}
