import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

// import 'package:share_plus/share_plus.dart';
import 'package:twitter_ui/core/utils/controller.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/data/datasources/api/tweets_api.dart';
import 'package:twitter_ui/data/models/liked_tweets.dart';
import 'package:twitter_ui/data/models/tweet_details.dart';
import 'package:twitter_ui/data/models/tweet_model.dart';
import 'package:twitter_ui/data/models/tweets.dart';
import 'package:twitter_ui/presentation/page/add_tweet.dart';
import 'package:twitter_ui/presentation/providers/data_controller.dart';

class TweetsLayout extends StatefulWidget {
  const TweetsLayout({super.key, this.hideScrollController});

  final ScrollController? hideScrollController;

  @override
  State<TweetsLayout> createState() => _TweetsState();
}

class _TweetsState extends State<TweetsLayout> {
  final _tweetCount = constDataController.allTweetContent.length;
  final _tweetsPerPage = 5;
  final _apiTweetsPerPage = 5;
  int _currentPage = 0;
  int _apiCurrentPage = 0;
  int _tweetIndex = 0;
  int _apiTweetIndex = 0;
  bool isLiked = false;

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
          // constDataController.allTweetContent.addAll(tweetList);
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
  void dispose() {
    super.dispose();
    widget.hideScrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      ref.read(allTweetRiverpod).setData();
      final List<TweetDetails> allDBTweets = ref.watch(allTweetRiverpod).allTweets;
      final tweets = ref.watch(tweetsProvider);
      final bool isDB = ref.watch(allTweetRiverpod).isDB;
      if (!isDB) {
        return tweets.when(
            data: (tweets) {
              List<Tweets> tweetList = tweets.map((e) => e).toList();
              return ListView.builder(
                  shrinkWrap: true,
                  controller: widget.hideScrollController,
                  itemCount: tweetList.length,
                  itemBuilder: (BuildContext context2, index) {
                    if (index >= tweetList.length) {
                      return const Center(
                        child: SizedBox(
                          height: 24.0,
                          width: 24,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return tweetsDesignLayout(tweetList[index], context2);
                  });
            },
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            error: (Object error, StackTrace stackTrace) {
              return Text(error.toString());
            });
      }

      return ListView.builder(
          shrinkWrap: true,
          controller: widget.hideScrollController,
          itemCount: _hasMore
              ? allDBTweets.length + 1
              : allDBTweets.length,
          itemBuilder: (BuildContext context2, int index) {
            if (index >= allDBTweets.length) {
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
            return dbTweetsDesignLayout(
                allDBTweets[index], context2, ref);
          });

      // return GetBuilder<DataController>(builder: (controller) {
      //   return ListView.builder(
      //       shrinkWrap: true,
      //       controller: widget.hideScrollController,
      //       itemCount: _hasMore
      //           ? constDataController.allTweetContent.length + 1
      //           : constDataController.allTweetContent.length,
      //       itemBuilder: (BuildContext context2, int index) {
      //         if (index >= constDataController.allTweetContent.length) {
      //           if (!_isLoading) {
      //             loadMore();
      //           }
      //           return const Center(
      //             child: SizedBox(
      //               height: 24,
      //               width: 24,
      //               child: CircularProgressIndicator(),
      //             ),
      //           );
      //         }
      //         // return tweetsDesignLayout(controller.detailsList[index]);
      //         return dbTweetsDesignLayout(
      //             constDataController.allTweetContent[index], context2, ref);
      //       });
      // });

    });
  }

  Widget dbTweetsDesignLayout(TweetDetails tweetModel, BuildContext context, WidgetRef ref) {
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
                    ? AssetImage("assets/ME.jpg")
                    : AssetImage("assets/profile.png"),
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
                                    loadMore();

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
                                    ref.read(allTweetRiverpod).addNotifications("${loggedInUser!.name} has Liked your post");
                                    loadMore();
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
                              style: const TextStyle(color: Colors.grey))
                        ])),
                        IconButton(
                          onPressed: () async {
                            await FlutterShare.share(
                                title: 'Hi, I\'m sharing a tweet of ${tweetModel.userDetails.name}',
                                text: 'Hi, I\'m sharing a tweet of ${tweetModel.userDetails.name}. Check it out. \n \"${tweetModel.tweet['tweet']}\"',
                                linkUrl: 'https://twitter.com/',
                                chooserTitle: loggedInUser!.name);
                            // Share.share(tweetModel.tweet['tweet'], subject: "Tweet from ${tweetModel.userDetails.name}");
                          },
                          icon: const Icon(
                            Icons.share_outlined,
                            color: Colors.grey,
                          ),
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

  Widget tweetsDesignLayout(Tweets tweetModel, BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey.shade800, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                foregroundImage: AssetImage("assets/profile.png"),
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
                        "User",
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
                        "@user",
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
                          tweetModel.tweet,
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
                                        builder: (context) =>
                                            AddTweet(actionId: tweetModel.id),
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
                                  setState(() {
                                    isLiked = !isLiked;
                                  });
                                  if (isLiked) {
                                    // constDbHelper.removeLikedTweets(tweetModel.id;
                                    // constDbHelper.removeLikes(tweetModel.id);
                                    // loadMore();
                                  } else {
                                    // TweetModel tweet = TweetModel(tweetModel.tweet['id'], tweetModel.tweet['tweet'], tweetModel.userDetails, tweetModel.tweet['like_count'] );
                                    // constDbHelper.addLikedTweets(LikedTweets(id: UniqueKey().hashCode, tweet: tweet, user: loggedInUser!));
                                    // constDbHelper.addLikes(tweetModel.tweet['id']);
                                    // loadMore();
                                  }
                                },
                                icon: isLiked
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.pinkAccent,
                                      )
                                    : const Icon(Icons.favorite_outline),
                              ),
                              alignment: PlaceholderAlignment.middle),
                          TextSpan(
                              text: 100.toString(),
                              style: TextStyle(color: Colors.grey))
                        ])),
                        IconButton(
                          onPressed: () {
                            // Share.share(tweetModel.tweet['tweet'], subject: "Tweet from ${tweetModel.userDetails.name}");
                          },
                          icon: const Icon(
                            Icons.share_outlined,
                            color: Colors.grey,
                          ),
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
