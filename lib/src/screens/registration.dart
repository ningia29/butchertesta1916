import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/helpers/screen_navigation.dart';
import 'package:butchertesta1916/src/helpers/style.dart';
import 'package:butchertesta1916/src/providers/user.dart';
import 'package:butchertesta1916/src/screens/login.dart';
import 'package:butchertesta1916/src/widgets/custom_text.dart';
import 'package:butchertesta1916/src/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status == Status.Authenticating
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
//                  ================ sezione Logo ====================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/lg.png",
                        width: 150,
                        height: 150,
                      ),
                    ],
                  ),
//                  ================ sezione USERNAME ====================
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: authProvider.name,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          // move focus to next
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            icon: Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                  ),
//                  ================ sezione EMAIL ====================
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: authProvider.email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          // move focus to next
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            icon: Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                  ),
//                  ================ sezione PASSWORD ====================
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: authProvider.password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).unfocus(),
                          // submit and hide keyboard
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            icon: Icon(Icons.lock),
                          ),
                        ),
                      ),
                    ),
                  ),
//                  ================ sezione BOTTONI ====================
                  Padding(
                    padding: const EdgeInsets.all(10.0),
//                  ================ bottone REGISTRATI ====================
                    child: GestureDetector(
                      onTap: () async {
                        if (!await authProvider.signUp()) {
                          _key.currentState.showSnackBar(
                              SnackBar(content: Text("Registration failed!")));
                          return;
                        }
                        authProvider.clearController();
                        changeScreenReplacement(context, Home());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: red,
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomText(
                                text: "Registrati",
                                color: white,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
//                  ================ bottone LOGIN ====================
                  GestureDetector(
                    onTap: () {
                      changeScreen(context, Login());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: "Login here",
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
