import 'package:booking_app/modules/Constants.dart';
import 'package:booking_app/modules/fields/fields_screen.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:booking_app/shared/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EntertainmentScreen extends StatefulWidget {
  @override
  _EntertainmentScreenState createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  List<bool> Approved = [];
  List<String> fieldsnames = [];
  List<Map<String, String>> fields = [];
  final auth = FirebaseAuth.instance;
  _fetchAll() async {
    fields = [];
    fieldsnames = [];
    Approved = [];
    int numberOfFields;
    await FirebaseFirestore.instance
        .collection('fields')
        .doc('fieldsname')
        .get()
        .then(
      (ds) {
        numberOfFields = ds.data()['numberoffields'];
        for (int i = 0; i < numberOfFields; i++) {
          setState(() {
            fieldsnames.add(ds.data()['field' + (i + 1).toString()]);
            Approved.add(ds.data()['fieldapproved' + (i + 1).toString()]);
          });
          print(i);
        }
      },
    ).catchError((e) {
      print(e);
    });
    for (int i = 0; i < fieldsnames.length; i++) {
      if (Approved[i] == true) await _fetch('fields', fieldsnames.elementAt(i));
    }
  }

  _fetch(String documentID, String fieldName) async {
    String name, area, cost, numberoffields, imageUrl, phone;
    String hasCustomImage;
    int numberofFavs;
    await FirebaseFirestore.instance
        .collection(documentID)
        .doc(fieldName)
        .get()
        .then(
      (ds) {
        hasCustomImage = ds.data()['hasimage'];
        name = ds.data()['name'];
        cost = ds.data()['cost'];
        numberoffields = ds.data()['fieldsnumber'];
        area = ds.data()['area'];
        imageUrl = ds.data()['imageurl'];
        phone = ds.data()['phone'];
      },
    ).catchError((e) {
      print(e);
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('favorites')
        .doc('fields')
        .get()
        .then(
      (dss) {
        numberofFavs = dss.data()['numberoffavorites'];
        int i = 0;

        for (i; i < numberofFavs; i++) {
          if (dss.data()['field' + (i + 1).toString()] == name) {
            setState(() {
              fields.add({
                "name": name,
                "area": area,
                "fields_number": numberoffields,
                "cost": cost,
                "hasimages": hasCustomImage,
                "imageurl": imageUrl,
                "favorite": "yes",
                "phone": phone,
              });
            });
            break;
          }
        }
        if (i == numberofFavs) {
          setState(() {
            fields.add({
              "name": name,
              "area": area,
              "fields_number": numberoffields,
              "cost": cost,
              "hasimages": hasCustomImage,
              "imageurl": imageUrl,
              "favorite": "no",
              "phone": phone
            });
          });
        }
      },
    ).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        child: MyAppBar2(
          title: "Entertainment",
        ),
        preferredSize: const Size.fromHeight(60),
      ),
      body: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: () async {
                await _fetchAll();
                navigateTo(
                  context: context,
                  route: FieldsScreen(
                    fields: fields,
                  ),
                );
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
                        image: AssetImage("assets/images/field.png"),
                        height: 170.0,
                        width: 500.0,
                        fit: BoxFit.fill,
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
                                "Fields",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "Now you can reserve many football fields",
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
      ),
    );
  }
}
