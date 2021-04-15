import 'package:booking_app/layout/home.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:booking_app/shared/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    List<Map<String, String>> splashContent = [
      {
        "text": "Welcome to Booking App, Let’s start!",
        "image": "assets/images/splash_2.png"
      },
      {
        "text": "Welcome to Booking App, Let’s start \n",
        "image": "assets/images/splash_1.png"
      },
      {
        "text": "Welcome to Booking App, \nJust stay at home with us",
        "image": "assets/images/splash_3.png"
      }
    ];
    return BlocProvider(
      create: (BuildContext context) => SplashScreenCubit(),
      child: BlocConsumer<SplashScreenCubit, SplashScreenStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15.0),
              ),
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          SplashScreenCubit.get(context).changePage(value);
                        },
                        itemCount: splashContent.length,
                        itemBuilder: (BuildContext context, int index) =>
                            splashContentItem(
                          flex: 2,
                          textContent: splashContent[index]['text'],
                          image: splashContent[index]['image'],
                        ),
                      )),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Row(
                          children: List.generate(
                            splashContent.length,
                            (index) => buildDot(
                                index: index,
                                currentPage:
                                    SplashScreenCubit.get(context).currentPage),
                          ),
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        Spacer(),
                        if (SplashScreenCubit.get(context).currentPage != 3)
                          FlatButton(
                            onPressed: () {
                              navigateAndFinish(
                                context: context,
                                route: HomeScreen(),
                              );
                            },
                            child: Text(
                              (SplashScreenCubit.get(context).currentPage == 2)
                                  ? 'Finish'
                                  : 'Skip',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, state) {},
      ),
    );
  }
}
