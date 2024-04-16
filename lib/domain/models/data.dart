import 'package:get/get.dart';
import 'package:twitter_ui/domain/models/tweet_details.dart';
import 'package:twitter_ui/domain/models/tweets.dart';
import 'package:twitter_ui/domain/models/user.dart';
import 'package:twitter_ui/domain/models/user_model.dart';

class DataModel {
  List<Tweets> tweetList = [];
  List<User> userList = [];
  List<TweetDetails> detailList = [];
  RxList<TweetDetails> allDbTweets = <TweetDetails>[].obs;
  Rx<UserModel>? dbSingleUser;


  void addTweetFromDB(List<TweetDetails> tweetList){
    allDbTweets.addAll(tweetList);
  }

  // void addUserTweet(TweetModel tweetModel) {
  //   allDbTweets.insert(0, tweetModel);
  // }



  void addTweet(Tweets tweets){
    tweetList.insert(0, tweets);
  }

  void addUser(User user) {
    userList.insert(0,user);
  }

  void addDetails(TweetDetails tweetDetails){
    detailList.insert(0, tweetDetails);
  }

  void addData(List<TweetDetails> tweetDetails) {
    detailList.addAll(tweetDetails);
  }

  void getUserFromDB(UserModel userModel){
    dbSingleUser = userModel.obs;
  }
}