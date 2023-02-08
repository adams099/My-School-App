import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_school_app/constants.dart';
import 'package:my_school_app/theme.dart';
import '../../../components/widgets/fee_widgets.dart';

final _formKey = GlobalKey<FormState>();
final add1 = TextEditingController();
final add2 = TextEditingController();
final add3 = TextEditingController();
final add4 = TextEditingController();
final add5 = TextEditingController();
final add6 = TextEditingController();
final add7 = TextEditingController();

// ignore: must_be_immutable
class AlumniDataScreen extends StatelessWidget {
  AlumniDataScreen({Key? key}) : super(key: key);
  static String routeName = 'AlumniDataScreen';
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: blue7Color,
        title: const Text('Data Alumni'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          sizedBox,
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("bioData")
                .where('tahunAjaran', isEqualTo: user!.displayName)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text('Terjadi kesalahan ${snapshot.error}'));
              } else if (snapshot.hasData) {
                int data = snapshot.data!.docs.length;
                if (data == 0) {
                  return const Center(
                      child: Text("No user",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)));
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        children: snapshot.data!.docs.map((e) {
                      String nama = "${e['namaLengkap']}";
                      String agama = "${e['agama']}";
                      String alamat = "${e['alamat']}";
                      String jenisKelamin = "${e['jenisKelamin']}";
                      String thnAjaran = "${e['tahunAjaran']}";
                      String jurusan = "${e['kejuruan']}";
                      String nis = "${e['nis']}";
                      String nisn = "${e['nisn']}";
                      String ttl = "${e['ttl']}";
                      String email = "${e['email']}";

                      if (nama == null ||
                          nama == '' ||
                          agama == null ||
                          agama == '' ||
                          alamat == null ||
                          alamat == '' ||
                          jenisKelamin == null ||
                          jenisKelamin == '' ||
                          thnAjaran == null ||
                          thnAjaran == '' ||
                          jurusan == null ||
                          jurusan == '' ||
                          nis == null ||
                          nis == '' ||
                          nisn == null ||
                          nisn == '' ||
                          ttl == null ||
                          ttl == '' ||
                          email == null ||
                          email == '') {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: kDefaultPadding,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: kTopBorderRadius,
                              color: kOtherColor,
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  bottom: kDefaultPadding),
                              child: Column(
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.all(kDefaultPadding),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(kDefaultPadding),
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: kTextLightColor,
                                          blurRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        FeeDetailRow(
                                          title: 'Nama',
                                          statusValue: nama,
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding,
                                          child: Divider(
                                            thickness: 1.0,
                                          ),
                                        ),
                                        FeeDetailRow(
                                          title: 'Jurusan',
                                          statusValue: jurusan,
                                        ),
                                        sizedBox,
                                        FeeDetailRow(
                                          title: 'Agama',
                                          statusValue: agama,
                                        ),
                                        sizedBox,
                                        FeeDetailRow(
                                          title: 'Jenis Kelamin',
                                          statusValue: jenisKelamin,
                                        ),
                                        sizedBox,
                                        const SizedBox(
                                          height: kDefaultPadding,
                                          child: Divider(
                                            thickness: 1.0,
                                          ),
                                        ),
                                        FeeDetailRow(
                                          title: 'Tahun Ajaran',
                                          statusValue: thnAjaran,
                                        ),
                                      ],
                                    ),
                                  ),
                                  FeeButton(
                                      title: "Detail",
                                      iconData: Icons.arrow_forward_outlined,
                                      onPress: () {
                                        add1.text = nama;
                                        add2.text = email;
                                        add3.text = nis;
                                        add4.text = nisn;
                                        add5.text = thnAjaran;
                                        add6.text = alamat;
                                        add7.text = ttl;
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                scrollable: true,
                                                content: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextFormField(
                                                            controller: add1,
                                                            enabled: false,
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[100],
                                                              labelText: 'Name',
                                                            ),
                                                          ),
                                                          kHalfSizedBox,
                                                          TextFormField(
                                                            controller: add2,
                                                            enabled: false,
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[100],
                                                              labelText:
                                                                  'Email',
                                                            ),
                                                          ),
                                                          kHalfSizedBox,
                                                          TextFormField(
                                                            controller: add3,
                                                            enabled: false,
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[100],
                                                              labelText: 'NIS',
                                                            ),
                                                          ),
                                                          kHalfSizedBox,
                                                          TextFormField(
                                                            controller: add4,
                                                            enabled: false,
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[100],
                                                              labelText: 'NISN',
                                                            ),
                                                          ),
                                                          kHalfSizedBox,
                                                          // jbjbwdkjbd
                                                          TextFormField(
                                                            controller: add7,
                                                            enabled: false,
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[100],
                                                              labelText:
                                                                  'Tanggal Lahir',
                                                            ),
                                                          ),
                                                          kHalfSizedBox,
                                                          // jbjbwdkjbd
                                                          TextFormField(
                                                            controller: add5,
                                                            enabled: false,
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[100],
                                                              labelText:
                                                                  'Tahun Ajaran',
                                                            ),
                                                          ),
                                                          kHalfSizedBox,
                                                          TextFormField(
                                                            controller: add6,
                                                            enabled: false,
                                                            maxLines: 3,
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .grey[100],
                                                              labelText:
                                                                  'Alamat',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              );
                                            });
                                      })
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }).toList()),
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }
}
