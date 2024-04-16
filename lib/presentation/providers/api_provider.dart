import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_ui/data/datasources/api/tweets_api.dart';
import 'package:twitter_ui/data/datasources/api/user_api.dart';
import 'package:twitter_ui/domain/models/tweets.dart';
import 'package:twitter_ui/domain/models/user.dart';

final tweetsProvider = FutureProvider<List<Tweets>>((ref) async {
  return fetchTweets();
});

final userProvider = FutureProvider<List<User>>((ref) async {
  return fetchUser();
});