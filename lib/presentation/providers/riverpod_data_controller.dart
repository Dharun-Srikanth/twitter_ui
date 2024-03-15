import 'package:flutter/cupertino.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/data/models/tweet_details.dart';

class RiverpodController extends ChangeNotifier{
  List<TweetDetails> allTweets = <TweetDetails>[];
  bool isDB = true;
  List<String> notificationList = <String>[];

  void loadFromAPI() {
    isDB = false;
    notifyListeners();
  }

  void loadFromDB() {
    isDB = true;
    notifyListeners();
  }

  void setData() async {
    allTweets = await constDbHelper.getAllDetails();
    notifyListeners();
  }

  void addNotifications(String content) {
    notificationList.add(content);
    notifyListeners();
  }
}