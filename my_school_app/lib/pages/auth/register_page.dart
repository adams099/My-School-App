import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_school_app/Animation/FadeAnimation.dart';
import 'package:my_school_app/components/my_button.dart';
import 'package:my_school_app/components/my_textfield.dart';
import 'package:my_school_app/theme.dart';

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final tahunAjaranController = TextEditingController();

  // error message to user
  void showErrorMessage(String message) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: false,
            title: 'Error',
            desc: message.toUpperCase(),
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 360,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                          1,
                          Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-1.png'))),
                          )),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 100,
                      child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-2.png'))),
                          )),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 100,
                      child: FadeAnimation(
                          1.5,
                          Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/clock.png'))),
                          )),
                    ),
                    Positioned(
                      child: FadeAnimation(
                          1.6,
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.8,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade100))),
                                child: MyTextField(
                                  controller: userNameController,
                                  hintText: 'Enter your name',
                                  obscureText: false,
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade100))),
                                child: MyTextField(
                                  controller: emailController,
                                  hintText: 'Email',
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade100))),
                                child: MyTextField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade100))),
                                child: MyTextField(
                                  controller: confirmPasswordController,
                                  hintText: 'Confirm Password',
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyTextFieldMxLgt(
                                      controller: tahunAjaranController,
                                      hintText: 'Tahun Ajaran',
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      maxLength: 9,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "Example :2000-2003",
                                        style: font2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2,
                      MyButton(
                        text: 'Sign Up',
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          var email = emailController.text;
                          var name = userNameController.text;
                          var pass = passwordController.text;
                          var passConf = confirmPasswordController.text;
                          var thnAjrn = tahunAjaranController.text;

                          try {
                            if (email.isEmpty ||
                                pass.isEmpty ||
                                passConf.isEmpty ||
                                name.isEmpty ||
                                thnAjrn.isEmpty) {
                              Navigator.pop(context);
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.ERROR,
                                      animType: AnimType.RIGHSLIDE,
                                      headerAnimationLoop: false,
                                      title: 'Error',
                                      desc: "Data can't be Empty",
                                      btnOkOnPress: () {},
                                      btnOkIcon: Icons.cancel,
                                      btnOkColor: Colors.red)
                                  .show();
                              return;
                              // check if password is confirmed
                            } else if (passwordController.text ==
                                confirmPasswordController.text) {
                              Navigator.pop(context);

                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: email, password: pass)
                                  .then(
                                    (value) => {
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(value.user!.uid)
                                          .set({
                                        "email": email,
                                        "role": "User",
                                        "name": name,
                                        "tahunAjaran": thnAjrn,
                                        "imgUrl":
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1BwYl1Svb2h_YRhj9tcnZk0yAuIHh3oBM03dzDa8f&s",
                                        "createAt": "${DateTime.now()}",
                                      }),
                                      FirebaseFirestore.instance
                                          .collection("bioData")
                                          .doc(value.user!.uid)
                                          .set({
                                        "agama": "",
                                        "alamat": "",
                                        "email": email,
                                        "imgUrl":
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1BwYl1Svb2h_YRhj9tcnZk0yAuIHh3oBM03dzDa8f&s",
                                        "jenisKelamin": "",
                                        "kejuruan": "",
                                        "namaLengkap": name,
                                        "nis": "",
                                        "nisn": "",
                                        "tahunAjaran": thnAjrn,
                                        "ttl": "",
                                      }),
                                      FirebaseAuth.instance.currentUser
                                          ?.updateDisplayName(thnAjrn),
                                    },
                                  );
                            } else {
                              Navigator.pop(context);
                              showErrorMessage("Passwords don't match!");
                            }
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            showErrorMessage(e.code);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    FadeAnimation(
                        1.5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Login now',
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
