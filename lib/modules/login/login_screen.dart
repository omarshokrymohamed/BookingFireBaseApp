import 'package:booking_app/User.dart';
import 'package:booking_app/modules/BottomNavigatorBar/BottomNavigatorBar.dart';
import 'package:booking_app/modules/Provider.dart';
import 'package:booking_app/modules/login/cubit/cubit.dart';
import 'package:booking_app/modules/signup/signup_screen.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:booking_app/shared/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  String name, phone, password, imageUrl;
  _fetch(String documentID, Providerr providerr) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(documentID)
          .get()
          .then((ds) {
        name = ds.data()['name'];
        phone = ds.data()['phone'];
        password = ds.data()['password'];
        imageUrl = ds.data()['imageUrl'];

        UserData user = new UserData(
            name: name, pass: password, phone: phone, imageUrl: imageUrl);
        providerr.assignTheUser(user);
      }).catchError((e) {
        print(e);
      });
  }

  void onSubmit(BuildContext ctx, Providerr providerr) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        final user = await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await _fetch(auth.currentUser.uid, providerr);
        Navigator.pushReplacement(
            ctx, MaterialPageRoute(builder: (context) => BottomNavigator()));
      } catch (error) {
        _showToast(ctx, error.toString());
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
                        "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted."
                    ? Text("Email Doesnt Exist !")
                    : message ==
                            "[firebase_auth/wrong-password] The password is invalid or the user does not have a password."
                        ? Text("Passowrd Invalid!")
                        : Text("some thing went wrong "),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Builder(
        builder: (BuildContext context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),

                Text(
                  'WelcomeBack',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(26),
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5.0),
                ),
                Text(
                  'Sign with your email and password',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                  ),
                ),
                Text(
                  'or continue with social media',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                  ),
                ),
                // SizedBox(
                //   height: getProportionateScreenHeight(100.0),
                // ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
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
                          controller: emailController,
                          onSaved: (value) {
                            emailController.text = value;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter your Email",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 2.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.5),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 2.5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25.0),
                      ),
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
                          controller: passwordController,
                          onSaved: (value) {
                            passwordController.text = value;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter your Password",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 2.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.5),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 2.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(25.0),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      activeColor: kPrimaryColor,
                      onChanged: (bool value) {
                        LoginScreenCubit.get(context).changeCheck(value);
                      },
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(4.0),
                    ),
                    Text('Remember me'),
                    Spacer(),
                    Text('Forget Password ?'),
                  ],
                ),

                SizedBox(
                  height: getProportionateScreenHeight(10.0),
                ),
                Consumer<Providerr>(
                  builder: (BuildContext context, provider, Widget child) {
                    return defaultButton(
                        text: 'Continue',
                        padding: 0.0,
                        function: () {
                          onSubmit(context, provider);
                        },
                        radius: 24.0);
                  },
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialItem(
                        icon: 'assets/icons/google-icon.svg', function: () {}),
                    SizedBox(
                      width: getProportionateScreenWidth(15.0),
                    ),
                    socialItem(
                      icon: 'assets/icons/facebook-2.svg',
                      function: () {},
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(15.0),
                    ),
                    socialItem(
                      icon: 'assets/icons/twitter.svg',
                      function: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(25.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ? "),
                    InkWell(
                        onTap: () {
                          navigateTo(context: context, route: SignUpScreen());
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: kPrimaryColor),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
