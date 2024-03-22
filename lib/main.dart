import 'package:hk_sena/firebase_options.dart';
import 'package:hk_sena/screens/common/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hk_sena/screens/common/splashscreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
      routes: {
        '/login': (context) => LoginPage(),
      },


    );
  }
}
