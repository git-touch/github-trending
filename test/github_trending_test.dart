import 'package:github_trending/github_trending.dart';
import 'package:test/test.dart';

void main() {
  List<TrendingRepository> items;

  group('get trending repositories', () {
    setUp(() async {
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

    test('primary language', () {
      items.forEach((item) {
        if (item.primaryLanguage != null) {
          expect(item.primaryLanguage.name, isNotNull);
          expect(
              RegExp(r'(#\w{6})').hasMatch(item.primaryLanguage.color), isTrue);
        }
      });
    });
  });
}
