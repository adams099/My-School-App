import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../../components/widgets/user/navigation_drawer_widget.dart';
import '../../auth/auth_page.dart';
import '../../../components/widgets/student_data.dart';
import '../../../constants.dart';
import '../../../theme.dart';
import 'alumniData_screen.dart';
import 'my_profile.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(HomeScreenUser());
}

// ignore: must_be_immutable
class HomeScreenUser extends StatefulWidget {
  HomeScreenUser({Key? key}) : super(key: key);
  static String routeName = 'HomeScreenUser';

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {});
    });
  }

  CollectionReference dataSiswa =
      FirebaseFirestore.instance.collection("bioData");

  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
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
        drawer: const NavigationDrawerWidgetUser(),
        body: Column(
          children: [
            Container(
              width: 100.w,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder<DocumentSnapshot>(
                      future: dataSiswa.doc(user!.uid).get(),
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

                          String nama = "${data['namaLengkap']}";
                          String imgUrl = "${data['imgUrl']}";
                          String jurusan = "${data['kejuruan']}";
                          String thnAjaran = "${data['tahunAjaran']}";
                          String nis = "${data['nis']}";

                          List<String> words = nama.split(" ");
                          String firstWord = words[0];

                          List<String> word = jurusan.split(" ");
                          String firstWordJurusan = word[0];

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
                                  StudentClass2(
                                      studentClass:
                                          "$firstWordJurusan | NIS $nis"),
                                  sizedBox,
                                  StudentYear(
                                    studentYear: thnAjaran,
                                  ),
                                  kHalfSizedBox
                                ],
                              ),
                              kHalfSizedBox,
                              StudentPicture(
                                picAddress: imgUrl,
                                onPress: () =>
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed("MyProfileScreen"),
                              )
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
                              context, AlumniDataScreen.routeName);
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
                                "Data Alumni",
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
                                  stream: FirebaseFirestore.instance
                                      .collection("bioData")
                                      .where('tahunAjaran',
                                          isEqualTo: user!.displayName)
                                      .snapshots(),
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
                        onTap: () {},
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                  Icon(Icons.lock_outline, size: 15.sp)
                                ],
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
            Expanded(
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  color: kOtherColor,
                  borderRadius: kTopBorderRadius,
                ),
                child: SingleChildScrollView(
                  //for padding
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.pushNamed(
                                  context, AlumniDataScreen.routeName);
                            },
                            icon: 'assets/icons/datesheet.svg',
                            title: 'Data Alumni',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.pushNamed(
                                  context, MyProfileScreen.routeName);
                            },
                            icon: 'assets/icons/resume.svg',
                            title: 'Your Data',
                          ),
                        ],
                      ),
                      sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {},
                            icon: 'assets/icons/assignment.svg',
                            title: 'Assignment',
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
