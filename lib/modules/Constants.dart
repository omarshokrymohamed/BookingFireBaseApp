import 'package:booking_app/modules/EditProfile/EditProfile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modules/login/login_screen.dart';

void check(BuildContext ctx, FirebaseAuth auth) async {
  await auth.signOut();
  Navigator.pushReplacement(
      ctx, MaterialPageRoute(builder: (context) => LoginScreen()));
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
    @required this.auth,
    @required this.imageUrl,
  }) : super(key: key);

  final FirebaseAuth auth;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: new IconButton(
        icon: new Icon(Icons.logout),
        onPressed: () {
          check(context, auth);
        },
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfile(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 10, top: 5),
            padding: EdgeInsets.only(bottom: 3),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}

class MyAppBar2 extends StatelessWidget {
  const MyAppBar2({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
    );
  }
}

ThemeData DarkTheme = ThemeData(
  accentColor: Colors.white,
  brightness: Brightness.dark,
  primaryColor: Colors.amber[600],
  buttonColor: Colors.amber[600],
);
ThemeData LightTheme = ThemeData(
  accentColor: Colors.black,
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  buttonColor: Colors.blue,
);
bool darkOn = false;
