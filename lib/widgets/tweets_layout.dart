import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:twitter_ui/api/tweets_api.dart';
import 'package:twitter_ui/api/user_api.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/model/liked_tweets.dart';
import 'package:twitter_ui/model/tweet_details.dart';
import 'package:twitter_ui/model/tweet_model.dart';
import 'package:twitter_ui/model/user_model.dart';
import 'package:twitter_ui/page/add_tweet.dart';
import '../model/tweets.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class TweetsLayout extends StatefulWidget {
  const TweetsLayout({super.key, this.hideScrollController});
  final ScrollController? hideScrollController;
  @override
  State<TweetsLayout> createState() => _TweetsState();
}

class _TweetsState extends State<TweetsLayout> {
  // ScrollController hideScrollController = ScrollController();
  final _tweetCount = constDataController.allTweetContent.length;
  final _tweetsPerPage = 5;
  int _currentPage = 0;
  int _tweetIndex = 0;

  bool _isLoading = true;
  bool _hasMore = true;

  Future<List<TweetDetails>> fetch() async {
    constDataController.setData();
    final list = <TweetDetails>[];
    final n = min(_tweetsPerPage, _tweetCount - _currentPage * _tweetsPerPage);
    await Future.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < n; i++) {
        list.add(constDataController.allTweetContent[_tweetIndex]);
        _tweetIndex++;
      }
    });
    _currentPage++;
    return list;
  }

  void loadMore() {
    _isLoading = true;
    fetch().then((List<TweetDetails> tweetList) {
      if (tweetList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          constDataController.allTweetContent.value = tweetList;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadMore();
    _isLoading = true;
    _hasMore = true;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController> (builder: (controller) {
      return ListView.builder(
          shrinkWrap: true,
          controller: widget.hideScrollController,
          itemCount: _hasMore ? constDataController.allTweetContent.length + 1 : constDataController.allTweetContent.length,
          itemBuilder: (BuildContext context2, int index) {
            if (index >= constDataController.allTweetContent.length) {
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
            // return tweetsDesignLayout(controller.detailsList[index]);
            return dbTweetsDesignLayout(constDataController.allTweetContent[index], context2);
          });
    });

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
                foregroundImage: tweetModel.userDetails.id == loggedInUser!.id ? AssetImage("assets/ME.jpg") : AssetImage("assets/profile.png"),
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
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddTweet(actionId: tweetModel.tweet['id']),));
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
                                      if(tweetModel.isLiked){
                                        constDbHelper.removeLikedTweets(tweetModel.tweet['id']);
                                        constDbHelper.removeLikes(tweetModel.tweet['id']);
                                        loadMore();
                                      }else {
                                        TweetModel tweet = TweetModel(tweetModel.tweet['id'], tweetModel.tweet['tweet'], tweetModel.userDetails, tweetModel.tweet['like_count'] );
                                        constDbHelper.addLikedTweets(LikedTweets(id: UniqueKey().hashCode, tweet: tweet, user: loggedInUser!));
                                        constDbHelper.addLikes(tweetModel.tweet['id']);
                                        loadMore();
                                      }
                                    },
                                    icon: tweetModel.isLiked ? Icon(Icons.favorite, color: Colors.pinkAccent,) : Icon(Icons.favorite_outline),
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
