import 'package:twitter_ui/domain/models/comments.dart';
import 'package:twitter_ui/domain/models/liked_tweets.dart';
import 'package:twitter_ui/domain/models/tweet_details.dart';
import 'package:twitter_ui/domain/models/tweet_model.dart';
import 'package:twitter_ui/domain/models/user_model.dart';

abstract class DbRepoInterface {
  Future<UserModel?> login(String username, String password);
  Future<UserModel> addUser(UserModel user);
  Future<List<TweetDetails>> getAllDetails();
  void addTweet(TweetModel tweetModel);
  void addComment(Comments comments);
  void addLikedTweets(LikedTweets likedTweets);
  void removeLikedTweets(int id);
  void addLikes(int id);
  void removeLikes(int id);
  Future<TweetModel?> getTweet(int id);
  void deleteTweet(int id);
  void updateTweet(int id, String tweet);
}