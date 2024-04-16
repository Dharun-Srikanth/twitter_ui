import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/core/utils/controller.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/data/datasources/db/db_helper.dart';
import 'package:twitter_ui/data/repository/db_repository.dart';
import 'package:twitter_ui/domain/models/liked_tweets.dart';
import 'package:twitter_ui/domain/models/tweet_details.dart';
import 'package:twitter_ui/domain/models/tweet_model.dart';
import 'package:twitter_ui/presentation/page/add_tweet.dart';
import 'package:twitter_ui/presentation/providers/data_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePageDesign extends StatefulWidget {
  const ProfilePageDesign({super.key, required this.ref});

  final WidgetRef ref;

  @override
  State<ProfilePageDesign> createState() => _ProfilePageDesignState();
}

class _ProfilePageDesignState extends State<ProfilePageDesign> {
  final TextEditingController _textFieldController = TextEditingController();
  final DbRepo _dbRepo = DbRepo(DBHelper());

  loadData() {
    constDataController.setData();
    _dbRepo.fetchProviderData(widget.ref);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "@${loggedInUser!.username}",
                style: const TextStyle(color: Colors.grey, fontSize: 18),
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
                  TabBar(tabs: [
                    Tab(
                      child: Text(
                        AppLocalizations.of(context)!.posts,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Tab(
                      child: Text(
                        AppLocalizations.of(context)!.replies,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Tab(
                      child: Text(
                        AppLocalizations.of(context)!.likes,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ]),
                  Expanded(
                    child: TabBarView(children: [
                      GetBuilder<DataController>(builder: (controller) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: constDataController.allTweetContent
                                .where((element) =>
                                    element.userDetails.id == loggedInUser!.id)
                                .toList()
                                .length,
                            itemBuilder: (BuildContext context2, int index) {
                              // return tweetsDesignLayout(controller.detailsList[index]);
                              return dbTweetsDesignLayout(
                                  constDataController.allTweetContent
                                      .where((element) =>
                                          element.userDetails.id ==
                                          loggedInUser!.id)
                                      .toList()[index]);
                            });
                      }),
                      GetBuilder<DataController>(builder: (controller) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: constDataController.allTweetContent
                                .where((element) =>
                                    element.userDetails.id ==
                                        loggedInUser!.id &&
                                    element.comments.isNotEmpty)
                                .toList()
                                .length,
                            itemBuilder: (BuildContext context2, int index) {
                              // return tweetsDesignLayout(controller.detailsList[index]);
                              return dbTweetsDesignLayout(
                                  constDataController.allTweetContent
                                      .where((element) =>
                                          element.userDetails.id ==
                                              loggedInUser!.id &&
                                          element.comments.isNotEmpty)
                                      .toList()[index]);
                            });
                      }),
                      GetBuilder<DataController>(builder: (controller) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: constDataController.allTweetContent
                                .where((element) =>
                                    element.userDetails.id ==
                                        loggedInUser!.id &&
                                    element.isLiked)
                                .toList()
                                .length,
                            itemBuilder: (BuildContext context2, int index) {
                              // return tweetsDesignLayout(controller.detailsList[index]);
                              return dbTweetsDesignLayout(
                                  constDataController.allTweetContent
                                      .where((element) =>
                                          element.userDetails.id ==
                                              loggedInUser!.id &&
                                          element.isLiked)
                                      .toList()[index]);
                            });
                      }),
                    ]),
                  )
                ],
              )),
        ),
      ],
    );
  }

  Widget dbTweetsDesignLayout(TweetDetails tweetModel) {
    String tweet = tweetModel.tweet['tweet'].toString();
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
                        Text.rich(TextSpan(
                            text: tweet.contains("#")
                                ? tweet.substring(0, tweet.indexOf('#'))
                                : tweet,
                            style: const TextStyle(fontSize: 16.0),
                            children: [
                              TextSpan(
                                text: tweet.contains("#")
                                    ? tweet.substring(tweet.indexOf("#"))
                                    : "",
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.blue),
                              )
                            ])),
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
                                    _dbRepo.removeLikedTweets(
                                        tweetModel.tweet['id']);
                                    _dbRepo.removeLikes(tweetModel.tweet['id']);
                                    setState(() {
                                      loadData();
                                    });
                                  } else {
                                    TweetModel tweet = TweetModel(
                                        tweetModel.tweet['id'],
                                        tweetModel.tweet['tweet'],
                                        tweetModel.userDetails,
                                        tweetModel.tweet['like_count']);
                                    _dbRepo.addLikedTweets(LikedTweets(
                                        id: UniqueKey().hashCode,
                                        tweet: tweet,
                                        user: loggedInUser!));
                                    _dbRepo.addLikes(tweetModel.tweet['id']);
                                    setState(() {
                                      loadData();
                                    });
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
                                title:
                                    'Hi, I\'m sharing a tweet of ${tweetModel.userDetails.name}',
                                text:
                                    'Hi, I\'m sharing a tweet of ${tweetModel.userDetails.name}. Check it out. \n "${tweetModel.tweet['tweet']}"',
                                linkUrl: 'https://twitter.com/',
                                chooserTitle: loggedInUser!.name);
                            // Share.share(tweetModel.tweet['tweet'], subject: "Tweet from ${tweetModel.userDetails.name}");
                          },
                          icon: const Icon(
                            Icons.share_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Wrap(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            leading: const Icon(Icons.edit),
                                            title: const Text("Edit"),
                                            onTap: () {
                                              _displayTextInputDialog(tweetModel.tweet['id']);
                                              // Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            leading: const Icon(
                                                Icons.delete_outline_rounded),
                                            title: const Text("Delete"),
                                            onTap: () {
                                              _dbRepo.deleteTweet(
                                                  tweetModel.tweet['id']);
                                              setState(() {
                                                loadData();
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> _displayTextInputDialog(int id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('TextField in Dialog'),
          content: TextField(
            autofocus: true,
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Text Field in Dialog"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                _dbRepo.updateTweet(id, _textFieldController.text);
                setState(() {
                  loadData();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
