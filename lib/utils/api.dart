import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart';

// import 'package:html_parser_plus/html_parser_plus.dart';

String preserveTextWithNewlines(Element element) {
  final buffer = StringBuffer();

  for (var node in element.nodes) {
    if (node is Text) {
      // Append text content
      buffer.write(node.text);
    } else if (node is Element) {
      if (node.localName == 'br') {
        // Add newline for <br> tags
        buffer.write('\n');
      } else {
        // Recursively process child elements
        buffer.write(preserveTextWithNewlines(node));
      }
    }
  }

  return buffer.toString();
}

Future<String> fetchUrlFromKeyword(String keyword) async {
  String encoded_keyword = Uri.encodeComponent(keyword);

  try {
    http.Response res = await http.get(Uri.parse(
        'https://genius.com/api/search/multi?per_page=5&q=${encoded_keyword}'));

    Map<String, dynamic> jsonData = jsonDecode(res.body);

    String dataResponse =
        jsonData['response']['sections'][0]['hits'][0]['result']['url'];

    return dataResponse;
  } catch (e) {
    print(e.toString());
    return "";
  }
}

Future<String> fetchLyricsFromUrl(String url) async {
  const String lyricContainerSelector = 'div[data-lyrics-container="true"]';

  try {
    http.Response res = await http.get(Uri.parse(url));
    String html = res.body;

    // final parser = HtmlParser();
    Document document = parse(html);
    // HtmlParserNode document = parser.parse(html);
    List<Element> arr = document.querySelectorAll(lyricContainerSelector);
    // var arr = document.query();

    // parser.queryNodes

    if (arr == null || arr.isEmpty) {
      return "";
    }

    // print(arr);

    // List<String> arrStr = arr.map((ele) => ele.text).toList();

    // print(arrStr);

    // console.log(obj.outerHTML)

    String str = "";

    for (var element in arr) {
      // statements
      str += preserveTextWithNewlines(element);
      str += Platform.lineTerminator;
    }

    return str;
  } catch (e) {
    print('error in lyrics fetching');
    return "";
  }
}

Future<String> fetchLyrics(String keyword) async {
  // http.Response res = await http
  //     .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  // print('resbody: ${res.body}');

  // String keyword = "Linkin Park Numb";

  String url = await fetchUrlFromKeyword(keyword);
  String lyrics = await fetchLyricsFromUrl(url);

  return lyrics;

  // print(lyrics);
}
