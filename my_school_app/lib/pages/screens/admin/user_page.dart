import 'package:flutter/material.dart';
import '../../../theme.dart';

class ProfileScrenn extends StatelessWidget {
  static String routeName = 'ProfileScrenn';
  final String name;
  final String urlImage;

  const ProfileScrenn({
    Key? key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: blue7Color,
          title: Text(name),
          centerTitle: true,
        ),
        body: Image.network(
          urlImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
}
