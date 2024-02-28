import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/user_model.dart';

class DBHelper {
  static const String USER_TABLE = "User";

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

    var db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return db;
  }

  // create user table
  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $USER_TABLE '
        '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT,'
        'username TEXT,'
        'email TEXT,'
        'password TEXT)');


  }

  // Insert into user table
  Future<UserModel> addUser(UserModel user) async {
    var dbClient = await database;
    if(dbClient != null) {
      user.id = await dbClient.insert("User", user.toJson());
    }
    return user;
  }

  // Get all users from db
  Future<List<UserModel>> getUsers() async {
    List<UserModel> userList = [];
    var dbClient = await database;
    if(dbClient != null) {
      var result = await dbClient.rawQuery('SELECT * FROM User');
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
      var result = await dbClient.rawQuery("SELECT * FROM User WHERE username='$username' and password='$password'");
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
