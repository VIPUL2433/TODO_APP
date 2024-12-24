import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_app/Auth/main_page.dart';
import 'package:task_app/Auth/profile.dart';
import 'package:task_app/calendar_page.dart';
import 'package:task_app/home.dart';
import 'package:task_app/login.dart';
import 'package:task_app/signup.dart';
import 'package:task_app/splash_screen.dart';
import 'package:task_app/task_history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splash_screen',
    routes: {
      'login': (context) => MyLogin(
            showMySignup: () {},
          ),
      'signup': (context) => MySignup(
            showMyLogin: () {},
          ),
      'home': (context) => const MyHome(),
      'task_hitory': (context) => TaskHistory(
            date: "",
          ),
      'calendar_page': (context) => const CalendarPage(),
      'main_page': (context) => const MainPage(),
      'profile': (context) => const ProfilePage(),
      'splash_screen': (context) => SplashScreen(),
    },
  ));
}


//TODO App repository name github 
//hello guys
