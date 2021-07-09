import 'package:booking_app/modules/login/login_screen.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:booking_app/shared/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../User.dart';
import '../BottomNavigatorBar/BottomNavigatorBar.dart';
import '../Provider.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SplashScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final authh = FirebaseAuth;

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    List<Map<String, String>> splashContent = [
      {
        "text": "Welcome to Booking App, Let’s start!",
        "image": "assets/images/splash_2.png"
      },
      {
        "text": "Welcome to Booking App, Let’s start \n",
        "image": "assets/images/splash_1.png"
      },
      {
        "text": "Welcome to Booking App, \nJust stay at home with us",
        "image": "assets/images/splash_3.png"
      }
    ];
    return BlocProvider(
      create: (BuildContext context) => SplashScreenCubit(),
      child: BlocConsumer<SplashScreenCubit, SplashScreenStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15.0),
              ),
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          SplashScreenCubit.get(context).changePage(value);
                        },
                        itemCount: splashContent.length,
                        itemBuilder: (BuildContext context, int index) =>
                            splashContentItem(
                          flex: 2,
                          textContent: splashContent[index]['text'],
                          image: splashContent[index]['image'],
                        ),
                      )),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Row(
                          children: List.generate(
                            splashContent.length,
                            (index) => buildDot(
                                index: index,
                                currentPage:
                                    SplashScreenCubit.get(context).currentPage),
                          ),
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        Spacer(),
                        if (SplashScreenCubit.get(context).currentPage != 3)
                          Consumer<Providerr>(
                            builder:
                                (BuildContext context, provider, Widget child) {
                              return FlatButton(
                                onPressed: () async {
                                  final auth =
                                      FirebaseAuth.instance.currentUser;

                                  if (auth == null)
                                    navigateAndFinish(
                                      context: context,
                                      route: LoginScreen(),
                                    );
                                  else {
                                    await _fetch(auth.uid, provider);
                                    navigateAndFinish(
                                      context: context,
                                      route: BottomNavigator(),
                                    );
                                  }
                                },
                                child: Text(
                                  (SplashScreenCubit.get(context).currentPage ==
                                          2)
                                      ? 'Finish'
                                      : 'Skip',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: getProportionateScreenWidth(12),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, state) {},
      ),
    );
  }
}
