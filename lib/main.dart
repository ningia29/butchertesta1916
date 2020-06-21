import 'package:butchertesta1916/src/providers/client.dart';
import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/providers/app.dart';
import 'package:butchertesta1916/src/providers/category.dart';
import 'package:butchertesta1916/src/providers/product.dart';
import 'package:butchertesta1916/src/providers/restaurant.dart';
import 'package:butchertesta1916/src/providers/user.dart';
import 'package:butchertesta1916/src/screens/home.dart';
import 'package:butchertesta1916/src/screens/login.dart';
import 'package:butchertesta1916/src/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider()),
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: RestaurantProvider.inizialize()),
    ChangeNotifierProvider.value(value: CategoryProvider.inizialize()),
    ChangeNotifierProvider.value(value: ProductProvider.inizialize()),
    ChangeNotifierProvider.value(value: ClientProvider.inizialize()),
  ],
      child: MaterialApp(
//          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController()
      )));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);

    switch(auth.status){
      case Status.Uninitialized:
        return Login();
//        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
      return Login();
      case Status.Authenticated:
        return Home();
      default: return Login();
    }
  }
}