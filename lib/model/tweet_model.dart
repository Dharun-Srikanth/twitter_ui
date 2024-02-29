import 'package:twitter_ui/model/user_model.dart';

class TweetModel {
  late int id;
  String tweet;
  UserModel user;
  int likeCount;

  TweetModel(this.tweet, this.user, this.likeCount);

  factory TweetModel.fromJson(Map<String, dynamic> data) =>
      TweetModel(data['tweet'], data['user'], data['likes']);

  Map<String, dynamic> toJson() => {
    "tweet": tweet,
    "user_id": user.id,
    "like_count": likeCount
  };
}