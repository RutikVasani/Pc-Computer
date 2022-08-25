import 'package:flutter/material.dart';
import 'package:pc1/appbarpage.dart';
import 'package:pc1/loginpage.dart';
import 'package:pc1/pages/daily_data/details.dart';
import 'package:pc1/pages/homepage.dart';
import 'utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Stay Fit',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.loginpage,
        routes: {
          MyRoutes.loginpage:(context) => const LoginPage(),
          MyRoutes.appbarpage: (context) => const AppBarPage(),
          MyRoutes.homepage: (context) => const HomePage(),
          MyRoutes.detailspage:(context) => ProgressPage()
        },
        home: const LoginPage());
  }
}
