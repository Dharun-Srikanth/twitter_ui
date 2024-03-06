import 'dart:convert';

import 'package:get/get.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/model/tweet_model.dart';
import 'package:twitter_ui/model/tweets.dart';
import 'package:http/http.dart' as http;

// Future<List<TweetModel>> fetchTweets() async {
//     List<TweetModel> values = await constDbHelper.getTweets();
//     if (values.isNotEmpty) {
//       print("from adding area: "+values[0].user.username.toString());
//       Future.delayed(Duration(seconds: 5), () => Get.find<DataController>().insertIntoDbTweet(values.reversed.toList()));
//     }
//     return values;
// }

// Future<List<Tweets>> fetchTweets() async {
//   final response = await http.get(Uri.parse('https://dummyjson.com/posts?limit=100'));
//   if (response.statusCode == 200) {
//     var jsonData = json.decode(response.body);
//     List<dynamic> values = jsonData['posts'];
//     if (values.isNotEmpty) {
//       for (int i = 0; i < values.length; i++) {
//         if (values[i] != null) {
//           Map<String, dynamic> map = values[i];
//           Get.find<DataController>().addTweetsData(Tweets.fromJson(map));
//           // _tweets.insert(0,Tweets.fromJson(map));
//         }
//       }
//     }
//     return DataController().tweetList;
//   } else {
//     throw Exception("Failed to load tweets");
//   }
// }
