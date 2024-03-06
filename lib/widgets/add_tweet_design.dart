import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/db/db_helper.dart';
import 'package:twitter_ui/model/comments.dart';
import 'package:twitter_ui/model/tweet_model.dart';
import 'package:twitter_ui/model/user_model.dart';

class AddTweetDesign extends StatelessWidget {
  AddTweetDesign(this.actionId, {super.key});
  final int actionId;
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: addTweetFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          validator: (value) {
            if(value == null || value.isEmpty) {
              return "Write something";
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: actionId==0 ? addTweetController : addCommentController,
          minLines: 1,
          maxLines: 1000,
          autofocus: true,
          decoration: InputDecoration(
              isDense: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: CircleAvatar(
                  foregroundImage: AssetImage("assets/ME.jpg"),
                  backgroundColor: Colors.black,
                ),
              ),
              border: InputBorder.none,
              hintText: actionId == 0 ?  "What's happening?": "Post your reply",
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }



  void addTweet() async {
    print(addTweetController.text);
    if(addTweetFormKey.currentState!.validate()){
      TweetModel tweetModel = TweetModel(UniqueKey().hashCode, addTweetController.text, loggedInUser!, 0);
      Future<TweetModel> tweet = constDbHelper.addTweet(tweetModel);
      constDataController.setData();
      addTweetController.text = "";
    }
  }

  void addComment(int id) async {
    TweetModel? tweet = await constDbHelper.getTweet(id);
    print(addTweetFormKey.currentState.isBlank);
    if(addTweetFormKey.currentState!.validate()){
      Comments comments = Comments(UniqueKey().hashCode, addCommentController.text, loggedInUser!, tweet!);
      constDbHelper.addComments(comments);
      constDataController.setData();
      addCommentController.text = "";
    }
  }
}
