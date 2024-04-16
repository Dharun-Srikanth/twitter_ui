import 'dart:convert';

import 'package:http/http.dart';
import 'package:twitter_ui/domain/models/tweets.dart';

Future<List<Tweets>> fetchTweets() async {
  final response = await get(Uri.parse('https://dummyjson.com/posts?limit=100'));
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    List<dynamic> values = jsonData['posts'];
    List<Tweets> tweetList = [];
    if (values.isNotEmpty) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          tweetList.add(Tweets.fromJson(map));
          // _tweets.insert(0,Tweets.fromJson(map));
        }
      }
    }
    return tweetList;
  } else {
    throw Exception("Failed to load tweets");
  }
}
