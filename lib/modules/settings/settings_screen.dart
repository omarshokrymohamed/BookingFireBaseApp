import 'package:basic_utils/basic_utils.dart';
import 'package:booking_app/ContactUs.dart';
import 'package:booking_app/modules/EditProfile/EditProfile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import '../Provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<Providerr>(
      builder: (BuildContext context, provider, Widget child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: MyAppBar(
              auth: auth,
              imageUrl: provider.currentUser.imageUrl,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 80, right: 80, top: 20),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: provider.currentUser.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  StringUtils.capitalize(provider.currentUser.name),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 2,
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    SwitchListTile(
                      activeColor: Theme.of(context).primaryColor,
                      value: provider.darkOn,
                      onChanged: (value) {
                        print(provider.darkOn);
                        provider.darkModeActivation(value);
                      },
                      title: Text(
                        "DarkMode",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    ListTile(
                      title: Transform(
                        transform: Matrix4.translationValues(0, 0.0, 0.0),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                          size: 33,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Contact US",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactUs(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.contacts,
                          color: Theme.of(context).primaryColor,
                          size: 33,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
