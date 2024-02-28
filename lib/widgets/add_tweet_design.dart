import 'package:flutter/material.dart';
import 'package:twitter_ui/constants/controller.dart';

class AddTweetDesign extends StatelessWidget {
  const AddTweetDesign(this.actionId, {super.key});

  final int actionId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
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
    );
  }
}
