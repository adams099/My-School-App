import 'package:flutter/material.dart';
import 'package:my_school_app/pages/auth/auth_page.dart';
import 'package:my_school_app/theme.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  //route name for our screen
  static String routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //we use future to go from one screen to other via duration time
    Future.delayed(const Duration(seconds: 2), () {
      //no return when user is on login screen and press back, it will not return the
      //user to the splash screen
      Navigator.pushNamedAndRemoveUntil(
          context, AuthPage.routeName, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    //scaffold color set to primary color in main in our text theme
    return MaterialApp(
      theme: CustomTheme().baseTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //its a row with a column
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My School',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    'App',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/splash.png',
                //25% of height & 50% of width
                height: 25.h,
                width: 50.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
