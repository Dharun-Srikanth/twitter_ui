import 'dart:math';

import 'package:get/get.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/model/user.dart';
import 'package:twitter_ui/model/user_model.dart';

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
