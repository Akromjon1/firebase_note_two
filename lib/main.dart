import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_note_two/pages/home_page.dart';
import 'package:firebase_note_two/pages/sign_in_page.dart';
import 'package:firebase_note_two/pages/sign_up_page.dart';
import 'package:firebase_note_two/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveService.dbName);
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          elevation: 0
        ),
        primarySwatch: Colors.orange,

      ),
      home: const SignInPage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        SignInPage.id: (context) => const SignInPage(),
        SignUpPage.id: (context) => const SignUpPage(),
      },
    );
  }
}
