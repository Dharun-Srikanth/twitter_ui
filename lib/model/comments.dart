import 'package:twitter_ui/model/tweet_model.dart';
import 'package:twitter_ui/model/user_model.dart';

class Comments {
  String comment;
  UserModel user;
  TweetModel tweet;

  Comments(this.comment, this.user, this.tweet);

  factory Comments.fromJson(Map<String, dynamic> data) =>
      Comments(data['comment'], data['user'], data['tweet']);

  Map<String, dynamic> toJson() => {
    "comment": comment,
    "user": user,
    "tweet": tweet,
  };
}