import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_ui/constants/details.dart';
import 'package:twitter_ui/controller/data_controller.dart';
import 'package:twitter_ui/model/tweets.dart';


class ProfilePageDesign extends StatelessWidget {
  const ProfilePageDesign({super.key});

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find<DataController>();
    List<Tweets?> userTweets = [];
    for(int i=0; i<dataController.tweetList.length; i++) {
      if(dataController.tweetList[i].userId == 101) {
        userTweets.add(dataController.tweetList[i]);
      }
    }
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
          Positioned(
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
                loggedInUser!.username,
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Born February 30, 2023 \nJoined February 31, 2024",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
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
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Posts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Replies",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600),
              ),
              Text(
                "Likes",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
