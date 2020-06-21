import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/helpers/screen_navigation.dart';
import 'package:butchertesta1916/src/helpers/style.dart';
import 'package:butchertesta1916/src/providers/user.dart';
import 'package:butchertesta1916/src/screens/home.dart';
import 'package:butchertesta1916/src/screens/registration.dart';
import 'package:butchertesta1916/src/widgets/custom_text.dart';
import 'package:butchertesta1916/src/widgets/loading.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status == Status.Authenticating ? Loading() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/lg.png", width: 150, height: 150,),
              ],
            ),
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
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(), // move focus to next
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      icon: Icon(Icons.email),
                    ),
                  ),
                ),
              ),
            ),
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
                    onFieldSubmitted: (_) => FocusScope.of(context).unfocus(), // submit and hide keyboard
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      icon: Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () async{
                  if(!await authProvider.signIn()){
                    _key.currentState.showSnackBar(
                      SnackBar(content: Text("Login failed!"))
                    );
                    return;
                  }
                  print("========= login.dart > signIn effettuato ======");
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
                        CustomText(text: "Login", color: white, size: 22,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {changeScreen(context, RegistrationScreen());},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(text: "Registrati", size: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
