import 'package:flutter/material.dart';
import 'package:twitter_ui/presentation/widgets/add_tweet_design.dart';
import 'package:twitter_ui/presentation/widgets/primary_button.dart';

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
