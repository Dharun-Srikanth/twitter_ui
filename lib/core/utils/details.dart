

import 'package:twitter_ui/data/datasources/db/db_helper.dart';
import 'package:twitter_ui/data/models/tweet_model.dart';
import 'package:twitter_ui/data/models/user_model.dart';

late UserModel? loggedInUser;
final DBHelper constDbHelper = DBHelper();
Future<List<TweetModel>> dbTweets = constDbHelper.getTweets();