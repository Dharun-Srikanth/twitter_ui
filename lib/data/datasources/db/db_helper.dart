import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:twitter_ui/core/utils/details.dart';
import 'package:twitter_ui/data/models/comments.dart';
import 'package:twitter_ui/data/models/language_model.dart';
import 'package:twitter_ui/data/models/liked_tweets.dart';
import 'package:twitter_ui/data/models/tweet_details.dart';
import 'package:twitter_ui/data/models/tweet_model.dart';
import 'package:twitter_ui/data/models/user_model.dart';

class DBHelper {
  static const String USER_TABLE = "User";
  static const String TWEETS_TABLE = "Tweets";
  static const String COMMENTS_TABLE = "Comments";
  static const String LIKED_TWEETS_TABLE = "LikedTweets";

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "twitter_clone.db");

    var db = await openDatabase(dbPath,
        version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
    return db;
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // create user table
  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $USER_TABLE '
        '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT,'
        'username TEXT,'
        'email TEXT,'
        'password TEXT)');

    await db.execute('CREATE TABLE $TWEETS_TABLE'
        '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'tweet TEXT,'
        'user_id INTEGER,'
        'like_count INTEGER,'
        'FOREIGN KEY (user_id) REFERENCES $USER_TABLE (id))');

    await db.execute('CREATE TABLE $COMMENTS_TABLE'
        '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'comment TEXT,'
        'tweet_id INTEGER,'
        'user_id INTEGER,'
        'FOREIGN KEY (tweet_id) REFERENCES $TWEETS_TABLE (id),'
        'FOREIGN KEY (user_id) REFERENCES $USER_TABLE (id))');

    await db.execute("CREATE TABLE $LIKED_TWEETS_TABLE"
        "(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "tweet_id INTEGER,"
        "user_id INTEGER,"
        "FOREIGN KEY (tweet_id) REFERENCES $TWEETS_TABLE (id),"
        "FOREIGN KEY (user_id) REFERENCES $USER_TABLE (id))");

  }

  // ______________________________________________________________________________
  // Get all details
  Future<List<TweetDetails>> getAllDetails() async {
    List<TweetDetails> tweetDetailsList = [];
    List<UserModel> allUsers = await getUsers();
    List<Map<String, dynamic>> tweets = await getAllTweets();

    for (var tweet in tweets) {
      List<Map<String, dynamic>> comments =
      await getCommentsForTweet(tweet['id']);
      List<Map<String, dynamic>> likedTweets = await getUserLikedTweets(loggedInUser!.id);
      bool isLiked = likedTweets.any((element) => element['tweet_id'] == tweet['id']);

      for (var user in allUsers) {
        if(user.id == tweet['user_id']) {
          tweetDetailsList.add(TweetDetails(
            tweet: tweet,
            comments: comments,
            userDetails: user,
            isLiked: isLiked));
          break;
        }
      }
    }
    return tweetDetailsList.reversed.toList();
  }

  // ____________________________________________________________________________________

  // Insert into user table
  Future<UserModel> addUser(UserModel user) async {
    var dbClient = await database;
    if (dbClient != null) {
      user.id = await dbClient.insert("User", user.toJson());
    }
    return user;
  }

  // Insert tweets
  Future<TweetModel> addTweet(TweetModel tweet) async {
    var dbClient = await database;
    if (dbClient != null) {
      tweet.id = await dbClient.insert("Tweets", tweet.toJson());
    }
    return tweet;
  }

  // Insert comments
  Future<Comments> addComments(Comments comment) async {
    var dbClient = await database;
    if (dbClient != null) {
      comment.id = await dbClient.insert(COMMENTS_TABLE, comment.toJson());
      print("added comments");
    }
    return comment;
  }

  // add likes
  Future<void> addLikes(int id) async {
    var dbClient = await database;
    if (dbClient != null) {
      var result =
          await dbClient.rawQuery("SELECT * FROM $TWEETS_TABLE WHERE id='$id'");
      TweetModel tweet = TweetModel.fromJson(result.first);
      print(result.first['like_count']);
      int updateCount = await dbClient.rawUpdate(
          "UPDATE $TWEETS_TABLE "
          "SET like_count=?"
          "WHERE id=?",
          [tweet.likeCount + 1, id]);
    }
  }

  // add likes
  Future<void> removeLikes(int id) async {
    var dbClient = await database;
    if (dbClient != null) {
      var result =
          await dbClient.rawQuery("SELECT * FROM $TWEETS_TABLE WHERE id='$id'");
      TweetModel tweet = TweetModel.fromJson(result.first);
      print(result.first['like_count']);
      int updateCount = await dbClient.rawUpdate(
          "UPDATE $TWEETS_TABLE "
          "SET like_count=?"
          "WHERE id=?",
          [tweet.likeCount == 0 ? 0 : tweet.likeCount - 1, id]);
    }
  }

  // Insert liked tweets
  Future<LikedTweets> addLikedTweets(LikedTweets likedTweets) async {
    var dbClient = await database;
    if (dbClient != null) {
      likedTweets.id =
          await dbClient.insert(LIKED_TWEETS_TABLE, likedTweets.toJson());
      print("added likedTweets");
    }
    return likedTweets;
  }

  // remove liked tweets
  Future removeLikedTweets(int id) async {
    var dbClient = await database;
    if (dbClient != null) {
      int delete = await dbClient.rawUpdate(
          "DELETE FROM $LIKED_TWEETS_TABLE "
          "WHERE tweet_id=?",
          [id]);
      print("removed likedTweets");
    }
  }

  // get comments of the tweets
  Future<List<Map<String, dynamic>>> getCommentsForTweet(int tweetId) async {
    var dbClient = await database;
    return await dbClient!.rawQuery(
      "SELECT * FROM $COMMENTS_TABLE WHERE tweet_id = ?",
      [tweetId],
    );
  }

  // Liked tweets
  Future<List<Map<String, dynamic>>> getUserLikedTweets(int userId) async {
    var dbClient = await database;
    return await dbClient!.rawQuery(
      "SELECT * FROM $LIKED_TWEETS_TABLE WHERE user_id = ?",
      [userId],
    );
  }

  // Get all tweets
  Future<List<TweetModel>> getTweets() async {
    List<TweetModel> tweetList = [];
    var dbClient = await database;
    if (dbClient != null) {
      var result = await dbClient.rawQuery('SELECT * FROM $TWEETS_TABLE '
          'INNER JOIN $USER_TABLE ');
      for (var element in result) {
        tweetList.add(TweetModel.fromJson(element));
      }
    }
    return tweetList;
  }

  Future<List<Map<String, dynamic>>> getAllTweets() async {
    var dbClient = await database;
    return dbClient!.rawQuery("SELECT * FROM $TWEETS_TABLE");
  }

  // Get tweet
  Future<TweetModel?> getTweet(int id) async {
    var dbClient = await database;
    if (dbClient != null) {
      var result =
          await dbClient.rawQuery("SELECT * FROM $TWEETS_TABLE WHERE id=$id");
      return TweetModel.fromJson(result.first);
    }
    return null;
  }

  // get user tweets
  Future<List<Map<String, dynamic>>> getUserTweets(int id) async {
    var dbClient = await database;
    return await dbClient!
        .rawQuery("SELECT * FROM $TWEETS_TABLE WHERE user_id=$id");
  }

  // get tweet comments
  Future<List<Comments>> getTweetComments(int id) async {
    List<Comments> comments = [];
    var dbClient = await database;
    if (dbClient != null) {
      var result = await dbClient
          .rawQuery("SELECT * FROM $COMMENTS_TABLE WHERE tweet_id=$id");
      for (var element in result) {
        comments.add(Comments.fromJson(element));
      }
    }
    return comments;
  }

  // get user
  Future<UserModel?> getUser(int id) async {
    var dbClient = await database;
    if (dbClient != null) {
      var result =
          await dbClient.rawQuery("SELECT * FROM $USER_TABLE WHERE id=$id");
      return UserModel.fromJson(result.first);
    }
    return null;
  }

  // Get all users from db
  Future<List<UserModel>> getUsers() async {
    List<UserModel> userList = [];
    var dbClient = await database;
    if (dbClient != null) {
      var result = await dbClient.rawQuery('SELECT * FROM $USER_TABLE');
      for (var element in result) {
        userList.add(UserModel.fromJson(element));
      }
    }
    return userList;
  }

  // Login with credentials
  Future<UserModel?> getLogIn(String username, String password) async {
    var dbClient = await database;
    if (dbClient != null) {
      var result = await dbClient.rawQuery(
          "SELECT * FROM $USER_TABLE WHERE username='$username' and password='$password'");
      print(result);
      if (result.isNotEmpty) {
        print(UserModel.fromJson(result.first).username);
        return UserModel.fromJson(result.first);
      }
    }

    return null;
  }

  // get User liked tweet
  Future<List<LikedTweets>> getUserLiked(int userId) async {
    List<LikedTweets> likedList = [];
    var dbClient = await database;
    if (dbClient != null) {
      var result = await dbClient
          .rawQuery("SELECT * FROM $LIKED_TWEETS_TABLE WHERE user_id=$userId");
      for (var element in result) {
        likedList.add(LikedTweets.fromJson(element));
      }
    }

    return likedList;
  }

  // delete item
  Future<void> delete(int id) async {
    var dbClient = await database;
    if(dbClient != null) {
      deleteComment(id);
      deleteLikes(id);
      deleteTweet(id);
      print("Deleted");

    }
  }

  void deleteTweet(int id) async {
    var dbClient = await database;
    await dbClient!.rawDelete("DELETE FROM $TWEETS_TABLE WHERE  id= '$id'");
  }

  void deleteComment(int id) async {
    var dbClient = await database;
    await dbClient!.rawDelete("DELETE FROM $COMMENTS_TABLE WHERE  tweet_id= '$id'");
  }

  void deleteLikes(int id) async {
    var dbClient = await database;
    await dbClient!.rawDelete("DELETE FROM $LIKED_TWEETS_TABLE WHERE  tweet_id= '$id'");
  }


  // close db
  Future close() async {
    var dbClient = await database;
    if (dbClient != null) {
      dbClient.close();
    }
  }
}
