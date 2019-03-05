import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class TrendingRepository {
  String owner;
  String name;
  String description;
  int starCount;
  int forkCount;
  String primaryLanguageName;
  String primaryLanguageColor;

  TrendingRepository({
    this.owner,
    this.name,
    this.description,
    this.starCount,
    this.forkCount,
    this.primaryLanguageName,
    this.primaryLanguageColor,
  });
}

Future<List<TrendingRepository>> getTrendingRepositories() async {
  var res = await http.get('https://github.com/trending');
  var document = parse(res.body);
  var items = document.querySelectorAll('.repo-list>li');

  return items.map((item) {
    String primaryLanguageName;
    String primaryLanguageColor;
    var colorNode = item.querySelector('.repo-language-color');

    if (colorNode != null) {
      primaryLanguageName = colorNode.nextElementSibling?.innerHtml?.trim();
      primaryLanguageColor = RegExp(r'(#\w{6})')
          .firstMatch(colorNode.attributes['style'])
          .group(0);
    }

    var starCountStr = item.children[3]
        .querySelector('.octicon-star')
        ?.parent
        ?.innerHtml
        ?.replaceFirst(RegExp(r'^[\s\S]*svg>'), '')
        ?.trim();
    var starCount = starCountStr == null ? null : int.tryParse(starCountStr);

    var forkCountStr = item
        .querySelector('.octicon-repo-forked')
        ?.parent
        ?.innerHtml
        ?.replaceFirst(RegExp(r'^[\s\S]*svg>'), '')
        ?.trim();
    var forkCount = forkCountStr == null ? null : int.tryParse(forkCountStr);

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
      description: item.children[2]
          .querySelector('p')
          ?.innerHtml
          ?.trim()
          ?.replaceAll(RegExp(r'<g-emoji.*?>'), '') // TODO: emoji
          ?.replaceAll(RegExp(r'</g-emoji>'), ''),
      starCount: starCount,
      forkCount: forkCount,
      primaryLanguageName: primaryLanguageName,
      primaryLanguageColor: primaryLanguageColor,
    );
  }).toList();
}
