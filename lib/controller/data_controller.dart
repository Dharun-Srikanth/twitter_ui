import 'package:get/get.dart';
import 'package:twitter_ui/model/data.dart';
import 'package:twitter_ui/model/tweet_details.dart';
import 'package:twitter_ui/model/tweets.dart';
import 'package:twitter_ui/model/user.dart';

class DataController extends GetxController {
  final DataModel _dataModel = DataModel();

  List<Tweets> get tweetList => _dataModel.tweetList;
  List<User> get userList => _dataModel.userList;
  List<TweetDetails> get detailsList => _dataModel.detailList;

  void addTweetsData(Tweets tweets) {
    _dataModel.addTweet(tweets);
    update();
  }

  void addUserData(User user) {
    _dataModel.addUser(user);
    update();
  }

  void addDetailsData(TweetDetails tweetDetails) {
    _dataModel.addDetails(tweetDetails);
    update();
  }

  void addAPIData(List<TweetDetails> tweetDetails) {
    _dataModel.addData(tweetDetails);
  }
}