import 'package:booking_app/modules/categories/categories_screen.dart';
import 'package:booking_app/modules/favorites/favorites_screen.dart';
import 'package:booking_app/modules/settings/settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  List<Map<String, String>> favorites = [];
  List<String> fields = [];
  List<String> workSpaces = [];

  List<Widget> _children;
  int _currentIndex = 0;
  final auth = FirebaseAuth.instance;

  void setCurrentIndex(int x) {
    setState(() {
      _currentIndex = x;
    });
  }

  _fetchFieldsNames() async {
    int numberofFavs;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('favorites')
        .doc('fields')
        .get()
        .then((dss) async {
      numberofFavs = dss.data()['numberoffavorites'];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser.uid)
          .collection('favorites')
          .doc('fields')
          .get()
          .then(
        (dss) async {
          for (int i = 0; i < numberofFavs; i++) {
            fields.add(dss.data()['field' + (i + 1).toString()]);
          }
        },
      ).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }

  _fetchTheFields() async {
    for (int i = 0; i < fields.length; i++) {
      await FirebaseFirestore.instance
          .collection('fields')
          .doc(fields[i])
          .get()
          .then(
        (dss) async {
          setState(() {
            favorites.add({
              "name": dss.data()['name'],
              "area": dss.data()['area'],
              "fields_number": dss.data()['fieldsnumber'],
              "cost": dss.data()['cost'],
              "hasimages": dss.data()['hasimage'],
              "imageurl": dss.data()['imageurl'],
              "category": "field",
              "phone": dss.data()['phone'],
            });
            _children = [
              CategoriesScreen(),
              FavoritesScreen(
                favorites: favorites,
              ),
              SettingsScreen(),
            ];
          });
        },
      ).catchError((e) {
        print(e);
      });
    }
  }

  _fetchWokrspacesNames() async {
    int numberofFavs;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('favorites')
        .doc('workspaces')
        .get()
        .then((dss) async {
      numberofFavs = dss.data()['numberoffavorites'];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser.uid)
          .collection('favorites')
          .doc('workspaces')
          .get()
          .then(
        (dss) async {
          for (int i = 0; i < numberofFavs; i++) {
            workSpaces.add(dss.data()['workspace' + (i + 1).toString()]);
          }
        },
      ).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }

  _fetchTheWorkSpaces() async {
    for (int i = 0; i < workSpaces.length; i++) {
      await FirebaseFirestore.instance
          .collection('workspaces')
          .doc(workSpaces[i])
          .get()
          .then(
        (dss) async {
          setState(() {
            favorites.add({
              "name": dss.data()['name'],
              "area": dss.data()['area'],
              "fields_number": dss.data()['roomsnumber'],
              "cost": dss.data()['cost'],
              "hasimages": dss.data()['hasimage'],
              "imageurl": dss.data()['imageurl'],
              "category": "workspace",
              "phone": dss.data()['phone'],
            });
            _children = [
              CategoriesScreen(),
              FavoritesScreen(
                favorites: favorites,
              ),
              SettingsScreen(),
            ];
          });
        },
      ).catchError((e) {
        print(e);
      });
    }
  }

  void onTabTapped(int index) async {
    if (index == 1) {
      await _fetchFieldsNames();
      await _fetchTheFields();
      await _fetchWokrspacesNames();
      await _fetchTheWorkSpaces();
    } else {
      setState(() {
        favorites = [];
        fields = [];
        workSpaces = [];
      });
    }
    setState(() {
      print(favorites.length);
      _currentIndex = index;
    });
  }

  _BottomNavigatorState() {
    _children = [
      CategoriesScreen(),
      FavoritesScreen(
        favorites: favorites,
      ),
      SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: onTabTapped,

          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.category_outlined),
              title: new Text('Categories'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite_outline),
              title: new Text('Favourites'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Setting'),
            ),
          ],
        ),
      ),
      body: _children[_currentIndex],
    );
  }
}
