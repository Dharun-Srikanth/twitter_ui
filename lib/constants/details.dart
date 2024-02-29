import 'package:twitter_ui/db/db_helper.dart';
import 'package:twitter_ui/model/tweet_model.dart';
import 'package:twitter_ui/model/user_model.dart';

import '../model/tweets.dart';

late UserModel? loggedInUser;
final DBHelper constDbHelper = DBHelper();
Future<List<TweetModel>> dbTweets = constDbHelper.getTweets();