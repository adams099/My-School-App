import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';

var dataSiswa = FirebaseFirestore.instance.collection("bioData");

class MyDialogTextField extends StatelessWidget {
  final controller;
  final formKey;
  final String field;
  final String labelText;
  final VoidCallback stt;
  final keyboardType;
  final String nullName;

  const MyDialogTextField({
    super.key,
    required this.controller,
    required this.formKey,
    required this.field,
    required this.labelText,
    required this.stt,
    required this.keyboardType,
    required this.nullName,
  });

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        scrollable: true,
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  labelText: labelText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "$nullName Harap dilengkapi";
                  }
                  return null;
                },
              ),
            ]),
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
              controller.clear();
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
              if (formKey.currentState!.validate()) {
                dataSiswa.doc(user!.uid).update({
                  field: controller.text,
                });
                stt();
                controller.clear();

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
        ]);
  }
}

class MyDialogTextFieldMxLine extends StatelessWidget {
  final controller;
  final formKey;
  final String field;
  final String labelText;
  final VoidCallback stt;
  final keyboardType;
  final String nullName;
  final int maxLines;

  const MyDialogTextFieldMxLine({
    super.key,
    required this.controller,
    required this.formKey,
    required this.field,
    required this.labelText,
    required this.stt,
    required this.keyboardType,
    required this.nullName,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        scrollable: true,
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                maxLines: maxLines,
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  labelText: labelText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "$nullName Harap dilengkapi";
                  }
                  return null;
                },
              ),
            ]),
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
              controller.clear();
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
              if (formKey.currentState!.validate()) {
                dataSiswa.doc(user!.uid).update({
                  field: controller.text,
                });
                stt();
                controller.clear();

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
        ]);
  }
}

class MyDialogDropDown extends StatelessWidget {
  final String field;
  final VoidCallback stt;
  final controller;
  final List<String> items;
  final String data;
  final String labelText;
  final formKey;
  final String nullName;

  const MyDialogDropDown({
    super.key,
    required this.formKey,
    required this.field,
    required this.stt,
    required this.controller,
    required this.items,
    required this.data,
    required this.labelText,
    required this.nullName,
  });

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    String _data = data;
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        scrollable: true,
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  fit: FlexFit.loose,
                  showSelectedItems: true,
                ),
                items: items,
                onChanged: ((value) {
                  _data = value!;
                }),
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText: labelText,
                )),
                selectedItem: controller.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "$nullName Harap dilengkapi";
                  }
                },
              ),
            ]),
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
            child: const Text("Submit"),
            onPressed: (() {
              if (formKey.currentState!.validate()) {
                dataSiswa.doc(user!.uid).update({
                  field: _data,
                });
                stt();
                controller.clear();

                AwesomeDialog(
                  context: context,
                  animType: AnimType.bottomSlide,
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
        ]);
  }
}
