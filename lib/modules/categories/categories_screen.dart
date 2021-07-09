import 'package:booking_app/modules/entertainment/entertainment_screen.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:booking_app/shared/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import '../Education.dart';
import '../Provider.dart';

class CategoriesScreen extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<Providerr>(
        builder: (BuildContext context, provider, Widget child) {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: MyAppBar(
                auth: auth,
                imageUrl: provider.currentUser.imageUrl,
              )),
          body: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: InkWell(
                  onTap: () {
                    navigateTo(context: context, route: EducationtScreen());
                  },
                  child: Container(
                    height: 170.0,
                    width: 500.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          child: Image(
                            image: AssetImage("assets/images/books.png"),
                            height: 170.0,
                            width: 500.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color(0xFF343434).withOpacity(0.4),
                                Color(0xFF626262).withOpacity(0.1),
                              ])),
                        ),
                        Container(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Educational",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    "Now you can reserve many educational places",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "like working spaces and training center",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: InkWell(
                  onTap: () {
                    navigateTo(context: context, route: EntertainmentScreen());
                  },
                  child: Container(
                    height: 170.0,
                    width: 500.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          child: Image(
                            image:
                                AssetImage("assets/images/entertainmnet.jpg"),
                            height: 170.0,
                            width: 500.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color(0xFF343434).withOpacity(0.4),
                                Color(0xFF626262).withOpacity(0.1),
                              ])),
                        ),
                        Container(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Entertainment",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    "Here you can reserve many entertainment places",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "like cinemas and football stadium  ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ));
    });
  }
}
