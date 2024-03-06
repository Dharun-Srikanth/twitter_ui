import 'package:twitter_ui/model/tweet_model.dart';
import 'package:twitter_ui/model/user_model.dart';

class LikedTweets {
  int id;
  TweetModel tweet;
  UserModel user;

  LikedTweets({required this.id, required this.tweet, required this.user});

  factory LikedTweets.fromJson(Map<String, dynamic> data) => LikedTweets(
      id: data['id'], tweet: data['tweet_id'], user: data['user_id']);

  Map<String, dynamic> toJson() =>
      {"id": id, "tweet_id": tweet.id, "user_id": user.id};
}
