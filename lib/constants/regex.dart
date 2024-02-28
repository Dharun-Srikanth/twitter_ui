final RegExp nameRegExp = RegExp('[a-zA-Z]');
final RegExp usernameRegExp = RegExp(r"^[a-z][a-z0-9_]{5,29}$");
final RegExp emailRegExp = RegExp(r"^[^@]+@[^@]+\.[^@]+$");
final RegExp passwordRegExp = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");