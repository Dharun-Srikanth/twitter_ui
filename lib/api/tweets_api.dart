import 'dart:convert';

import 'package:get/get.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/model/tweets.dart';
import 'package:http/http.dart' as http;

Future<List<Tweets>> fetchTweets() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/posts?limit=100'));
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    List<dynamic> values = jsonData['posts'];
    if (values.isNotEmpty) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          Get.find<DataController>().addTweetsData(Tweets.fromJson(map));
          // _tweets.insert(0,Tweets.fromJson(map));
        }
      }
    }
    return DataController().tweetList;
  } else {
    throw Exception("Failed to load tweets");
  }
}
