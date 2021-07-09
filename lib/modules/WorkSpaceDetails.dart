import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as store;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';

class WorkSpaceDetails extends StatefulWidget {
  final Map<String, String> item;
  final List<List<Map<String, int>>> slots;
  final List<int> numberOfDeletedSlotsPerDay;

  WorkSpaceDetails({
    @required this.item,
    @required this.slots,
    @required this.numberOfDeletedSlotsPerDay,
  });

  @override
  _WorkSpaceDetailsState createState() => _WorkSpaceDetailsState();
}

class _WorkSpaceDetailsState extends State<WorkSpaceDetails> {
  @override
  void initState() {
    switch (getDate()) {
      case 1:
        {
          setState(() {
            selectedDay = 2;
            selectedDayy = 'monday';
            values[getDate() % 7] = !values[getDate() % 7];
          });
        }
        break;

      case 2:
        {
          setState(() {
            selectedDay = 3;
            selectedDayy = 'tuesday';
            values[getDate() % 7] = !values[getDate() % 7];
          });
        }
        break;

      case 3:
        {
          setState(() {
            selectedDay = 4;
            selectedDayy = 'wednesday';
            values[getDate() % 7] = !values[getDate() % 7];
          });
        }
        break;
      case 4:
        {
          setState(() {
            selectedDay = 5;
            selectedDayy = 'thrusday';
            values[getDate() % 7] = !values[getDate() % 7];
          });
        }
        break;
      case 5:
        {
          setState(() {
            selectedDay = 6;
            selectedDayy = 'friday';

            values[getDate() % 7] = !values[getDate() % 7];
          });
        }
        break;

      case 6:
        {
          setState(() {
            selectedDayy = 'saturday';
            selectedDay = 0;
            values[getDate() % 7] = !values[getDate() % 7];
          });
        }
        break;
      case 7:
        {
          setState(() {
            selectedDayy = 'sunday';
            selectedDay = 1;
            values[getDate() % 7] = !values[getDate() % 7];
          });
        }
        break;
      default:
        {}
        break;
    }
  }

  final values = List.filled(7, true);
  int selectedSlot = 99;
  int selectedDay = 0;
  String selectedDayy;

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  int getDate() {
    var now = new DateTime.now();
    return now.weekday;
  }

  store.CollectionReference WorkSpaces =
      store.FirebaseFirestore.instance.collection('workspaces');

  String name;
  _fetchUserName() async {
    final auth = FirebaseAuth.instance;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .get()
        .then(
      (ds) {
        name = ds.data()['name'];
      },
    ).catchError((e) {
      print(e);
    });
  }

