import 'package:twitter_ui/model/tweets.dart';
import 'package:twitter_ui/model/user.dart';

class TweetDetails{
  Tweets tweets;
  User user;


  TweetDetails({required this.tweets, required this.user});

  factory TweetDetails.fromJson(Tweets tweets, User user) {
    return TweetDetails(
        tweets: tweets,
      user: user
    );
  }
}
