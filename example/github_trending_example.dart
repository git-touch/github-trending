import 'package:github_trending/github_trending.dart';

main() async {
  // get trending repositories
  var repos = await getTrendingRepositories();
  print(repos[0].owner);

  // specify time period
  var weeklyRepos =
      await getTrendingRepositories(since: TrendingRepositorySince.weekly);
  print(weeklyRepos[0].name);

  // specify language
  var dartRepos = await getTrendingRepositories(language: 'dart');
  print(dartRepos[0].primaryLanguage.name);
}
