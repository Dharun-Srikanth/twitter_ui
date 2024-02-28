import 'package:twitter_ui/model/tweet_details.dart';
import 'package:twitter_ui/model/tweets.dart';
import 'package:twitter_ui/model/user.dart';

class DataModel {
  List<Tweets> tweetList = [];
  List<User> userList = [];
  List<TweetDetails> detailList = [];

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
}