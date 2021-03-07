import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class GithubTrendingRepository {
  String? author;
  String? name;
  String? avatar;
  String? url;
  String? description;
  String? language;
  String? languageColor;
  int? stars;
  int? forks;
  int? currentPeriodStars;
  List<GithubTrendingRepositoryBuiltBy>? builtBy;
  GithubTrendingRepository();
  factory GithubTrendingRepository.fromJson(Map<String, dynamic> json) =>
      _$GithubTrendingRepositoryFromJson(json);
}

@JsonSerializable()
class GithubTrendingRepositoryBuiltBy {
  String? href;
  String? avatar;
  String? username;
  GithubTrendingRepositoryBuiltBy();
  factory GithubTrendingRepositoryBuiltBy.fromJson(Map<String, dynamic> json) =>
      _$GithubTrendingRepositoryBuiltByFromJson(json);
}

@JsonSerializable()
class GithubTrendingDeveloper {
  String? username;
  String? name;
  String? type;
  String? url;
  String? avatar;
  GithubTrendingDeveloperRepository? repo;
  GithubTrendingDeveloper();
  factory GithubTrendingDeveloper.fromJson(Map<String, dynamic> json) =>
      _$GithubTrendingDeveloperFromJson(json);
}

@JsonSerializable()
class GithubTrendingDeveloperRepository {
  String? name;
  String? description;
  String? url;
  GithubTrendingDeveloperRepository();
  factory GithubTrendingDeveloperRepository.fromJson(
          Map<String, dynamic> json) =>
      _$GithubTrendingDeveloperRepositoryFromJson(json);
}
