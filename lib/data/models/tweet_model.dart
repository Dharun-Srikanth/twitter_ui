import 'dart:math';

import 'package:get/get.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/data/models/user_model.dart';

class TweetModel {
  late int id;
  String tweet;
  UserModel user;
  int likeCount;

  TweetModel(this.id, this.tweet, this.user, this.likeCount);

  factory TweetModel.fromJson(Map<String, dynamic> data) {
    return TweetModel(data['id'], data['tweet'], loggedInUser!, data['like_count']);
  }

  Map<String, dynamic> toJson() =>
      {"tweet": tweet, "user_id": user.id, "like_count": likeCount};
}
