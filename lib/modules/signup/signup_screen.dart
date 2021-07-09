import 'dart:io';

import 'package:booking_app/shared/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import '../login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var fNameController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isCamera;
  final auth = FirebaseAuth.instance;
  String imageUrl;
  store.CollectionReference users =
      store.FirebaseFirestore.instance.collection('users');
  var documentID;

  Future<void> addUserFieldsFavorites() {
    return users
        .doc(auth.currentUser.uid)
        .collection('favorites')
        .doc('fields')
        .set({
          'numberoffavorites': 0,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addUserWorkSpacesFavorites() {
    return users
        .doc(auth.currentUser.uid)
        .collection('favorites')
        .doc('workspaces')
        .set({
          'numberoffavorites': 0,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addUser() {
    return users
        .doc(auth.currentUser.uid)
        .set({
          'name': fNameController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
          'imageUrl': imageUrl,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future uploadFile() async {
    if (_image != null) {
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

  void onSumbit(BuildContext context) async {
    final validationValue = formKey.currentState.validate();
    if (!validationValue) {
      return;
    }
    if (_image == null) {
      print("here");
      _showToast(context, "You Have To Choose A Pic");
      return;
    }
    formKey.currentState.save();
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      await uploadFile();
      await addUser();
      await addUserFieldsFavorites();
      await addUserWorkSpacesFavorites();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (error) {
      _showToast(context, error.toString());
      print(error);
    }
  }

  File _image;
  final picker = ImagePicker();
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
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("camera"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        isCamera = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("gallery"),
                  ),
                ],
              ),
            )).then((value) => getImage(context));
  }

  Future getImage(BuildContext context) async {
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
                    : message == "You Have To Choose A Pic"
                        ? Text("You Have To Choose A Pic")
                        : Text("some thing went wrong "),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  child: Column(
                    children: [
                      Text(
                        "SignUp",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 320,
                        child: Text(
                          "Complete your details or continue with social media",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 69,
                            backgroundColor: Colors.teal,
                            child: CircleAvatar(
                              backgroundImage: _image == null
                                  ? AssetImage(
                                      "assets/images/profile.png",
                                    )
                                  : FileImage(_image),
                              radius: 65,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            height: 60,
                            left: 100,
                            child: Container(
                              child: CircleAvatar(
                                  backgroundColor: Colors.teal,
                                  child: IconButton(
                                    onPressed: () {
                                      _showAlert(context);
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 20,
                                    ),
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
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
                                  hintText: "Enter your name",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 2.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.5),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 2.5),
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
                                  hintText: "Enter your number",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 2.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.5),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 2.5),
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
                                controller: emailController,
                                onSaved: (value) {
                                  emailController.text = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "pleas produce a value ";
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: "Enter your Email",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 2.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.5),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 2.5),
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
                                  hintText: "Enter your password",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 2.5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.5),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        color: Colors.teal, width: 2.5),
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
                                    onSumbit(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("SignUp"),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                  ),
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
