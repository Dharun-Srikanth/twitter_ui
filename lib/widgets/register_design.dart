import 'package:flutter/material.dart';
import 'package:twitter_ui/constants/controller.dart';
import 'package:twitter_ui/widgets/primary_button.dart';

import '../constants/regex.dart';
import '../db/db_helper.dart';
import '../model/user_model.dart';

class RegisterDesign extends StatelessWidget {
  RegisterDesign({super.key});

  final _formKey = GlobalKey<FormState>();
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create your account",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 58.0, bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter name";
                              } else if (!(nameRegExp.hasMatch(value)) || value
                                  .length < 3) {
                                return "Invalid name";
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: regName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Name",
                                focusColor: Colors.blueAccent,
                                contentPadding: EdgeInsets.all(25),
                                labelStyle: TextStyle(fontSize: 20, color: Colors
                                    .grey)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter Username";
                              } else if (!(usernameRegExp.hasMatch(value)) || value
                                  .length < 3) {
                                return "Invalid Username. Only lowercase alphanumeric allowed";
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: regUsername,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Username",
                                focusColor: Colors.blueAccent,
                                contentPadding: EdgeInsets.all(25),
                                labelStyle: TextStyle(fontSize: 20, color: Colors
                                    .grey)),
                          ),
                          SizedBox(
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
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email",
                                focusColor: Colors.blueAccent,
                                contentPadding: EdgeInsets.all(25),
                                labelStyle: TextStyle(fontSize: 20, color: Colors
                                    .grey)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
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
                                border: OutlineInputBorder(),
                                labelText: "Password",
                                focusColor: Colors.blueAccent,
                                contentPadding: EdgeInsets.all(25),
                                labelStyle: TextStyle(fontSize: 20, color: Colors
                                    .grey)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
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
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Confirm Password",
                                focusColor: Colors.blueAccent,
                                contentPadding: EdgeInsets.all(25),
                                labelStyle: TextStyle(fontSize: 20, color: Colors
                                    .grey)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey.shade800, width: 0.5))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButton(
                        title: "Create account",
                        onPressed: () {
                          saveData();
                          Navigator.pushNamed(context, "loginPage");
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveData() {
    if (_formKey.currentState!.validate()) {
      UserModel user = UserModel(
        id: UniqueKey().hashCode,
        name: regName.text,
        username: regUsername.text,
        email: regEmail.text,
        password: regPassword.text,
      );

      Future<UserModel> future = dbHelper.addUser(user);
      print("saved");
      future.then((value){
        if(value!=null){
          print(value.name);
        }
      });
    }
  }
}
