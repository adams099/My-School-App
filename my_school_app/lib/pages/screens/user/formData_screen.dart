import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_school_app/constants.dart';
import 'package:my_school_app/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../auth/auth_page.dart';
import '../../../components/my_dialog_textfield.dart';

var controllerJurusan = TextEditingController();
var controllerNis = TextEditingController();
var controllerNisn = TextEditingController();
var controllerAgama = TextEditingController();
var controllerTtl = TextEditingController();
var controllerNama = TextEditingController();
var controllerGender = TextEditingController();
var controllerAlamat = TextEditingController();
String itemS = "";

class FormData extends StatefulWidget {
  const FormData({Key? key}) : super(key: key);
  static String routeName = 'FormData';

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _showDialog();
    });
  }

  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980, 1),
        lastDate: DateTime.now(),
        builder: (context, picker) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: blue7Color,
                onPrimary: Colors.white,
                surface: blue7Color,
                onSurface: Colors.white,
              ),
            ),
            child: picker!,
          );
        }).then((selectedDate) {
      //TODO: handle selected date
      if (selectedDate != null) {
        controllerTtl.text = selectedDate.toString().substring(0, 10);
      }
    });
  }

  _showDialog() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      borderSide: const BorderSide(color: Colors.green, width: 2),
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'INFO',
      desc: 'Setelah melengkapi Data Diri\nSilahkan Login kembali.',
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    final _formKey = GlobalKey<FormState>();
    var dataSiswa = FirebaseFirestore.instance.collection("bioData");
    var users = FirebaseFirestore.instance.collection("users");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      //app bar theme for tablet
      appBar: AppBar(
        elevation: 0,
        backgroundColor: blue7Color,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.INFO,
                borderSide: const BorderSide(color: Colors.green, width: 2),
                buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
                headerAnimationLoop: false,
                animType: AnimType.BOTTOMSLIDE,
                title: 'INFO',
                desc:
                    'Setelah melengkapi Data Diri Anda\nSilahkan Login kembali.',
                btnOkOnPress: () {},
              ).show();
            },
            icon: const Icon(
              Icons.info_outline,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: kOtherColor,
          child: Column(
            children: [
              Container(
                width: 100.w,
                height: SizerUtil.deviceType == DeviceType.tablet ? 19.h : 15.h,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: kBottomBorderRadius,
                ),
                child: FutureBuilder<DocumentSnapshot>(
                    future: users.doc(user!.uid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      //Error Handling conditions
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return const Text("Document does not exist");
                      }

                      //Data is output to the user
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        String nama = "${data['name']}";
                        String email = "${data['email']}";
                        String imgUrl = "${data['imgUrl']}";

                        List<String> words = nama.split(" ");
                        String firstWord = words[0];

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: SizerUtil.deviceType == DeviceType.tablet
                                  ? 12.w
                                  : 13.w,
                              backgroundColor: kSecondaryColor,
                              backgroundImage: NetworkImage(imgUrl),
                            ),
                            kWidthSizedBox,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  firstWord,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: kTextWhiteColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: kTextWhiteColor,
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            )
                          ],
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
              FutureBuilder<DocumentSnapshot>(
                  future: dataSiswa.doc(user!.uid).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    //Error Handling conditions
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return const Text("Document does not exist");
                    }

                    //Data is output to the user
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      String nama = "${data['namaLengkap']}";
                      String agama = "${data['agama']}";
                      String alamat = "${data['alamat']}";
                      String jenisKelamin = "${data['jenisKelamin']}";
                      String thnAjaran = "${data['tahunAjaran']}";
                      String jurusan = "${data['kejuruan']}";
                      String nis = "${data['nis']}";
                      String nisn = "${data['nisn']}";
                      String ttl = "${data['ttl']}";
                      String email = "${data['email']}";

                      return Column(
                        children: [
                          sizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: ProfileDetailRow(
                                  title: 'Jurusan',
                                  value: jurusan,
                                  icon: Icons.edit,
                                ),
                                onTap: () {
                                  controllerJurusan.text = jurusan;
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MyDialogDropDown(
                                          controller: controllerJurusan,
                                          data: itemS,
                                          field: 'kejuruan',
                                          formKey: _formKey,
                                          items: const [
                                            "Hukum",
                                            "Informatika",
                                            "IPS - Soshum",
                                            "FK - Kedokteran",
                                            "Seni dan Desain",
                                            "FKIP - Ilmu Pendidikan",
                                          ],
                                          labelText: 'Jurusan',
                                          nullName: 'Jurusan',
                                          stt: () {
                                            setState(() {});
                                          },
                                        );
                                      });
                                },
                              ),
                              GestureDetector(
                                  child: ProfileDetailRow(
                                    title: 'Tahun Ajaran',
                                    value: thnAjaran,
                                    icon: Icons.lock_outline,
                                  ),
                                  onTap: () {}),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: ProfileDetailRow(
                                  title: 'NIS',
                                  value: nis,
                                  icon: Icons.edit,
                                ),
                                onTap: () {
                                  controllerNis.text = nis;
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MyDialogTextField(
                                          controller: controllerNis,
                                          field: 'nis',
                                          formKey: _formKey,
                                          labelText: 'NIS',
                                          stt: () {
                                            setState(() {});
                                          },
                                          keyboardType: TextInputType.number,
                                          nullName: 'NIS',
                                        );
                                      });
                                },
                              ),
                              GestureDetector(
                                child: ProfileDetailRow(
                                  title: 'NISN',
                                  value: nisn,
                                  icon: Icons.edit,
                                ),
                                onTap: () {
                                  controllerNisn.text = nisn;
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MyDialogTextField(
                                          controller: controllerNisn,
                                          field: 'nisn',
                                          formKey: _formKey,
                                          labelText: 'NISN',
                                          stt: () {
                                            setState(() {});
                                          },
                                          keyboardType: TextInputType.number,
                                          nullName: 'NISN',
                                        );
                                      });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: ProfileDetailRow(
                                  title: 'Agama',
                                  value: agama,
                                  icon: Icons.edit,
                                ),
                                onTap: () {
                                  controllerAgama.text = agama;
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MyDialogDropDown(
                                          controller: controllerAgama,
                                          data: itemS,
                                          field: 'agama',
                                          formKey: _formKey,
                                          items: const [
                                            "Islam",
                                            "Kristen",
                                            "Katolik",
                                            "Hindu",
                                            "Budha",
                                            "Konghucu"
                                          ],
                                          labelText: 'Agama',
                                          nullName: 'Agama',
                                          stt: () {
                                            setState(() {});
                                          },
                                        );
                                      });
                                },
                              ),
                              GestureDetector(
                                child: ProfileDetailRow(
                                  title: 'Tanggal Lahir',
                                  value: ttl,
                                  icon: Icons.edit,
                                ),
                                onTap: () {
                                  controllerTtl.text = ttl;
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
                                                  const EdgeInsets.all(10.0),
                                              child: Form(
                                                key: _formKey,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextFormField(
                                                      onTap: _showDatePicker,
                                                      controller: controllerTtl,
                                                      readOnly: true,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            'Tanggal Lahir',
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "Tanggal Lahir Harap dilengkapi";
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: blue7Color,
                                                ),
                                                // ignore: sort_child_properties_last
                                                child: const Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: blue7Color,
                                                ),
                                                // ignore: sort_child_properties_last
                                                child: const Text("Submit"),
                                                onPressed: (() {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      dataSiswa
                                                          .doc(user!.uid)
                                                          .update({
                                                        "ttl":
                                                            controllerTtl.text,
                                                      });
                                                    });
                                                    controllerTtl.clear();

                                                    AwesomeDialog(
                                                      context: context,
                                                      animType:
                                                          AnimType.LEFTSLIDE,
                                                      headerAnimationLoop:
                                                          false,
                                                      dialogType:
                                                          DialogType.SUCCES,
                                                      dismissOnTouchOutside:
                                                          false,
                                                      title: 'Succes',
                                                      desc:
                                                          "Your Data has been changed",
                                                      btnOkOnPress: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      btnOkIcon:
                                                          Icons.check_circle,
                                                    ).show();
                                                  }
                                                }),
                                              )
                                            ]);
                                      });
                                },
                              ),
                            ],
                          ),
                          sizedBox,
                          GestureDetector(
                            child: ProfileDetailColumn(
                              title: 'Nama Lengkap',
                              value: nama,
                              icon: Icons.edit,
                            ),
                            onTap: () {
                              controllerNama.text = nama;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MyDialogTextField(
                                      controller: controllerNama,
                                      field: 'namaLengkap',
                                      formKey: _formKey,
                                      labelText: 'Nama Lengkap',
                                      stt: () {
                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.name,
                                      nullName: 'Nama Lengkap',
                                    );
                                  });
                            },
                          ),
                          GestureDetector(
                            child: ProfileDetailColumn(
                              title: 'Email',
                              value: email,
                              icon: Icons.lock_outline,
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: ProfileDetailColumn(
                              title: 'Jenis Kelamin',
                              value: jenisKelamin,
                              icon: Icons.edit,
                            ),
                            onTap: () {
                              controllerGender.text = jenisKelamin;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MyDialogDropDown(
                                      controller: controllerGender,
                                      data: itemS,
                                      field: 'jenisKelamin',
                                      formKey: _formKey,
                                      items: const ["Laki - Laki", "Perempuan"],
                                      labelText: 'Jenis Kelamin',
                                      nullName: 'Jenis Kelamin',
                                      stt: () {
                                        setState(() {});
                                      },
                                    );
                                  });
                            },
                          ),
                          GestureDetector(
                            child: ProfileDetailColumn(
                              title: 'Alamat',
                              value: alamat,
                              icon: Icons.edit,
                            ),
                            onTap: () {
                              controllerAlamat.text = alamat;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MyDialogTextFieldMxLine(
                                      controller: controllerAlamat,
                                      field: 'alamat',
                                      formKey: _formKey,
                                      labelText: 'Alamat',
                                      stt: () {
                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.name,
                                      nullName: 'Alamat',
                                      maxLines: 3,
                                    );
                                  });
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.WARNING,
                                  headerAnimationLoop: false,
                                  animType: AnimType.TOPSLIDE,
                                  showCloseIcon: true,
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
                                  }).show();
                            },
                            child: Container(
                              height: 7.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    const Color.fromRGBO(127, 133, 231, 1),
                                    blue7Color,
                                  ])),
                              child: const Center(
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          sizedBox,
                        ],
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow(
      {Key? key, required this.title, required this.value, required this.icon})
      : super(key: key);
  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: kTextBlackColor,
                      fontSize: SizerUtil.deviceType == DeviceType.tablet
                          ? 7.sp
                          : 9.sp,
                    ),
              ),
              kHalfSizedBox,
              Text(value, style: Theme.of(context).textTheme.caption),
              kHalfSizedBox,
              SizedBox(
                width: 35.w,
                child: const Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          Icon(
            icon,
            size: 10.sp,
          ),
        ],
      ),
    );
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: kTextBlackColor,
                      fontSize: SizerUtil.deviceType == DeviceType.tablet
                          ? 7.sp
                          : 11.sp,
                    ),
              ),
              kHalfSizedBox,
              SizedBox(
                width: c_width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value,
                      style: Theme.of(context).textTheme.caption,
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
              ),
              kHalfSizedBox,
              SizedBox(
                width: 92.w,
                child: const Divider(
                  thickness: 1.0,
                ),
              )
            ],
          ),
          Icon(
            icon,
            size: 10.sp,
          ),
        ],
      ),
    );
  }
}
