import 'dart:ffi';

import 'package:get/get.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/model/data.dart';
import 'package:twitter_ui/model/liked_tweets.dart';
import 'package:twitter_ui/model/tweet_details.dart';
import 'package:twitter_ui/model/tweet_model.dart';
import 'package:twitter_ui/model/tweets.dart';
import 'package:twitter_ui/model/user.dart';
import 'package:twitter_ui/model/user_model.dart';

class DataController extends GetxController {
  RxList<TweetDetails> allTweetContent = <TweetDetails>[].obs;
  RxList<TweetDetails> currentUserTweets = <TweetDetails>[].obs;
  RxList<TweetDetails> currentUserLikedTweets = <TweetDetails>[].obs;
  RxList<TweetDetails> currentUserReplies = <TweetDetails>[].obs;

  void setData() async {
    allTweetContent.value = await constDbHelper.getAllDetails();
    update();
  }

  void setUserTweet() async {
    currentUserTweets.value = allTweetContent.where((element) => element.userDetails.id==loggedInUser!.id).toList();
    update();
  }

  void setUserLikedTweet() async {
    currentUserLikedTweets.value = allTweetContent.where((element) => element.userDetails.id==loggedInUser!.id && element.isLiked).toList();
    update();
  }

  void setUserReplies() async {
    currentUserReplies.value = allTweetContent.where((element) => element.userDetails.id==loggedInUser!.id && element.comments.isNotEmpty).toList();
    update();
  }
}