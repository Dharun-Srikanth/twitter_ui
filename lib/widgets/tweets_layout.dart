import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/api/tweets_api.dart';
import 'package:twitter_ui/api/user_api.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/model/tweet_details.dart';
import 'package:twitter_ui/model/tweet_model.dart';
import 'package:twitter_ui/page/add_tweet.dart';
import '../model/tweets.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class TweetsLayout extends StatefulWidget {
  const TweetsLayout({super.key, this.tweetDetails});
  final TweetDetails? tweetDetails;
  @override
  State<TweetsLayout> createState() => _TweetsState();
}

class _TweetsState extends State<TweetsLayout> {
  final DataController dataController = Get.find<DataController>();

  final List<TweetDetails> _tweetValues = [];


  final _tweetCount = 30;
  final _tweetsPerPage = 5;
  int _currentPage = 0;
  int _tweetIndex = 0;

  bool _isLoading = true;
  bool _hasMore = true;



  Future<List<TweetDetails>> fetch() async {
    print(dataController.tweetList);
    final list = <TweetDetails>[];
    final n = min(_tweetsPerPage, _tweetCount - _currentPage * _tweetsPerPage);
    await Future.delayed(const Duration(seconds: 1), () {
      int index;
      for (int i = 0; i < n; i++) {
        index = dataController.userList
            .indexWhere((element) => element.id == dataController.tweetList[_tweetIndex].userId);
        list.add(TweetDetails.fromJson(dataController.tweetList[_tweetIndex], dataController.userList[index]));
        _tweetIndex++;
        print(index);
      }
    });
    _currentPage++;
    return list;
  }

  void loadMore() {
    print("Hello");
    _isLoading = true;
    fetch().then((List<TweetDetails> tweetList) {
      print(tweetList);
      if (tweetList.isEmpty) {
        print("tweetList");
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() async {
          _isLoading = false;
          Get.find<DataController>().addAPIData(tweetList);
          List<TweetModel> list = await dbTweets;
          Get.find<DataController>().insertIntoDbTweet(list);
          print(list[0].user.name);
          print("dataController.tweetList");
          // _tweetValues.addAll(tweetList);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTweets();
    fetchUser();
    Future.delayed(const Duration(seconds: 5), () {
      loadMore();
    });
    _isLoading = true;
    _hasMore = true;
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DataController>(
      builder: (controller){
        return ListView.builder(
          shrinkWrap: true,
            controller: hideScrollController,
            itemCount: _hasMore ? controller.detailsList.length + 1 : controller.detailsList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index >= controller.detailsList.length) {
                if (!_isLoading) {
                  loadMore();
                }
                return const Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return tweetsDesignLayout(controller.detailsList[index]);
            });
      },
    );
  }

  addLikes(Tweets tweets, bool isUserLiked, User user) {
    int index = dataController.tweetList.indexOf(tweets);
    if (!isUserLiked) {
      dataController.tweetList[index].likes = dataController.tweetList[index].likes+1;
      user.likedTweets.add(tweets);
    } else {
      dataController.tweetList[index].likes = dataController.tweetList[index].likes-1;
      user.likedTweets.remove(tweets);
    }
  }


  Widget tweetsDesignLayout(TweetDetails tweetModel) {
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
                foregroundImage: tweetModel.user.id == 101 ? AssetImage("assets/ME.jpg") : AssetImage("assets/barath.jpg"),
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
                        tweetModel.user.name,
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
                        "@${tweetModel.user.username}",
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      IconButton(onPressed: (){
                        showModalBottomSheet(context: context, builder: (BuildContext context)=>
                          Padding(padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: TextButton(
                            onPressed: (){},
                            child: const Text("Edit"),
                          ),)
                        );
                      }, icon: const Icon(Icons.more_vert))
                    ],
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tweetModel.tweets.tweet,
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
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddTweet(actionId: tweetModel.tweets.id),));
                                },
                                icon: const Icon(
                                  Icons.mode_comment_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                              text:
                                  tweetModel.tweets.comments.length.toString(),
                              style: const TextStyle(color: Colors.grey))
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          const WidgetSpan(
                              child: Icon(
                                Icons.compare_arrows_outlined,
                                color: Colors.grey,
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                              text: 100.toString(),
                              style: const TextStyle(color: Colors.grey))
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          WidgetSpan(
                              child: IconButton(
                                onPressed: () {
                                  bool isLiked = false;
                                  if (tweetModel.user.likedTweets
                                      .contains(tweetModel.tweets)) {
                                    isLiked = true;
                                  }
                                  setState(() {
                                    addLikes(tweetModel.tweets, isLiked,
                                        tweetModel.user);
                                  });
                                },
                                icon: !(tweetModel.user.likedTweets
                                        .contains(tweetModel.tweets))
                                    ? const Icon(
                                        Icons.favorite_border_rounded,
                                        color: Colors.grey,
                                      )
                                    : const Icon(
                                        Icons.favorite,
                                        color: Colors.pinkAccent,
                                      ),
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                              text: tweetModel.tweets.likes.toString(),
                              style: TextStyle(color: Colors.grey))
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          const WidgetSpan(
                              child: Icon(
                                Icons.bar_chart,
                                color: Colors.grey,
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                              text: 2000.toString(),
                              style: const TextStyle(color: Colors.grey))
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
