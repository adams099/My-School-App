import 'package:flutter/cupertino.dart';
import 'package:my_school_app/pages/auth/auth_page.dart';
import 'package:my_school_app/pages/splash_screen.dart';
import 'pages/screens/admin/listAccount_screen.dart';
import 'pages/screens/admin/studentsData_screen.dart';
import 'pages/screens/user/alumniData_screen.dart';
import 'pages/screens/user/formData_screen.dart';
import 'pages/screens/user/my_profile.dart';

Map<String, WidgetBuilder> routes = {
  //all screens will be registered here like manifest in android
  SplashScreen.routeName: (context) => SplashScreen(),
  AuthPage.routeName: (context) => AuthPage(),
  // LoginScreen.routeName: (context) => LoginScreen(),
  // HomeScreen.routeName: (context) => HomeScreen(),
  MyProfileScreen.routeName: (context) => MyProfileScreen(),
  StudentDataScreen.routeName: (context) => StudentDataScreen(),
  AlumniDataScreen.routeName: (context) => AlumniDataScreen(),
  ListAccountScreen.routeName: (context) => ListAccountScreen(),
  FormData.routeName: (context) => FormData(),
};
