import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_school_app/pages/screens/admin/user_page.dart';
import 'package:sizer/sizer.dart';
import '../../auth/auth_page.dart';
import '../../../components/widgets/student_data.dart';
import '../../../constants.dart';
import '../../../theme.dart';
import '../../../components/widgets/Admin/navigation_drawer_widget.dart';
import 'listAccount_screen.dart';
import 'studentsData_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(HomeScreenAdmin());
}

class HomeScreenAdmin extends StatelessWidget {
  HomeScreenAdmin({Key? key}) : super(key: key);
  static String routeName = 'HomeScreenAdmin';
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference dataSiswa =
      FirebaseFirestore.instance.collection("bioData");
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);

    return MaterialApp(
      theme: CustomTheme().baseTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('My School App'),
          centerTitle: true,
          elevation: 0,
        ),
        drawer: const NavigationDrawerWidget(),
        body: Column(
          children: [
            //we will divide the screen into two parts
            //fixed height for first half
            Container(
              width: 100.w,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder<DocumentSnapshot>(
                      future: users.doc(user!.uid).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        //Error Handling conditions
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text("Document does not exist");
                        }

                        //Data is output to the user
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          String nama = "${data['name']}";
                          String imgUrl = "${data['imgUrl']}";

                          List<String> words = nama.split(" ");
                          String firstWord = words[0];

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StudentName(
                                    studentName: firstWord,
                                  ),
                                  kHalfSizedBox,
                                  StudentClass(studentClass: formattedDate),
                                ],
                              ),
                              kHalfSizedBox,
                              StudentPicture(
                                  picAddress: imgUrl,
                                  onPress: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        // ignore: prefer_const_constructors
                                        builder: (context) => ProfileScrenn(
                                          name: nama,
                                          urlImage: imgUrl,
                                        ),
                                      ))),
                            ],
                          );
                        }

                        return Center(
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 40,
                              ),
                              CircularProgressIndicator()
                            ],
                          ),
                        );
                      }),
                  sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ListAccountScreen.routeName);
                        },
                        child: Container(
                          width: 42.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: kOtherColor,
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "User Account",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: kTextBlackColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 19,
                                    ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: users.snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                          child: Text(
                                              'Terjadi kesalahan ${snapshot.error}'));
                                    } else if (snapshot.hasData) {
                                      int user = snapshot.data!.docs.length;
                                      if (user == 0 || user == null) {
                                        return Text(
                                          "0",
                                          style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  wordSpacing: 0.50)!
                                              .copyWith(
                                            color: Colors.grey,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          "$user",
                                          style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  wordSpacing: 0.50)!
                                              .copyWith(
                                            color: Colors.grey,
                                          ),
                                        );
                                      }
                                    }
                                    return const CircularProgressIndicator();
                                  }),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, StudentDataScreen.routeName);
                        },
                        child: Container(
                          width: 42.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: kOtherColor,
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Student Data",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: kTextBlackColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 19,
                                    ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: dataSiswa.snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                          child: Text(
                                              'Terjadi kesalahan ${snapshot.error}'));
                                    } else if (snapshot.hasData) {
                                      int data = snapshot.data!.docs.length;
                                      if (data == 0 || data == null) {
                                        return Text(
                                          "0",
                                          style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  wordSpacing: 0.50)!
                                              .copyWith(
                                            color: Colors.grey,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          "$data",
                                          style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  wordSpacing: 0.50)!
                                              .copyWith(
                                            color: Colors.grey,
                                          ),
                                        );
                                      }
                                    }
                                    return const CircularProgressIndicator();
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            //other will use all the remaining height of screen
            Expanded(
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  color: kOtherColor,
                  borderRadius: kTopBorderRadius,
                ),
                child: SingleChildScrollView(
                  //for padding
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.pushNamed(
                                  context, ListAccountScreen.routeName);
                            },
                            icon: 'assets/icons/datesheet.svg',
                            title: 'User\nAccount',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.pushNamed(
                                  context, StudentDataScreen.routeName);
                            },
                            icon: 'assets/icons/resume.svg',
                            title: 'Students\nData',
                          ),
                        ],
                      ),
                      sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {},
                            icon: 'assets/icons/ask.svg',
                            title: 'Ask',
                          ),
                          HomeCard(
                            onPress: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.WARNING,
                                headerAnimationLoop: false,
                                animType: AnimType.TOPSLIDE,
                                showCloseIcon: true,
                                dismissOnTouchOutside: false,
                                closeIcon:
                                    const Icon(Icons.close_fullscreen_outlined),
                                title: 'Logout',
                                desc: 'Are you sure, do you want to Logout?',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AuthPage(),
                                    ),
                                  );
                                },
                              ).show();
                            },
                            icon: 'assets/icons/logout.svg',
                            title: 'Logout',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
      required this.onPress,
      required this.icon,
      required this.title})
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              color: kOtherColor,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}
