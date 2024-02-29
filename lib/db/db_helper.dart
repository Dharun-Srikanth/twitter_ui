import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:twitter_ui/model/tweet_model.dart';

import '../model/user_model.dart';

class DBHelper {
  static const String USER_TABLE = "User";
  static const String TWEETS_TABLE = "Tweets";
  static const String COMMENTS_TABLE = "Comments";

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
    String dbPath = join(databasesPath, "twitter.db");

    var db = await openDatabase(dbPath, version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
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

    // await db.execute('CREATE TABLE $COMMENTS_TABLE'
    //     '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
    //     'comment TEXT,'
    //     'tweet_id INTEGER,'
    //     'user_id INTEGER'
    //     'FOREIGN KEY (tweet_id) REFERENCES $TWEETS_TABLE (id),'
    //     'FOREIGN KEY (user_id) REFERENCES $USER_TABLE (id))');

  }

  // Insert into user table
  Future<UserModel> addUser(UserModel user) async {
    var dbClient = await database;
    if(dbClient != null) {
      user.id = await dbClient.insert("User", user.toJson());
    }
    return user;
  }

  // Insert tweets
  Future<TweetModel> addTweet(TweetModel tweet) async {
    var dbClient = await database;
    if(dbClient != null) {
      tweet.id = await dbClient.insert("Tweets", tweet.toJson());
    }
    return tweet;
  }

  // Get all tweets
  Future<List<TweetModel>> getTweets() async {
    List<TweetModel> tweetList = [];
    var dbClient = await database;
    if(dbClient != null) {
      var result = await dbClient.rawQuery('SELECT * FROM $TWEETS_TABLE');
      for (var element in result) {
        tweetList.add(TweetModel.fromJson(element));
      }
    }
    return tweetList;
  }

  // Get tweet
  Future<TweetModel?> getTweet(int id) async {
    var dbClient = await database;
    if(dbClient != null){
      var result = await dbClient.rawQuery("SELECT * FROM $TWEETS_TABLE WHERE id=$id");
      return TweetModel.fromJson(result.first);
    }
    return null;
  }

  // add likes
  Future<void> addLikes(int id) async {
    var dbClient = await database;
    if(dbClient != null){
      var result = await dbClient.rawQuery("SELECT like_count FROM $TWEETS_TABLE WHERE id='$id'");
      TweetModel tweet = TweetModel.fromJson(result.first);
      print(result.first['like_count']);
      int updateCount = await dbClient.rawUpdate(
          "UPDATE $TWEETS_TABLE "
          "SET like_count=?"
          "WHERE id=?",
      [tweet.likeCount+1, id]);
    }
  }

  // Get all users from db
  Future<List<UserModel>> getUsers() async {
    List<UserModel> userList = [];
    var dbClient = await database;
    if(dbClient != null) {
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
    if(dbClient != null){
      var result = await dbClient.rawQuery("SELECT * FROM $USER_TABLE WHERE username='$username' and password='$password'");
      print(result);
      if(result.length>0){
        print(UserModel.fromJson(result.first).username);
        return UserModel.fromJson(result.first);
      }
    }

    return null;
  }


  // close db
  Future close() async {
    var dbClient = await database;
    if(dbClient != null) {
      dbClient.close();
    }
  }
}
