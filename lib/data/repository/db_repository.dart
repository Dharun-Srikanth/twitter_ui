import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_ui/data/datasources/db/db_helper.dart';
import 'package:twitter_ui/domain/models/comments.dart';
import 'package:twitter_ui/domain/models/liked_tweets.dart';
import 'package:twitter_ui/domain/models/tweet_details.dart';
import 'package:twitter_ui/domain/models/tweet_model.dart';
import 'package:twitter_ui/domain/models/user_model.dart';
import 'package:twitter_ui/domain/repository_interface/db_repository_interface.dart';
import 'package:twitter_ui/presentation/providers/db_data_provider.dart';

class DbRepo implements DbRepoInterface {
  final DBHelper _dbHelper;

  DbRepo(this._dbHelper);

  @override
  Future<List<TweetDetails>> getAllDetails() async{
    return await _dbHelper.getAllDetails();
  }

  @override
  void addTweet(TweetModel tweetModel) async {
    await _dbHelper.addTweet(tweetModel);
  }

  void fetchProviderData(WidgetRef ref) {
    return ref.refresh(allTweetProvider);
  }

  @override
  void addComment(Comments comments) async {
    await _dbHelper.addComments(comments);
  }

  @override
  void addLikedTweets(LikedTweets likedTweets)async {
    await _dbHelper.addLikedTweets(likedTweets);
  }

  @override
  void addLikes(int id)async {
    await _dbHelper.addLikes(id);
  }

  @override
  void removeLikedTweets(int id) async {
    await _dbHelper.removeLikedTweets(id);
  }

  @override
  void removeLikes(int id) async {
    await _dbHelper.removeLikes(id);
  }

  @override
  Future<TweetModel?> getTweet(int id)async {
    return await _dbHelper.getTweet(id);
  }

  @override
  Future<UserModel?> login(String username, String password) async{
    return await _dbHelper.getLogIn(username, password);
  }

  @override
  void deleteTweet(int id) async {
    await _dbHelper.delete(id);
  }

  @override
  void updateTweet(int id, String tweet) async {
    await _dbHelper.updateTweet(id, tweet);
  }

  @override
  Future<UserModel> addUser(UserModel user) async {
    return await _dbHelper.addUser(user);
  }
}