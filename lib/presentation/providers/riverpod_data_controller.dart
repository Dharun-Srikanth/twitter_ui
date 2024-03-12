import 'package:flutter/cupertino.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/data/models/tweet_details.dart';

class RiverpodController extends ChangeNotifier{
  List<TweetDetails> allTweetContent = <TweetDetails>[];
  bool isDB = true;

  void loadFromAPI() {
    isDB = false;
    notifyListeners();
  }

  void loadFromDB() {
    isDB = true;
    notifyListeners();
  }

  void setData() async {
    allTweetContent = await constDbHelper.getAllDetails();
    notifyListeners();
  }
}