import 'package:campusapp/Student/HomePage.dart';
import 'package:campusapp/HomePageStaff.dart';
import 'package:campusapp/LoginPage.dart';
import 'package:campusapp/userPreferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
bool isDark=false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await userPreferences.init();
  runApp( const MyApp());
}
class MyApp extends StatefulWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? user;
  @override
  void initState(){
    super.initState();
    user=userPreferences.getUser();
  }
  @override
  Widget build(BuildContext context) {
    ThemeData lightTheme=ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user=='student'?const HomePage():user=='staff'?const HomePageStaff():const LoginPage(),
      theme: lightTheme.copyWith(
        colorScheme: lightTheme.colorScheme.copyWith(secondary: Colors.white),
      ),
    );
  }
}
