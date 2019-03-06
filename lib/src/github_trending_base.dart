import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class TrendingRepositorySince {
  static const daily = 'daily';
  static const weekly = 'weekly';
  static const monthly = 'monthly';
}

class TrendingRepository {
  String owner;
  String name;
  String description;
  String descriptionHTML;
  int starCount;
  int forkCount;
  TrendingRepositoryPrimaryLanguage primaryLanguage;

  TrendingRepository({
    this.owner,
    this.name,
    this.description,
    this.descriptionHTML,
    this.starCount,
    this.forkCount,
    this.primaryLanguage,
  });
}

class TrendingRepositoryPrimaryLanguage {
  String name;
  String color;
  TrendingRepositoryPrimaryLanguage({this.name, this.color});
}

Future<List<TrendingRepository>> getTrendingRepositories({
  String since,
  String language,
}) async {
  var url = 'https://github.com/trending';
  if (language != null) {
    url += '/$language';
  }
  if (since != null) {
    url += '?since=$since';
  }

  var res = await http.get(url);
  var document = parse(res.body);
  var items = document.querySelectorAll('.repo-list>li');

  return items.map((item) {
    TrendingRepositoryPrimaryLanguage primaryLanguage;
    var colorNode = item.querySelector('.repo-language-color');

    if (colorNode != null) {
      primaryLanguage = TrendingRepositoryPrimaryLanguage(
          name: colorNode.nextElementSibling?.innerHtml?.trim(),
          color: RegExp(r'(#\w{6})')
              .firstMatch(colorNode.attributes['style'])
              .group(0));
    }

    var starCountStr = item.children[3]
        .querySelector('.octicon-star')
        ?.parent
        ?.innerHtml
        ?.replaceFirst(RegExp(r'^[\s\S]*svg>'), '')
        ?.replaceAll(',', '')
        ?.trim();

    var starCount = starCountStr == null ? null : int.tryParse(starCountStr);

    var forkCountStr = item
        .querySelector('.octicon-repo-forked')
        ?.parent
        ?.innerHtml
        ?.replaceFirst(RegExp(r'^[\s\S]*svg>'), '')
        ?.replaceAll(',', '')
        ?.trim();
    var forkCount = forkCountStr == null ? null : int.tryParse(forkCountStr);

    String description;
    String descriptionHTML;
    var descriptionRawHtml =
        item.children[2].querySelector('p')?.innerHtml?.trim();
    if (descriptionRawHtml != null) {
      description = descriptionRawHtml
          ?.replaceAll(RegExp(r'<g-emoji.*?>'), '')
          ?.replaceAll(RegExp(r'</g-emoji>'), '')
          ?.replaceAll(RegExp(r'<a.*?>'), '')
          ?.replaceAll(RegExp(r'</a>'), '');
      descriptionHTML = '<div>$descriptionRawHtml</div>';
    }

    return TrendingRepository(
      owner: item
          .querySelector('h3>a>span')
          ?.innerHtml
          ?.replaceFirst('/', '')
          ?.trim(),
      name: item
          .querySelector('h3>a')
          ?.innerHtml
          ?.replaceFirst(RegExp(r'^[\s\S]*span>'), '')
          ?.trim(),
      description: description,
      descriptionHTML: descriptionHTML,
      starCount: starCount,
      forkCount: forkCount,
      primaryLanguage: primaryLanguage,
    );
  }).toList();
}
