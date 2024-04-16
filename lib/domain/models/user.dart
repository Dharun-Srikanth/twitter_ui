import 'package:twitter_ui/domain/models/tweets.dart';

class User {
  final int id;
  String name;
  String username;
  List<Tweets> likedTweets = [];

  User({required this.id, required this.name, required this.username, required this.likedTweets});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['firstName'],
      username: json['username'],
      likedTweets: []
    );
  }
}