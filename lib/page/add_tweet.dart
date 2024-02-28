import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/model/tweet_details.dart';
import 'package:twitter_ui/model/tweets.dart';
import 'package:twitter_ui/model/user.dart';
import 'package:twitter_ui/widgets/add_tweet_design.dart';
import 'package:twitter_ui/widgets/primary_button.dart';
import 'package:twitter_ui/widgets/tweets_layout.dart';

class AddTweet extends StatelessWidget {
  const AddTweet({super.key, required this.actionId});
  final int actionId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_sharp, size: 32,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButton(title: actionId == 1 ? "Post" : "Reply",
                onPressed: (){
                  DataController dataController = Get.find<DataController>();
                  if(actionId == 1){
                    Tweets tweets = Tweets(id: UniqueKey().hashCode, userId: 101, tweet: addTweetController.text, likes: 0, comments: []);
                    User user = User(id: 101, name: "Dharun", username: "DRN", likedTweets: []);
                    dataController.addTweetsData(tweets);
                    dataController.addUserData(user);
                    dataController.addDetailsData(TweetDetails(user: user, tweets: tweets));
                  }else{
                    List<Tweets> tweets = dataController.tweetList;
                    int index = tweets.indexWhere((element) => element.id == actionId);
                    dataController.tweetList[index].comments.add(addCommentController.text);
                    print(dataController.tweetList[index].comments);
                  }

                  addTweetController.text = "";
                  addCommentController.text = "";
                  // TweetsLayout(tweetDetails: TweetDetails(user: user, tweets: tweets),);
                  Navigator.pop(context);
                }),
          )
        ],
      ),
      body: AddTweetDesign(actionId),
    );
  }
}
