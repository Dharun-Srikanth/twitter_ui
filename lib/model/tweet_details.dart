import 'package:twitter_ui/model/user_model.dart';

class TweetDetails{
  final Map<String, dynamic> tweet;
  final List<Map<String, dynamic>> comments;
  final UserModel userDetails;
  final bool isLiked;


  TweetDetails({required this.tweet, required this.comments, required this.userDetails, required this.isLiked});

}
