import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/route_utils/route_utils.dart';
import 'views/login/view.dart';
import 'views/splash/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RouteUtils.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
