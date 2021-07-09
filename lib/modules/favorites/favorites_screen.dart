import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../WorkSpaceDetails.dart';
import '../fieldDetails/field_details.dart';

class FavoritesScreen extends StatefulWidget {
  List<Map<String, String>> favorites = [];

  FavoritesScreen({@required this.favorites});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
            if (now.isBefore(
                (ds.data()['isreservedslot' + (i + 1).toString() + 'timestamp'])
                    .toDate())) {
              setState(() {
                print(fieldName + Day);
                list.elementAt(i)['reserved'] = 1;
              });
            }
            if (now.difference(ds
                    .data()['isreservedslot' + (i + 1).toString() + 'timestamp']
                    .toDate()) <
                Duration(days: 1)) {
              setState(() {
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
    print(documentID + "here");
    await _fetch(documentID, fieldName.toLowerCase(), 'saturday');
    await _fetch(documentID, fieldName.toLowerCase(), 'sunday');
    await _fetch(documentID, fieldName.toLowerCase(), 'monday');
    await _fetch(documentID, fieldName.toLowerCase(), 'tuesday');
    await _fetch(documentID, fieldName.toLowerCase(), 'wednesday');
    await _fetch(documentID, fieldName.toLowerCase(), 'thrusday');
    await _fetch(documentID, fieldName.toLowerCase(), 'friday');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: MyAppBar2(title: "Favorites"),
        preferredSize: const Size.fromHeight(60),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return buildItem(
            widget.favorites[index],
            context,
            widget.favorites[index]["category"] == "field"
                ? () async {
                    await _fetchAll('fields', widget.favorites[index]['name']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FieldDetails(
                            slots: slots,
                            item: widget.favorites[index],
                            comefrom: "favorite",
                          ),
                        ));
                  }
                : () async {
                    await _fetchAll(
                        'workspaces', widget.favorites[index]['name']);
                    if (widget.favorites[index]["category"] == "field") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FieldDetails(
                                slots: slots,
                                item: widget.favorites[index],
                                comefrom: "favorite"),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkSpaceDetails(
                              numberOfDeletedSlotsPerDay: [],
                              slots: slots,
                              item: widget.favorites[index],
                            ),
                          ));
                    }
                  },
          );
        },
        itemCount: widget.favorites.length,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 10.0,
        ),
      ),
    );
  }

  Widget buildItem(Map item, context, function) => Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: InkWell(
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
                    image: item["hasimages"] == "no"
                        ? item["category"] == "field"
                            ? AssetImage("assets/images/field1.jpg")
                            : AssetImage("assets/images/workspace.png")
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
                            ),
                            Text(
                              item['phone'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
