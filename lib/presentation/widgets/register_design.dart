import 'package:flutter/material.dart';
import 'package:twitter_ui/core/utils/controller.dart';
import 'package:twitter_ui/core/utils/regex.dart';
import 'package:twitter_ui/data/datasources/db/db_helper.dart';
import 'package:twitter_ui/data/repository/db_repository.dart';
import 'package:twitter_ui/domain/models/user_model.dart';

class RegisterDesign extends StatefulWidget {
  RegisterDesign({super.key, required this.registerFormKey});
  final GlobalKey<FormState> registerFormKey;
  @override
  State<RegisterDesign> createState() => _RegisterDesignState();
  final DbRepo _dbRepo = DbRepo(DBHelper());
  Future<UserModel?> saveData() async{
    if (registerFormKey.currentState!.validate()) {
      UserModel user = UserModel(
        id: UniqueKey().hashCode,
        name: regName.text,
        username: regUsername.text,
        email: regEmail.text,
        password: regPassword.text,
      );

      regName.text = "";
      regUsername.text = "";
      regEmail.text = "";
      regPassword.text = "";
      regCfmPassword.text = "";

      return await _dbRepo.addUser(user);
    }
    return null;
  }
}

class _RegisterDesignState extends State<RegisterDesign> {

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text(
              "Create your account",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 58.0, bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: widget.registerFormKey,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter name";
                        } else if (!(nameRegExp.hasMatch(value)) ||
                            value.length < 3) {
                          return "Invalid name";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: regName,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name",
                          focusColor: Colors.blueAccent,
                          contentPadding: EdgeInsets.all(20),
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Username";
                        } else if (!(usernameRegExp.hasMatch(value)) ||
                            value.length < 3) {
                          return "Invalid Username. Only lowercase alphanumeric allowed";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: regUsername,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          focusColor: Colors.blueAccent,
                          contentPadding: EdgeInsets.all(20),
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        } else if (!(emailRegExp.hasMatch(value))) {
                          return "Invalid email";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: regEmail,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          focusColor: Colors.blueAccent,
                          contentPadding: EdgeInsets.all(20),
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        } else if (!(passwordRegExp.hasMatch(value))) {
                          return "Invalid Password";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: regPassword,
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: IconButton(
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          labelText: "Password",
                          focusColor: Colors.blueAccent,
                          contentPadding: const EdgeInsets.all(20),
                          labelStyle:
                              const TextStyle(fontSize: 20, color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter confirm password";
                        } else if (value != regPassword.text) {
                          return "Password mismatch";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: regCfmPassword,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Confirm Password",
                          focusColor: Colors.blueAccent,
                          contentPadding: EdgeInsets.all(20),
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
