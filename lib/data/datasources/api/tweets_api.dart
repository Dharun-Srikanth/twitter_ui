import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/data/models/tweet_model.dart';
import 'package:twitter_ui/data/models/tweets.dart';
import 'package:twitter_ui/presentation/providers/data_controller.dart';

// Future<List<TweetModel>> fetchTweets() async {
//     List<TweetModel> values = await constDbHelper.getTweets();
//     if (values.isNotEmpty) {
//       print("from adding area: ${values[0].user.username}");
//       Future.delayed(const Duration(seconds: 5), () => Get.find<DataController>().insertIntoDbTweet(values.reversed.toList()));
//     }
//     return values;
// }

Future<List<Tweets>> fetchTweets() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/posts?limit=100'));
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

final tweetsProvider = FutureProvider<List<Tweets>>((ref) async {
  return fetchTweets();
});
