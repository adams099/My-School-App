import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_school_app/pages/screens/admin/home_screen.dart';
import 'package:my_school_app/pages/screens/user/home_screen.dart';
import 'package:my_school_app/pages/screens/user/my_profile.dart';
import '../screens/user/formData_screen.dart';
import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  static String routeName = 'AuthPage';
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(snapshot.data!.uid)
                .get()
                .then((DocumentSnapshot documentSnapshot) {
              if (documentSnapshot.exists) {
                if (documentSnapshot.get('role') == "Admin") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreenAdmin(),
                    ),
                  );
                } else {
                  FirebaseFirestore.instance
                      .collection('bioData')
                      .doc(snapshot.data!.uid)
                      .get()
                      .then((DocumentSnapshot documentSnapshot) {
                    if (documentSnapshot.exists) {
                      String nama = "${documentSnapshot.get('namaLengkap')}";
                      String agama = "${documentSnapshot.get('agama')}";
                      String alamat = "${documentSnapshot.get('alamat')}";
                      String jenisKelamin =
                          "${documentSnapshot.get('jenisKelamin')}";
                      String thnAjaran =
                          "${documentSnapshot.get('tahunAjaran')}";
                      String jurusan = "${documentSnapshot.get('kejuruan')}";
                      String nis = "${documentSnapshot.get('nis')}";
                      String nisn = "${documentSnapshot.get('nisn')}";
                      String ttl = "${documentSnapshot.get('ttl')}";
                      if (nama == '' ||
                          agama == '' ||
                          alamat == '' ||
                          jenisKelamin == '' ||
                          thnAjaran == '' ||
                          jurusan == '' ||
                          nisn == '' ||
                          nis == '' ||
                          ttl == '' ||
                          nama == null ||
                          agama == null ||
                          alamat == null ||
                          jenisKelamin == null ||
                          thnAjaran == null ||
                          jurusan == null ||
                          nisn == null ||
                          nis == null ||
                          ttl == null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FormData(),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreenUser(),
                          ),
                        );
                      }
                      print('Document does not exist on the database');
                    }
                  });
                }
                print('Document does not exist on the database');
              }
            });
          }
          // user is NOT logged in
          return LoginOrRegisterPage();
        },
      ),
    );
  }
}
