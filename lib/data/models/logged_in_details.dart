class LoggedInDetails {
  String _username="@";
  String _name="";

  void setUsername(String username) {
    _username += username;
  }

  void setName(String name) {
    _name = name;
  }

  String get name => _name;

  String get username => _username;
}