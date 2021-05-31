import 'package:booking_app/layout/cubit/cubit.dart';
import 'package:booking_app/layout/cubit/states.dart';
import 'package:booking_app/modules/categories/categories_screen.dart';
import 'package:booking_app/modules/favorites/favorites_screen.dart';
import 'package:booking_app/modules/home/home_screen.dart';
import 'package:booking_app/modules/settings/settings_screen.dart';
import 'package:booking_app/shared/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  List screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  List titles = [
    'Booking App',
    'Categories',
    'Favorites',
    'Settings',
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (BuildContext context) => LayoutScreenCubit(),
      child: BlocConsumer<LayoutScreenCubit, LayoutScreenStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          currentIndex = LayoutScreenCubit.get(context).currentIndex;
          return Scaffold(

            backgroundColor: Color(0xFFF8F8FF),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                titles[currentIndex],
                style: TextStyle(
                  color: currentIndex == 0 ? Colors.blue : Colors.black,
                ),
              ),
            ),
            drawer: Drawer(

            ),
            body: screens[currentIndex],
            bottomNavigationBar: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -15),
                    blurRadius: 20,
                    color: Color(0xFFDADADA).withOpacity(0.15),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SafeArea(
                top: false,
                child: BottomNavigationBar(
                  elevation: 0.0,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.category_outlined),
                        label: 'Categories'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_outline), label: 'Favorites'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings'),
                  ],
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  selectedItemColor: Colors.blue,
                  currentIndex: currentIndex,
                  onTap: (value) {
                    LayoutScreenCubit.get(context).changeIndex(value);
                  },
                  backgroundColor: Colors.white,
                  selectedFontSize: getProportionateScreenWidth(8.0),
                  unselectedFontSize: getProportionateScreenWidth(8.0),
                  iconSize: getProportionateScreenWidth(20.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
