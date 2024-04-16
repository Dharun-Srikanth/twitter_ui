

import 'package:twitter_ui/domain/models/tweet_model.dart';
import 'package:twitter_ui/domain/models/user_model.dart';

class Comments {
  int id;
  String comment;
  UserModel user;
  TweetModel tweet;

  Comments(this.id, this.comment, this.user, this.tweet);

  factory Comments.fromJson(Map<String, dynamic> data) =>
      Comments(data['id'], data['comment'], data['user'], data['tweet']);

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "user_id": user.id,
    "tweet_id": tweet.id,
  };
}