import 'package:booking_app/modules/fields/fields_screen.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:booking_app/shared/size_config.dart';
import 'package:flutter/material.dart';

class EntertainmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF8F8FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Entertainment',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body:  Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),

            child: InkWell(
              onTap: (){
              navigateTo(
                context: context ,
                route: FieldsScreen(),
              );

              },
              child: Container(
                height: 170.0,
                width: 500.0,

                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),  ),


                child:Stack(
                  children: [
                    Container(



                      child: Image(image: AssetImage("assets/images/field.png"),

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
                              ]

                          )
                      ),

                    ),
                    Container(

                        alignment: Alignment.topCenter,
                        child:Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text("Fields",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4.0),
                              Text("Now you can reserve many football fields",style:
                              TextStyle(color: Colors.white,fontWeight:FontWeight.w400 ),
                              ),
                            ],
                          ),
                        )


                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),

            child: InkWell(
              onTap: (){
                navigateTo(
                    context: context , route: EntertainmentScreen()
                );
              },
              child: Container(
                height: 170.0,
                width: 500.0,

                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),  ),


                child:Stack(
                  children: [
                    Container(



                      child: Image(image: AssetImage("assets/images/cinema.jpg"),

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
                              ]

                          )
                      ),

                    ),
                    Container(

                        alignment: Alignment.topCenter,
                        child:Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text("Cinema",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4.0),
                              Text("Here you can reserve many cinemas ",style:
                              TextStyle(color: Colors.white,fontWeight:FontWeight.w400 ),
                              ),
                              Text("and enjoy watching movies",style:
                              TextStyle(color: Colors.white,fontWeight:FontWeight.w400 ),
                              ),
                            ],
                          ),
                        )


                    )
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
