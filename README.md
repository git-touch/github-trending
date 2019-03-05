# github_trending

A library to get GitHub trending repositories for Dart and Flutter developers.

## Installation

Add `github_trending` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages)

## Usage

```dart
import 'package:github_trending/github_trending.dart';

main() async {
  // get trending repositories
  var repos = await getTrendingRepositories();
  print(repos[0].owner);

  // specify time period
  var weeklyRepos = await getTrendingRepositories(since: TrendingRepositorySince.weekly);
  print(weeklyRepos[0].name);

  // specify language
  var dartRepos = await getTrendingRepositories(language: 'dart');
  print(dartRepos[0].primaryLanguage.name);
}
```

## License

MIT
