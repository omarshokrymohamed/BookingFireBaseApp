import 'dart:io';

import 'package:booking_app/modules/Constants.dart';
import 'package:booking_app/modules/Provider.dart';
import 'package:booking_app/modules/fieldDetails/field_details.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:booking_app/shared/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FieldsScreen extends StatefulWidget {
  List<Map<String, String>> fields = [];
  FieldsScreen({@required this.fields});
  @override
  _FieldsScreenState createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    bool favorite = false;
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    final areaController = TextEditingController();
    final costController = TextEditingController();
    final fieldsNumberController = TextEditingController();
    final startController = TextEditingController();
    final endController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    store.CollectionReference Field =
        store.FirebaseFirestore.instance.collection('fields');

    File _image;
    final picker = ImagePicker();
    bool isCamera;
    String imageUrl = 'none';
    final auth = FirebaseAuth.instance;

    void toggleFav(String name) async {
      int numberOfFavs;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser.uid)
          .collection('favorites')
          .doc('fields')
          .get()
          .then(
        (ds) async {
          numberOfFavs = ds.data()['numberoffavorites'];
          int i = 0;
          for (i; i < numberOfFavs; i++) {
            if (name == ds.data()['field' + (i + 1).toString()]) {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(auth.currentUser.uid)
                  .collection('favorites')
                  .doc('fields')
                  .update(
                    {
                      'numberoffavorites': numberOfFavs - 1,
                      'field' + (i + 1).toString(): FieldValue.delete()
                    },
                  )
                  .then((value) => print("User Deleted"))
                  .catchError((error) => print("Failed to add user: $error"))
                  .catchError((e) {
                    print(e);
                  });

              String name;
              if (i != numberOfFavs - 1) {
                int j = i + 1;
                print("here" + i.toString());
                for (j; j < numberOfFavs; j++) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(auth.currentUser.uid)
                      .collection('favorites')
                      .doc('fields')
                      .get()
                      .then(
                    (ds) {
                      name = ds.data()['field' + (j + 1).toString()];
                    },
                  ).catchError((e) {
                    print(e);
                  });
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(auth.currentUser.uid)
                      .collection('favorites')
                      .doc('fields')
                      .update(
                        {
                          'field' + (j + 1).toString(): FieldValue.delete(),
                          'field' + (j).toString(): name,
                        },
                      )
                      .then((value) => print("User Deleted"))
                      .catchError(
                          (error) => print("Failed to add user: $error"))
                      .catchError((e) {
                        print(e);
                      });
                }
              }
              break;
            }
          }
          if (i == numberOfFavs) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(auth.currentUser.uid)
                .collection('favorites')
                .doc('fields')
                .update(
                  {
                    'numberoffavorites': numberOfFavs + 1,
                    'field' + (numberOfFavs + 1).toString(): name
                  },
                )
                .then((value) => print("User Deleted"))
                .catchError((error) => print("Failed to add user: $error"))
                .catchError((e) {
                  print(e);
                });
          }
        },
      ).catchError((e) {
        print(e);
      });
    }

    Future getImage(BuildContext context, Function function) async {
      if (isCamera) {
        final pickedFile = await picker.getImage(source: ImageSource.camera);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });

          function();
          ;
        } else {
          print('No image selected.');
        }
      } else if (isCamera == false) {
        final pickedFile = await picker.getImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
          function();
        } else {
          print('No image selected.');
        }
      }
    }

    Future uploadFile() async {
      if (_image != null) {
        final ref =
            FirebaseStorage.instance.ref().child('images/${(_image.path)}');
        await ref.putFile(_image).whenComplete(() async {
          await ref.getDownloadURL().then(
            (value) {
              imageUrl = value;
              print("here");
            },
          );
        });
      }
    }

    Future<void> addField() {
      if (_image == null) {
        return Field.doc(nameController.text)
            .set(
              {
                'area': areaController.text,
                'cost': costController.text,
                'fieldsnumber': fieldsNumberController.text,
                'hasimage': 'no',
                'name': nameController.text,
                "phone": phoneController.text,
              },
            )
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      } else {
        return Field.doc(nameController.text)
            .set(
              {
                'area': areaController.text,
                'cost': costController.text,
                'fieldsnumber': fieldsNumberController.text,
                'hasimage': 'yes',
                'imageurl': imageUrl,
                'name': nameController.text,
                "phone": phoneController.text,
              },
            )
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }
    }

    int calculateSlots(int start, int end) {
      return end - start;
    }

    Future<void> addFieldDayStartAndEnd(String day) {
      return Field.doc(nameController.text + day)
          .set(
            {
              'start': int.parse(startController.text),
              'end': int.parse(endController.text),
            },
          )
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    Future<void> addFieldDayIsReserved(String day, int numberOfSlot) {
      return Field.doc(nameController.text + day)
          .update(
            {
              'isreservedslot' + numberOfSlot.toString(): false,
              'numberofslots': numberOfSlot,
            },
          )
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    void addFieldDays() async {
      await addFieldDayStartAndEnd('saturday');
      await addFieldDayStartAndEnd('sunday');
      await addFieldDayStartAndEnd('monday');
      await addFieldDayStartAndEnd('tuesday');
      await addFieldDayStartAndEnd('wednesday');
      await addFieldDayStartAndEnd('thrusday');
      await addFieldDayStartAndEnd('friday');
    }

    void addFieldSlots() async {
      for (int i = 0;
          i <
              calculateSlots(int.parse(startController.text),
                  int.parse(endController.text));
          i++) {
        addFieldDayIsReserved('saturday', i + 1);
        addFieldDayIsReserved('sunday', i + 1);
        addFieldDayIsReserved('monday', i + 1);
        addFieldDayIsReserved('tuesday', i + 1);
        addFieldDayIsReserved('wednesday', i + 1);
        addFieldDayIsReserved('thrusday', i + 1);
        addFieldDayIsReserved('friday', i + 1);
      }
    }

    Future<void> editFieldsInfo() async {
      int numberoffields;
      await FirebaseFirestore.instance
          .collection('fields')
          .doc('fieldsname')
          .get()
          .then((ds) {
        numberoffields = ds.data()['numberoffields'];
      }).catchError((e) {
        print(e);
      });
      return store.FirebaseFirestore.instance
          .collection('fields')
          .doc('fieldsname')
          .update(
            {
              'numberoffields': (numberoffields + 1),
              'field' + (numberoffields + 1).toString(): nameController.text,
              'fieldapproved' + (numberoffields + 1).toString(): false,
            },
          )
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    void _showToast(BuildContext context, String message) {
      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }

    void submit(BuildContext context) async {
      final validationValue = formKey.currentState.validate();
      if (!validationValue) {
        return;
      }

      formKey.currentState.save();
      await editFieldsInfo();
      await addFieldDays();
      await addFieldSlots();
      if (_image != null) {
        await uploadFile();
      }
      await addField();

      _showToast(context, 'Your Field Is Pending , wait for the approve ');

      _image = null;
      Navigator.pop(context);
    }

    int start, end, numberOfSlots;
    bool reserved;
    List<List<Map<String, int>>> slots = [];

    _fetch(String documentID, String fieldName, String Day) async {
      await FirebaseFirestore.instance
          .collection(documentID)
          .doc(fieldName + Day)
          .get()
          .then(
        (ds) {
          start = ds.data()['start'];
          end = ds.data()['end'];
          numberOfSlots = ds.data()['numberofslots'];
          var list = [
            for (var i = start; i < end; i += 1) {'end': i, 'reserved': 0}
          ];
          for (int i = 0; i < numberOfSlots; i++) {
            reserved = ds.data()['isreservedslot' + (i + 1).toString()];

            if (reserved == true) {
              print('isreservedslot' +
                  (i + 1).toString() +
                  'timestamp' +
                  " in" +
                  Day);
              var now = new DateTime.now();
              if (now.isBefore((ds.data()[
                      'isreservedslot' + (i + 1).toString() + 'timestamp'])
                  .toDate())) {
                setState(() {
                  print(fieldName + Day);
                  list.elementAt(i)['reserved'] = 1;
                });
              }
              if (now.difference(ds
                      .data()[
                          'isreservedslot' + (i + 1).toString() + 'timestamp']
                      .toDate()) <
                  Duration(days: 1)) {
                setState(() {
                  print(fieldName + Day);
                  list.elementAt(i)['reserved'] = 1;
                });
              }
            }
          }

          setState(() {
            slots.add(list);
          });
        },
      ).catchError((e) {
        print(e);
      });
    }

    _fetchAll(String documentID, String fieldName) async {
      await _fetch(documentID, fieldName.toLowerCase(), 'saturday');
      await _fetch(documentID, fieldName.toLowerCase(), 'sunday');
      await _fetch(documentID, fieldName.toLowerCase(), 'monday');
      await _fetch(documentID, fieldName.toLowerCase(), 'tuesday');
      await _fetch(documentID, fieldName.toLowerCase(), 'wednesday');
      await _fetch(documentID, fieldName.toLowerCase(), 'thrusday');
      await _fetch(documentID, fieldName.toLowerCase(), 'friday');
    }

    return Scaffold(
      appBar: PreferredSize(
        child: MyAppBar2(title: "Fields"),
        preferredSize: const Size.fromHeight(60),
      ),
      floatingActionButton: new Builder(
        builder: (BuildContext context) {
          return new FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (b) => AlertDialog(
                        insetPadding: EdgeInsets.symmetric(horizontal: 0.5),
                        content: StatefulBuilder(
                          builder: (_, setState) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: Text(
                                          'Join Us',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: kPrimaryColor,
                                                width:
                                                    getProportionateScreenWidth(
                                                        3.0),
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius:
                                                  getProportionateScreenWidth(
                                                      50.0),
                                              backgroundImage: _image == null
                                                  ? AssetImage(
                                                      'assets/images/field1.jpg',
                                                    )
                                                  : FileImage(_image),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: Text(
                                                          "Choosing Image",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        content: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            RaisedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  isCamera =
                                                                      true;
                                                                });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  "camera"),
                                                            ),
                                                            RaisedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  isCamera =
                                                                      false;
                                                                });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  "gallery"),
                                                            ),
                                                          ],
                                                        ),
                                                      )).then((value) =>
                                                  getImage(context, () {
                                                    setState(() {
                                                      _image = _image;
                                                    });
                                                  }));
                                            },
                                            child: Container(
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 20.0,
                                              ),
                                              height: 40.0,
                                              width: 40.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      TextFormField(
                                        onSaved: (value) {
                                          nameController.text = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Pleas Introduce A Value!";
                                          }
                                          return null;
                                        },
                                        controller: nameController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Field Name...',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      TextFormField(
                                        onSaved: (value) {
                                          areaController.text = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Pleas Introduce A Value!";
                                          }
                                          return null;
                                        },
                                        controller: areaController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Field Area...',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      TextFormField(
                                        onSaved: (value) {
                                          costController.text = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Pleas Introduce A Value!";
                                          }
                                          return null;
                                        },
                                        controller: costController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintText:
                                              'Enter Field Cost Per Hour...',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Pleas Introduce A Value!";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          fieldsNumberController.text = value;
                                        },
                                        controller: fieldsNumberController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Fields Number...',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Pleas Introduce A Value!";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          fieldsNumberController.text = value;
                                        },
                                        controller: phoneController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Enter PhoneStart',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Pleas Introduce A Value!";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          fieldsNumberController.text = value;
                                        },
                                        controller: startController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Start',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Pleas Introduce A Value!";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          fieldsNumberController.text = value;
                                        },
                                        controller: endController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Enter End',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      defaultButton(
                                          text: 'Join',
                                          padding: 0.0,
                                          function: () {
                                            submit(context);
                                          },
                                          radius: 24.0),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          );
        },
      ),

      // going to the field
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return buildItem(widget.fields[index], context, toggleFav, () async {
            await _fetchAll('fields', widget.fields[index]['name']);
            navigateTo(
              context: context,
              route: FieldDetails(
                item: widget.fields[index],
                slots: slots,
                comefrom: "notfavorite",
              ),
            );
          });
        },
        itemCount: widget.fields.length,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 10.0,
        ),
      ),
    );
  }

  Widget buildItem(Map item, context, Function favFunction, function) =>
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Consumer<Providerr>(
          builder: (BuildContext context, provider, Widget child) {
            return InkWell(
              onTap: function,
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
                        image: item['hasimages'] == 'no'
                            ? AssetImage("assets/images/field1.jpg")
                            : NetworkImage(item['imageurl']),
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
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  item['name'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              children: [
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  item['area'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      if (item["favorite"] == "no")
                                        setState(() {
                                          item["favorite"] = "yes";
                                        });
                                      else
                                        setState(() {
                                          item["favorite"] = "no";
                                        });
                                      favFunction(item['name']);
                                    },
                                    icon: Icon(
                                      item["favorite"] == "yes"
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item['cost'] + ' EGP',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  '(${item['fields_number']}) Fields',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Text(
                                  item['phone'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
}
