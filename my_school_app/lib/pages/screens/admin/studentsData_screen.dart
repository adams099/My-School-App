import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_school_app/constants.dart';
import 'package:my_school_app/theme.dart';
import 'package:sizer/sizer.dart';
import '../../../components/widgets/fee_widgets.dart';

final _formKey = GlobalKey<FormState>();
final add1 = TextEditingController();
final add2 = TextEditingController();
final add3 = TextEditingController();
final add4 = TextEditingController();
final add5 = TextEditingController();

// ignore: must_be_immutable
class StudentDataScreen extends StatefulWidget {
  const StudentDataScreen({Key? key}) : super(key: key);
  static String routeName = 'StudentDataScreen';

  @override
  State<StudentDataScreen> createState() => _StudentDataScreenState();
}

class _StudentDataScreenState extends State<StudentDataScreen> {
  var dataSiswa = FirebaseFirestore.instance.collection('bioData');
  var users = FirebaseFirestore.instance.collection('users');
  late bool isTrue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: blue7Color,
        title: const Text('Students Data'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print(isTrue);
              setState(() {
                isTrue = !isTrue;
              });

              print(isTrue);
            },
            icon: const Icon(
              Icons.filter_list,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          sizedBox,
          StreamBuilder<QuerySnapshot>(
            stream: dataSiswa.snapshots(),
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
                      String id = e.id;

                      if (isTrue) {
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
                                        padding: const EdgeInsets.all(
                                            kDefaultPadding),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(
                                                kDefaultPadding),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                FutureBuilder<DocumentSnapshot>(
                                                    future: users.doc(id).get(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                DocumentSnapshot>
                                                            snapshot) {
                                                      //Error Handling conditions
                                                      if (snapshot.hasError) {
                                                        return const Text(
                                                            "Something went wrong");
                                                      }

                                                      if (snapshot.hasData &&
                                                          !snapshot
                                                              .data!.exists) {
                                                        return const Text(
                                                            "Document does not exist");
                                                      }

                                                      //Data is output to the user
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        Map<String, dynamic> e =
                                                            snapshot.data!
                                                                    .data()
                                                                as Map<String,
                                                                    dynamic>;

                                                        String role =
                                                            "${e['role']}";

                                                        return Container(
                                                          width: 40.w,
                                                          height: 4.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                kSecondaryColor
                                                                    .withOpacity(
                                                                        0.4),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        kDefaultPadding),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              role,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption,
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }),
                                              ],
                                            ),
                                            kHalfSizedBox,
                                            FeeDetailRow(
                                              title: 'Nama',
                                              statusValue:
                                                  "${e['namaLengkap']}",
                                            ),
                                            SizedBox(
                                              height: kDefaultPadding,
                                              child: Divider(
                                                thickness: 1.0,
                                              ),
                                            ),
                                            FeeDetailRow(
                                              title: 'Jurusan',
                                              statusValue: "${e['kejuruan']}",
                                            ),
                                            sizedBox,
                                            FeeDetailRow(
                                              title: 'Agama',
                                              statusValue: "${e['agama']}",
                                            ),
                                            sizedBox,
                                            FeeDetailRow(
                                              title: 'Jenis Kelamin',
                                              statusValue:
                                                  "${e['jenisKelamin']}",
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
                                              statusValue:
                                                  "${e['tahunAjaran']}",
                                            ),
                                          ],
                                        ),
                                      ),
                                      FeeButton(
                                          title: "Detail",
                                          iconData:
                                              Icons.arrow_forward_outlined,
                                          onPress: () {
                                            add1.text = e["namaLengkap"];
                                            add2.text = e["email"];
                                            add3.text = e["nis"];
                                            add4.text = e["nisn"];
                                            add5.text = e["tahunAjaran"];
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      scrollable: true,
                                                      content: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Form(
                                                            key: _formKey,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                TextFormField(
                                                                  controller:
                                                                      add2,
                                                                  enabled:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors.grey[
                                                                            100],
                                                                    labelText:
                                                                        'Email',
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .email),
                                                                  ),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Please input your Email';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                                kHalfSizedBox,
                                                                TextFormField(
                                                                  controller:
                                                                      add1,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Name',
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.blue),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .person),
                                                                  ),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Please input your Name';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                                kHalfSizedBox,
                                                                TextFormField(
                                                                  controller:
                                                                      add3,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.blue),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .view_quilt),
                                                                    labelText:
                                                                        'NIS',
                                                                  ),
                                                                ),
                                                                kHalfSizedBox,
                                                                TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller:
                                                                      add4,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.blue),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .streetview),
                                                                    labelText:
                                                                        'NISN',
                                                                  ),
                                                                ),
                                                                kHalfSizedBox,
                                                                TextFormField(
                                                                  controller:
                                                                      add5,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.blue),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    prefixIcon:
                                                                        const Icon(
                                                                            Icons.school),
                                                                    labelText:
                                                                        'Tahun Ajaran',
                                                                  ),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Input Tahun Ajaran';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      actions: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      25),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .red),
                                                                  shape: MaterialStateProperty
                                                                      .all<
                                                                          RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onPressed: (() {
                                                                  dataSiswa
                                                                      .doc(e.id)
                                                                      .delete();
                                                                  add1.clear();
                                                                  add2.clear();
                                                                  add3.clear();
                                                                  add4.clear();
                                                                  add5.clear();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }),
                                                                child: const Text(
                                                                    "Delete"),
                                                              ),
                                                              kHalfWidthSizedBox,
                                                              ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          blue7Color),
                                                                  shape: MaterialStateProperty
                                                                      .all<
                                                                          RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // ignore: sort_child_properties_last
                                                                child: const Text(
                                                                    "Update"),
                                                                onPressed: (() {
                                                                  if (_formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    dataSiswa
                                                                        .doc(e
                                                                            .id)
                                                                        .update({
                                                                      "namaLengkap":
                                                                          add1.text,
                                                                      "email": add2
                                                                          .text,
                                                                      "nis": add3
                                                                          .text,
                                                                      "nisn": add4
                                                                          .text,
                                                                      "tahunAjaran":
                                                                          add5.text,
                                                                    });
                                                                    add1.clear();
                                                                    add2.clear();
                                                                    add3.clear();
                                                                    add4.clear();

                                                                    AwesomeDialog(
                                                                      context:
                                                                          context,
                                                                      animType:
                                                                          AnimType
                                                                              .rightSlide,
                                                                      headerAnimationLoop:
                                                                          false,
                                                                      dialogType:
                                                                          DialogType
                                                                              .SUCCES,
                                                                      title:
                                                                          'Succes',
                                                                      desc:
                                                                          "Your Data has been changed",
                                                                      dismissOnTouchOutside:
                                                                          false,
                                                                      btnOkOnPress:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      btnOkIcon:
                                                                          Icons
                                                                              .check_circle,
                                                                    ).show();
                                                                  }
                                                                }),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ]);
                                                });
                                          })
                                    ],
                                  ),
                                )),
                          );
                        }
                      } else {
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
                                        padding: const EdgeInsets.all(
                                            kDefaultPadding),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(
                                                kDefaultPadding),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                FutureBuilder<DocumentSnapshot>(
                                                    future: users.doc(id).get(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                DocumentSnapshot>
                                                            snapshot) {
                                                      //Error Handling conditions
                                                      if (snapshot.hasError) {
                                                        return const Text(
                                                            "Something went wrong");
                                                      }

                                                      if (snapshot.hasData &&
                                                          !snapshot
                                                              .data!.exists) {
                                                        return const Text(
                                                            "Document does not exist");
                                                      }

                                                      //Data is output to the user
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        Map<String, dynamic> e =
                                                            snapshot.data!
                                                                    .data()
                                                                as Map<String,
                                                                    dynamic>;

                                                        String role =
                                                            "${e['role']}";

                                                        return Container(
                                                          width: 40.w,
                                                          height: 4.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                kSecondaryColor
                                                                    .withOpacity(
                                                                        0.4),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        kDefaultPadding),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              role,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption,
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }),
                                              ],
                                            ),
                                            kHalfSizedBox,
                                            FeeDetailRow(
                                              title: 'Nama',
                                              statusValue:
                                                  "${e['namaLengkap']}",
                                            ),
                                            SizedBox(
                                              height: kDefaultPadding,
                                              child: Divider(
                                                thickness: 1.0,
                                              ),
                                            ),
                                            FeeDetailRow(
                                              title: 'Jurusan',
                                              statusValue: "${e['kejuruan']}",
                                            ),
                                            sizedBox,
                                            FeeDetailRow(
                                              title: 'Agama',
                                              statusValue: "${e['agama']}",
                                            ),
                                            sizedBox,
                                            FeeDetailRow(
                                              title: 'Jenis Kelamin',
                                              statusValue:
                                                  "${e['jenisKelamin']}",
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
                                              statusValue:
                                                  "${e['tahunAjaran']}",
                                            ),
                                          ],
                                        ),
                                      ),
                                      FeeButton(
                                          title: "Detail",
                                          iconData:
                                              Icons.arrow_forward_outlined,
                                          onPress: () {
                                            add1.text = e["namaLengkap"];
                                            add2.text = e["email"];
                                            add3.text = e["nis"];
                                            add4.text = e["nisn"];
                                            add5.text = e["tahunAjaran"];
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      scrollable: true,
                                                      content: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Form(
                                                            key: _formKey,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                TextFormField(
                                                                  controller:
                                                                      add2,
                                                                  enabled:
                                                                      false,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors.grey[
                                                                            100],
                                                                    labelText:
                                                                        'Email',
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .email),
                                                                  ),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Please input your Email';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                                kHalfSizedBox,
                                                                TextFormField(
                                                                  controller:
                                                                      add1,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Name',
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.blue),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .person),
                                                                  ),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Please input your Name';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                                kHalfSizedBox,
                                                                TextFormField(
                                                                  controller:
                                                                      add3,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.blue),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .view_quilt),
                                                                    labelText:
                                                                        'NIS',
                                                                  ),
                                                                ),
                                                                kHalfSizedBox,
                                                                TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller:
                                                                      add4,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.blue),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .streetview),
                                                                    labelText:
                                                                        'NISN',
                                                                  ),
                                                                ),
                                                                kHalfSizedBox,
                                                                TextFormField(
                                                                  controller:
                                                                      add5,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      borderSide:
                                                                          const BorderSide(),
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.blue),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    prefixIcon:
                                                                        const Icon(
                                                                            Icons.school),
                                                                    labelText:
                                                                        'Tahun Ajaran',
                                                                  ),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Input Tahun Ajaran';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      actions: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      25),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .red),
                                                                  shape: MaterialStateProperty
                                                                      .all<
                                                                          RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onPressed: (() {
                                                                  dataSiswa
                                                                      .doc(e.id)
                                                                      .delete();
                                                                  add1.clear();
                                                                  add2.clear();
                                                                  add3.clear();
                                                                  add4.clear();
                                                                  add5.clear();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }),
                                                                child: const Text(
                                                                    "Delete"),
                                                              ),
                                                              kHalfWidthSizedBox,
                                                              ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          blue7Color),
                                                                  shape: MaterialStateProperty
                                                                      .all<
                                                                          RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // ignore: sort_child_properties_last
                                                                child: const Text(
                                                                    "Update"),
                                                                onPressed: (() {
                                                                  if (_formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    dataSiswa
                                                                        .doc(e
                                                                            .id)
                                                                        .update({
                                                                      "namaLengkap":
                                                                          add1.text,
                                                                      "email": add2
                                                                          .text,
                                                                      "nis": add3
                                                                          .text,
                                                                      "nisn": add4
                                                                          .text,
                                                                      "tahunAjaran":
                                                                          add5.text,
                                                                    });
                                                                    add1.clear();
                                                                    add2.clear();
                                                                    add3.clear();
                                                                    add4.clear();

                                                                    AwesomeDialog(
                                                                      context:
                                                                          context,
                                                                      animType:
                                                                          AnimType
                                                                              .rightSlide,
                                                                      headerAnimationLoop:
                                                                          false,
                                                                      dialogType:
                                                                          DialogType
                                                                              .SUCCES,
                                                                      title:
                                                                          'Succes',
                                                                      desc:
                                                                          "Your Data has been changed",
                                                                      dismissOnTouchOutside:
                                                                          false,
                                                                      btnOkOnPress:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      btnOkIcon:
                                                                          Icons
                                                                              .check_circle,
                                                                    ).show();
                                                                  }
                                                                }),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ]);
                                                });
                                          })
                                    ],
                                  ),
                                )),
                          );
                        } else {
                          return Container();
                        }
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
