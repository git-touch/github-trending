import 'package:github_trending/github_trending.dart';
import 'package:test/test.dart';

void main() {
  List<TrendingRepository> items;

  group('get trending repositories', () {
    setUpAll(() async {
      items = await getTrendingRepositories();
    });

    test('has data', () {
      expect(items, isList);
    });

    test('owner, name are not null', () {
      items.forEach((item) {
        expect(item.owner, isNotNull);
        expect(item.name, isNotNull);
      });
    });

    test('star and fork count', () {
      // make sure at least one item has star or fork
      // to ensure no parse error
      var itemHasStar = items.where((item) => item.starCount != null);
      expect(itemHasStar, isNotEmpty);

      var itemHasFork = items.where((item) => item.forkCount != null);
      expect(itemHasFork, isNotEmpty);
    });

    test('primary language', () {
      items.forEach((item) {
        if (item.primaryLanguage != null) {
          expect(item.primaryLanguage.name, isNotNull);

          // CSS color format
          // print(item.primaryLanguage.color);
          expect(
              RegExp(r'#[0-9a-fA-F]{3,6}').hasMatch(item.primaryLanguage.color),
              isTrue);
        }
      });
    });
  });

  group('specify language', () {
    setUpAll(() async {
      items = await getTrendingRepositories(language: 'dart');
    });

    test('correct language', () {
      items.forEach((item) {
        expect(item.primaryLanguage, isNotNull);
        expect(item.primaryLanguage.name, equals('Dart'));
      });
    });
  });
}