  Future<void> reserve(
      String doucmentID, String slotname, int modifiedSlotNumber) async {
    await _fetchUserName();

    return WorkSpaces.doc(doucmentID)
        .update(
          {
            'isreservedslot' + (selectedSlot + 1).toString(): true,
            'slot' + (selectedSlot + 1).toString() + " is reserved by": name,
          },
        )
        .then((value) => print("reserved successfully"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> reserveTimeStamp(String doucmentID, int modifiedSlotNumber) {
    var now = new DateTime.now();

    if (selectedDayy == "monday") {
      while (now.weekday != 1) {
        now = now.add(new Duration(days: 1));
      }

      print('Recent monday $now');
    } else if (selectedDayy == "tuesday") {
      while (now.weekday != 2) {
        now = now.add(new Duration(days: 1));
      }

      print('Recent monday $now');
    } else if (selectedDayy == "wednesday") {
      while (now.weekday != 3) {
        now = now.add(new Duration(days: 1));
      }
      print('Recent monday $now');
    } else if (selectedDayy == "thrusday") {
      while (now.weekday != 4) {
        now = now.add(new Duration(days: 1));
      }

      print('Recent monday $now');
    } else if (selectedDayy == "friday") {
      while (now.weekday != 5) {
        now = now.add(new Duration(days: 1));
      }

      print('Recent monday $now');
    } else if (selectedDayy == "saturday") {
      while (now.weekday != 6) {
        now = now.add(new Duration(days: 1));
      }

      print('Recent monday $now');
    } else if (selectedDayy == "sunday") {
      while (now.weekday != 7) {
        now = now.add(new Duration(days: 1));
      }

      print('Recent monday $now');
    }

    return WorkSpaces.doc(doucmentID)
        .update({
          'isreservedslot' + (selectedSlot + 1).toString() + 'timestamp': now
        })
        .then((value) => print("reserved successfully" + now.toString()))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void _showToast2(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                message,
                textAlign: TextAlign.center,
              ),
              content: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            )).then((value) => () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date And Time'),
      ),
      body: Builder(
        builder: (BuildContext context) => Column(
          children: [
            Container(
              height: 170.0,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    child: Image(
                      image: widget.item['hasimages'] == 'no'
                          ? AssetImage("assets/images/workspace.png")
                          : NetworkImage(widget.item['imageurl']),
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
                                  widget.item['name'],
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
                                  widget.item['area'],
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
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.item['cost'] + ' EGP',
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
                                  '(${widget.item['roomsnumber']}) Rooms',
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
                                  widget.item['phone'],
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
                      ))
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 250.0,
              child: WeekdaySelector(
                firstDayOfWeek: getDate(),
                onChanged: (int day) {
                  print(day);
                  switch (day) {
                    case 1:
                      {
                        setState(() {
                          selectedDayy = 'monday';
                          selectedDay = 2;
                        });
                      }
                      break;

                    case 2:
                      {
                        setState(() {
                          selectedDayy = 'tuesday';
                          selectedDay = 3;
                        });
                      }
                      break;

                    case 3:
                      {
                        setState(() {
                          selectedDayy = 'wednesday';

                          selectedDay = 4;
                        });
                      }
                      break;
                    case 4:
                      {
                        setState(() {
                          selectedDayy = 'thrusday';
                          selectedDay = 5;
                        });
                      }
                      break;
                    case 5:
                      {
                        setState(() {
                          selectedDayy = 'friday';

                          selectedDay = 6;
                        });
                      }
                      break;

                    case 6:
                      {
                        setState(() {
                          selectedDayy = 'saturday';

                          selectedDay = 0;
                        });
                      }
                      break;
                    case 7:
                      {
                        setState(() {
                          selectedDayy = 'sunday';
                          selectedDay = 1;
                        });
                      }
                      break;
                    default:
                      {}
                      break;
                  }

                  for (int i = 0; i < values.length; i++) {
                    if (values[i] == false) values[i] = !values[i];
                  }
                  setState(() {
                    final index = day % 7;
                    values[index] = !values[index];
                  });
                },
                values: values,
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              height: 80.0,
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(widget.slots, index, context);
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 12.0,
                ),
                itemCount: widget.slots[selectedDay].length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 1.0,
              color: Colors.grey[400],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 20.0,
                start: 8.0,
                end: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/wifi.png',
                        height: 40.0,
                        width: 40.0,
                      ),
                      Text('Wi-Fi'),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/toilet.png',
                        height: 40.0,
                        width: 40.0,
                      ),
                      Text('Toilet'),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/key.png',
                        height: 40.0,
                        width: 40.0,
                      ),
                      Text('Lockers'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: FlatButton(
                  onPressed: () async {
                    if (selectedSlot == 99) {
                      _showToast(context, 'You Have To Choose A Slot ! ');
                    } else {
                      int modifiedSLotNumber = 0;
                      await reserve(
                          widget.item['name'].toLowerCase() + selectedDayy,
                          selectedSlot.toString(),
                          modifiedSLotNumber);
                      await reserveTimeStamp(
                          widget.item['name'].toLowerCase() + selectedDayy,
                          modifiedSLotNumber);
                      Navigator.pop(context);
                    }
                    _showToast2(
                        context,
                        "You have Received Slot From " +
                            (widget.slots[selectedDay][selectedSlot]['end'])
                                .toString() +
                            " to : " +
                            (widget.slots[selectedDay][selectedSlot]['end'] + 1)
                                .toString() +
                            " in " +
                            widget.item['name']);
                  },
                  child: Text(
                    'Reserve',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // el slots hena
  Widget buildItem(
          List<List<Map<String, int>>> slots, int index, BuildContext ctx) =>
      InkWell(
        onTap: () {
          setState(() {
            if (slots[selectedDay][index]['reserved'] == 1) {
              selectedSlot = selectedSlot;
              _showToast(ctx, 'Cant Reserve an Allready Reserved Slot !');
            } else
              selectedSlot = index;
          });
        },
        child: slots[selectedDay][index]['reserved'] == 1
            ? Stack(
                children: <Widget>[
                  Card(
                    elevation: selectedSlot == index ? 13 : 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text((slots[selectedDay][index]['end']).toString() +
                              '-' +
                              (slots[selectedDay][index]['end'] + 1)
                                  .toString()),
                          SizedBox(
                            height: 4.0,
                          ),
                          Image.asset(
                            'assets/images/workspace2.jpg',
                            height: 50.0,
                            width: 50.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 55.0,
                    left: .0,
                    right: .0,
                    child: Center(
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Reserved!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Card(
                elevation: selectedSlot == index ? 13 : 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Theme.of(context).primaryColor, width: 0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text((slots[selectedDay][index]['end']).toString() +
                          '-' +
                          (slots[selectedDay][index]['end'] + 1).toString()),
                      SizedBox(
                        height: 4.0,
                      ),
                      Image.asset(
                        'assets/images/workspace2.jpg',
                        height: 50.0,
                        width: 55.0,
                      )
                    ],
                  ),
                ),
              ),
      );
}
