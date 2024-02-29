import 'dart:math';

import 'package:flutter/material.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/db/db_helper.dart';
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
        child: TextFormField(
          validator: (value) {
            if(value == null || value.isEmpty) {
              return "Write something";
            }
            return null;
          },
          controller: actionId==1 ? addTweetController : addCommentController,
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
              hintText: actionId == 1 ?  "What's happening?": "Post your reply",
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }

  void addTweet() {
    if(addTweetFormKey.currentState!.validate()){
      TweetModel tweetModel = TweetModel(addTweetController.text, loggedInUser!, 0);
      Future<TweetModel> tweet = dbHelper.addTweet(tweetModel);
      print(loggedInUser!.id);
      print(tweet);
    }
  }
}
