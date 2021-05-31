import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FieldDetails extends StatelessWidget {
  final Map<String, String> item;

  FieldDetails({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date And Time'),
      ),
      body: Column(
        children: [
          Container(
            height: 170.0,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  child: Image(
                    image: AssetImage(item['image']),
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
                                  color: Colors.green,
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
                        ],
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
              height: 250.0,
              child: SfDateRangePicker(
                view: DateRangePickerView.month,
                monthViewSettings:
                    DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              )),
          SizedBox(height: 15.0),
          Container(
            height: 80.0,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return buildItem(index);
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: 12.0,
              ),
              itemCount: 10,
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
            padding: const EdgeInsetsDirectional.only(top: 20.0 ,  start: 8.0 ,end: 8.0, ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/ball.png',
                      height: 40.0,
                      width: 40.0,
                    ),
                    Text('Ball Rent'),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/drop.png',
                      height: 40.0,
                      width: 40.0,
                    ),
                    Text('Water'),
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
                      'assets/images/shower.png',
                      height: 40.0,
                      width: 40.0,
                    ),
                    Text('Shower'),
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
              child: FlatButton(onPressed: () {  },
              child: Text('Reserve' , style: TextStyle(
                color: Colors.white,
              ),),),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(index) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0,),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${index+1}-${index+2} PM'),
            SizedBox(
              height: 4.0,
            ),
            Image.asset(
              'assets/images/ball.png',
              height: 50.0,
              width: 50.0,
            )
          ],
        ),
  );
}
