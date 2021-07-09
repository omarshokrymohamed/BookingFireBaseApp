import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Owners"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 65, right: 50),
        padding: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PersonalCard(
                imageAsset: "assets/images/mohamed.png",
                name: "Mohamed El-Shazly",
                mail: "Muhammed.elshazli@gmail.com",
                phone: "01127793093",
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 10,
                indent: 50,
                endIndent: 50,
                thickness: 2,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              PersonalCard(
                imageAsset: "assets/images/mazen.png",
                name: "Mazen Tamer",
                mail: "Mazentamer911@gmail.com",
                phone: "0115 884 8847",
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 10,
                indent: 50,
                endIndent: 50,
                thickness: 2,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              PersonalCard(
                imageAsset: "assets/images/dareen.png",
                name: "Dareen El-Masry",
                mail: "Dareeneeelmassry@gmail.com",
                phone: "01019022449",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalCard extends StatelessWidget {
  const PersonalCard({
    @required this.imageAsset,
    @required this.name,
    @required this.mail,
    @required this.phone,
    Key key,
  }) : super(key: key);
  @required
  final String imageAsset;
  final String name;
  final String mail;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(imageAsset),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Theme.of(context).accentColor),
        ),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[900], width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.black,
            ),
            title: Transform(
              transform: Matrix4.translationValues(-10, 0.0, 0.0),
              child: Text(
                mail,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[900], width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.black,
            ),
            title: Text(
              phone,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
