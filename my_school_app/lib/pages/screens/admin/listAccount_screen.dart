import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_school_app/constants.dart';
import 'package:my_school_app/theme.dart';
import 'package:sizer/sizer.dart';
import '../../../components/widgets/assignment_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';

final _formKey = GlobalKey<FormState>();
final add1 = TextEditingController();
final add2 = TextEditingController();
final add3 = TextEditingController();
String itemRole = "";

// ignore: must_be_immutable
class ListAccountScreen extends StatelessWidget {
  ListAccountScreen({Key? key}) : super(key: key);
  static String routeName = 'ListAccountScreen';

  var users = FirebaseFirestore.instance.collection('users');
  var usersQ = FirebaseFirestore.instance
      .collection('users')
      .orderBy('createAt', descending: true);
  var dataSiswa = FirebaseFirestore.instance.collection('bioData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: blue7Color,
        title: Text('List Account'),
        centerTitle: true,
      ),
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: usersQ.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text('Terjadi kesalahan ${snapshot.error}'));
              } else if (snapshot.hasData) {
                int user = snapshot.data!.docs.length;
                if (user == 0) {
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
                        children: snapshot.data!.docs
                            .map((e) => GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: kOtherColor,
                                      borderRadius: kTopBorderRadius,
                                    ),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          kHalfSizedBox,
                                          Container(
                                            margin: const EdgeInsets.only(
                                              bottom: kDefaultPadding,
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                      kDefaultPadding),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kDefaultPadding),
                                                    color: kOtherColor,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: kTextLightColor,
                                                        blurRadius: 2.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 40.w,
                                                        height: 4.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: kSecondaryColor
                                                              .withOpacity(0.4),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  kDefaultPadding),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "${e['role']}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption,
                                                          ),
                                                        ),
                                                      ),
                                                      sizedBox,
                                                      Text(
                                                        "${e['name']}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2!
                                                            .copyWith(
                                                              color:
                                                                  kTextBlackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                            ),
                                                      ),
                                                      kHalfSizedBox,
                                                      AssignmentDetailRow(
                                                        title: 'Email ',
                                                        statusValue:
                                                            "${e['email']}",
                                                      ),
                                                      kHalfSizedBox,
                                                      AssignmentDetailRow(
                                                        title: 'Last Date',
                                                        statusValue:
                                                            "${e['createAt']}",
                                                      ),
                                                      sizedBox,
                                                      AssignmentButton(
                                                        title: 'Update',
                                                        onPress: () {
                                                          add1.text = e["name"];
                                                          add2.text =
                                                              e["email"];
                                                          add3.text = e["role"];
                                                          String tahunAjaran =
                                                              e["tahunAjaran"];
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    scrollable:
                                                                        true,
                                                                    content: Padding(
                                                                        padding: const EdgeInsets.all(10.0),
                                                                        child: Form(
                                                                          key:
                                                                              _formKey,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              TextFormField(
                                                                                controller: add1,
                                                                                decoration: InputDecoration(
                                                                                  labelText: 'Name',
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                    borderSide: const BorderSide(),
                                                                                  ),
                                                                                  border: OutlineInputBorder(
                                                                                    borderSide: const BorderSide(color: Colors.blue),
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                  ),
                                                                                  prefixIcon: const Icon(Icons.person),
                                                                                ),
                                                                                validator: (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return 'Please input your Name';
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                              ),
                                                                              kHalfSizedBox,
                                                                              TextFormField(
                                                                                controller: add2,
                                                                                decoration: InputDecoration(
                                                                                  labelText: 'Email',
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                    borderSide: const BorderSide(),
                                                                                  ),
                                                                                  border: OutlineInputBorder(
                                                                                    borderSide: const BorderSide(color: Colors.blue),
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                  ),
                                                                                  prefixIcon: Icon(Icons.email),
                                                                                ),
                                                                                validator: (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return 'Please input your Email';
                                                                                  }
                                                                                  if (!EmailValidator.validate(value)) {
                                                                                    return 'Please enter a valid email';
                                                                                  }
                                                                                  return null;
                                                                                },
                                                                              ),
                                                                              kHalfSizedBox,
                                                                              DropdownSearch<String>(
                                                                                popupProps: const PopupProps.menu(
                                                                                  fit: FlexFit.loose,
                                                                                  showSelectedItems: true,
                                                                                ),
                                                                                items: const [
                                                                                  "Admin",
                                                                                  "User"
                                                                                ],
                                                                                onChanged: ((value) {
                                                                                  itemRole = value!;
                                                                                }),
                                                                                dropdownDecoratorProps: DropDownDecoratorProps(
                                                                                    dropdownSearchDecoration: InputDecoration(
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                    borderSide: const BorderSide(),
                                                                                  ),
                                                                                  border: OutlineInputBorder(
                                                                                    borderSide: const BorderSide(color: Colors.blue),
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                  ),
                                                                                  prefixIcon: const Icon(Icons.enhanced_encryption),
                                                                                  labelText: "Role",
                                                                                )),
                                                                                selectedItem: add3.text,
                                                                                validator: (value) {
                                                                                  if (value == null || value.isEmpty) {
                                                                                    return 'Input Role';
                                                                                  }
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )),
                                                                    actions: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              IconButton(
                                                                                onPressed: () {
                                                                                  String nama = e['name'];
                                                                                  List<String> words = nama.split(" ");
                                                                                  String firstWord = words[0];
                                                                                  AwesomeDialog(
                                                                                    context: context,
                                                                                    dialogType: DialogType.warning,
                                                                                    borderSide: const BorderSide(color: Colors.green, width: 2),
                                                                                    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
                                                                                    headerAnimationLoop: false,
                                                                                    animType: AnimType.topSlide,
                                                                                    title: 'Add',
                                                                                    desc: "Yakin menambahkan Biodata User $firstWord \njika sudah ada data maka akan ditimpa!",
                                                                                    btnCancelOnPress: () {},
                                                                                    btnOkOnPress: () {
                                                                                      dataSiswa.doc(e.id).set({
                                                                                        "agama": "",
                                                                                        "alamat": "",
                                                                                        "email": add2.text,
                                                                                        "imgUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1BwYl1Svb2h_YRhj9tcnZk0yAuIHh3oBM03dzDa8f&s",
                                                                                        "jenisKelamin": "",
                                                                                        "kejuruan": "",
                                                                                        "namaLengkap": add1.text,
                                                                                        "nis": "",
                                                                                        "nisn": "",
                                                                                        "tahunAjaran": tahunAjaran,
                                                                                        "ttl": "",
                                                                                      });
                                                                                    },
                                                                                  ).show();
                                                                                },
                                                                                icon: Icon(
                                                                                  Icons.add_box,
                                                                                  color: blue7Color,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all<Color>(blue7Color),
                                                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                    RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(15),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                // ignore: sort_child_properties_last
                                                                                child: const Text("Cancel"),
                                                                                onPressed: (() {
                                                                                  add1.clear();
                                                                                  add2.clear();
                                                                                  add3.clear();
                                                                                  Navigator.of(context).pop();
                                                                                }),
                                                                              ),
                                                                              kHalfWidthSizedBox,
                                                                              ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all<Color>(blue7Color),
                                                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                    RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(15),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                // ignore: sort_child_properties_last
                                                                                child: const Text("Update"),
                                                                                onPressed: (() {
                                                                                  if (_formKey.currentState!.validate()) {
                                                                                    users.doc(e.id).update({
                                                                                      "name": add1.text,
                                                                                      "email": add2.text,
                                                                                      "role": itemRole,
                                                                                      "createAt": "${DateTime.now()}",
                                                                                    });

                                                                                    add1.clear();
                                                                                    add2.clear();
                                                                                    add3.clear();

                                                                                    AwesomeDialog(
                                                                                      context: context,
                                                                                      animType: AnimType.rightSlide,
                                                                                      headerAnimationLoop: false,
                                                                                      dialogType: DialogType.SUCCES,
                                                                                      title: 'Succes',
                                                                                      desc: "Your Data has been changed",
                                                                                      dismissOnTouchOutside: false,
                                                                                      btnOkOnPress: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      btnOkIcon: Icons.check_circle,
                                                                                    ).show();
                                                                                  }
                                                                                }),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ]);
                                                              });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()),
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
