import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/model/tweet_details.dart';
import 'package:twitter_ui/model/tweet_model.dart';
import 'package:twitter_ui/model/tweets.dart';
import 'package:twitter_ui/model/user.dart';
import 'package:twitter_ui/widgets/add_tweet_design.dart';
import 'package:twitter_ui/widgets/primary_button.dart';
import 'package:twitter_ui/widgets/tweets_layout.dart';

class AddTweet extends StatelessWidget {
  AddTweet({super.key, required this.actionId});

  final int actionId;
  final AddTweetDesign addTweetDesign = AddTweetDesign(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close_sharp,
            size: 32,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButton(
                title: actionId == 0 ? "Post" : "Reply",
                onPressed: () {
                  if (actionId == 0) {
                    addTweetDesign.addTweet();
                  } else {
                    addTweetDesign.addComment(actionId);
                  }
                  Navigator.pop(context);
                }),
          )
        ],
      ),
      body: AddTweetDesign(actionId),
    );
  }
}
