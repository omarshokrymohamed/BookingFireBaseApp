import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:booking_app/modules/Provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    fNameController.text = StringUtils.capitalize(
        Provider.of<Providerr>(context, listen: false).currentUser.name);
    phoneController.text =
        Provider.of<Providerr>(context, listen: false).currentUser.phone;
    passwordController.text =
        Provider.of<Providerr>(context, listen: false).currentUser.pass;
    imageUrl =
        Provider.of<Providerr>(context, listen: false).currentUser.imageUrl;
  }

  String imageUrl;
  var passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  var fNameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  store.CollectionReference users =
      store.FirebaseFirestore.instance.collection('users');

  Future uploadFile() async {
    if (_image != null) {
      await FirebaseStorage.instance
          .refFromURL(Provider.of<Providerr>(context, listen: false)
              .currentUser
              .imageUrl)
          .delete();
      final ref =
          FirebaseStorage.instance.ref().child('images/${(_image.path)}');
      await ref.putFile(_image).whenComplete(() async {
        await ref.getDownloadURL().then(
          (value) {
            imageUrl = value;
          },
        );
      });
    }
  }

  Future<void> addUser() {
    print(imageUrl);
    return users
        .doc(auth.currentUser.uid)
        .set({
          'name': fNameController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
          'imageUrl': imageUrl == null
              ? Provider.of<Providerr>(context, listen: false)
                  .currentUser
                  .imageUrl
              : imageUrl,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> changepassword(BuildContext ctx) async {
    if (passwordController.text ==
        Provider.of<Providerr>(context, listen: false).currentUser.pass)
      return;
    else {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      User currentUser = firebaseAuth.currentUser;
      currentUser
          .updatePassword(passwordController.text)
          .then(
            (value) {},
          )
          .catchError(
        (err) {
          print(err);
          _showToast(ctx, err.toString());
        },
      );
    }
  }

  void sumbit(BuildContext context) async {
    final validationValue = formKey.currentState.validate();
    if (!validationValue) {
      return;
    } else {
      formKey.currentState.save();
      try {
        await changepassword(context);

        await uploadFile();
        await addUser();
        Provider.of<Providerr>(context, listen: false).changeUserInfomation(
            fNameController.text,
            passwordController.text,
            passwordController.text,
            imageUrl);
      } catch (e) {
        print(e);
      }
    }
  }

  File _image;
  bool isCamera;
  bool wayChosen = false;

  final picker = ImagePicker();

  Future getImage(BuildContext context) async {
    if (wayChosen) {
      if (isCamera) {
        final pickedFile = await picker.getImage(source: ImageSource.camera);
        setState(() {
          if (pickedFile != null) {
            _image = File(pickedFile.path);
            print(_image.path);
          } else {
            print('No image selected.');
          }
        });
      } else if (isCamera == false) {
        final pickedFile = await picker.getImage(source: ImageSource.gallery);
        setState(() {
          if (pickedFile != null) {
            _image = File(pickedFile.path);
            print(_image.path);
          } else {
            print('No image selected.');
          }
        });
      }
    }
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: message ==
                "[firebase_auth/invalid-email] The email address is badly formatted."
            ? Text("Your Email Is Badly Formatted")
            : message ==
                    "[firebase_auth/weak-password] Password should be at least 6 characters"
                ? Text("Password Can't Be Less Than 6 characters!")
                : message ==
                        "[firebase_auth/email-already-in-use] The email address is already in use by another account."
                    ? Text("Email Allready Exists !")
                    : message ==
                            "[firebase_auth/requires-recent-login] This operation is sensitive and requires recent authentication. Log in again before retrying this request."
                        ? Text(
                            "To Change Password , You Have To Log In Again !")
                        : Text("something went wrong"),
      ),
    );
  }

  Future<bool> _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Choosing Image",
                textAlign: TextAlign.center,
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        isCamera = true;
                        wayChosen = true;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("camera"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        isCamera = false;
                        wayChosen = true;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("gallery"),
                  ),
                ],
              ),
            )).then((value) => getImage(context));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Providerr>(
      builder: (BuildContext context, provider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Editing Profile"),
          ),
          body: Builder(
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    child: Stack(
                      children: [
                        Container(
                          child: _image == null
                              ? CachedNetworkImage(
                                  imageUrl: provider.currentUser.imageUrl,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 200.0,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(_image),
                                  radius: 100,
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          height: 60,
                          left: 140,
                          child: Container(
                            child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: IconButton(
                                  onPressed: () {
                                    _showAlert(context);
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    size: 22,
                                  ),
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "pleas produce a value ";
                              }
                              return null;
                            },
                            controller: fNameController,
                            onSaved: (value) {
                              fNameController.text = value;
                              print(fNameController.text);
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Enter your name",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(width: 2.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(width: 2.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 10),
                          child: TextFormField(
                            controller: phoneController,
                            onSaved: (value) {
                              phoneController.text = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "pleas produce a value ";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "Phone",
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Enter your number",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(width: 2.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(width: 2.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 10),
                          child: TextFormField(
                            controller: passwordController,
                            onSaved: (value) {
                              passwordController.text = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "pleas produce a value ";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Enter your password",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(width: 2.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.5),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(width: 2.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () {
                                sumbit(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text("Edit"),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
