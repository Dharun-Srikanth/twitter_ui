import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/model/liked_tweets.dart';
import 'package:twitter_ui/model/tweet_details.dart';
import 'package:twitter_ui/model/tweet_model.dart';
import 'package:twitter_ui/model/tweets.dart';
import 'package:twitter_ui/page/add_tweet.dart';

class ProfilePageDesign extends StatelessWidget {
  const ProfilePageDesign({super.key});

  loadData() {
    constDataController.setData();
    constDataController.setUserTweet();
    constDataController.setUserLikedTweet();
    constDataController.setUserReplies();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          Container(
            height: 140,
            color: Colors.black12,
          ),
          Container(
            height: 100,
            color: Colors.blue,
          ),
          const Positioned(
            top: 50,
            left: 4,
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 40,
                foregroundImage: AssetImage("assets/ME.jpg"),
              ),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loggedInUser!.name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "@${loggedInUser!.username}",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Born February 30, 2023 \nJoined February 31, 2024",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: const TextSpan(
                text: "3",
                style: TextStyle(color: Colors.white, fontSize: 18),
                children: [
                  TextSpan(
                      text: " Following",
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  TextSpan(
                      text: "\t 1",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      children: [
                        TextSpan(
                            text: " Follower",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                      ])
                ],
              )),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(tabs: [
                    Tab(
                      child: Text(
                        "Posts",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Replies",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Likes",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ]),
                  Expanded(
                    child: TabBarView(children: [
                      Center(child:
                          GetBuilder<DataController>(builder: (controller) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                constDataController.currentUserTweets.length,
                            itemBuilder: (BuildContext context2, int index) {
                              // return tweetsDesignLayout(controller.detailsList[index]);
                              return dbTweetsDesignLayout(
                                  constDataController.currentUserTweets[index],
                                  context2);
                            });
                      })),
                      Center(child:
                          GetBuilder<DataController>(builder: (controller) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                constDataController.currentUserReplies.length,
                            itemBuilder: (BuildContext context2, int index) {
                              // return tweetsDesignLayout(controller.detailsList[index]);
                              return dbTweetsDesignLayout(
                                  constDataController.currentUserReplies[index],
                                  context2);
                            });
                      })),
                      Center(child:
                          GetBuilder<DataController>(builder: (controller) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: constDataController
                                .currentUserLikedTweets.length,
                            itemBuilder: (BuildContext context2, int index) {
                              // return tweetsDesignLayout(controller.detailsList[index]);
                              return dbTweetsDesignLayout(
                                  constDataController
                                      .currentUserLikedTweets[index],
                                  context2);
                            });
                      })),
                    ]),
                  )
                ],
              )),
        ),
      ],
    );
  }

  Widget dbTweetsDesignLayout(TweetDetails tweetModel, BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey.shade800, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                foregroundImage: tweetModel.userDetails.id == loggedInUser!.id
                    ? const AssetImage("assets/ME.jpg")
                    : const AssetImage("assets/profile.png"),
                backgroundColor: Colors.black,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tweetModel.userDetails.name,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      const Icon(
                        Icons.verified,
                        size: 18.0,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "@${tweetModel.userDetails.username}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tweetModel.tweet['tweet'],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                            text: TextSpan(children: [
                          WidgetSpan(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddTweet(
                                            actionId: tweetModel.tweet['id']),
                                      ));
                                },
                                icon: const Icon(
                                  Icons.mode_comment_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                              text: tweetModel.comments.length.toString(),
                              style: const TextStyle(color: Colors.grey))
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          WidgetSpan(
                              child: IconButton(
                                onPressed: () {
                                  if (tweetModel.isLiked) {
                                    constDbHelper.removeLikedTweets(
                                        tweetModel.tweet['id']);
                                    constDbHelper
                                        .removeLikes(tweetModel.tweet['id']);
                                    loadData();
                                  } else {
                                    TweetModel tweet = TweetModel(
                                        tweetModel.tweet['id'],
                                        tweetModel.tweet['tweet'],
                                        tweetModel.userDetails,
                                        tweetModel.tweet['like_count']);
                                    constDbHelper.addLikedTweets(LikedTweets(
                                        id: UniqueKey().hashCode,
                                        tweet: tweet,
                                        user: loggedInUser!));
                                    constDbHelper
                                        .addLikes(tweetModel.tweet['id']);
                                    loadData();
                                  }
                                },
                                icon: tweetModel.isLiked
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.pinkAccent,
                                      )
                                    : const Icon(Icons.favorite_outline),
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                              text: tweetModel.tweet['like_count'].toString(),
                              style: TextStyle(color: Colors.grey))
                        ])),
                        const Icon(
                          Icons.share_outlined,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
