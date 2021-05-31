import 'package:booking_app/modules/fieldDetails/field_details.dart';
import 'package:booking_app/modules/fields/cubit/cubit.dart';
import 'package:booking_app/modules/fields/cubit/states.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:booking_app/shared/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Map<String, String>> fields = [
      {
        "name": "Gardenia",
        "area": "Nasr City",
        "fields_number": "5",
        "image": "assets/images/field1.jpg",
        "cost": "225"
      },
      {
        "name": "Al-Madf3ya",
        "area": "Heliopolis",
        "fields_number": "3",
        "image": "assets/images/field2.jpg",
        "cost": "180"
      },
      {
        "name": "Dar Alwaqud",
        "area": "Nasr City",
        "fields_number": "4",
        "image": "assets/images/field3.webp",
        "cost": "240"
      },
      {
        "name": "Cic",
        "area": "Tagmo3 El-Awel",
        "fields_number": "2",
        "image": "assets/images/field4.jpg",
        "cost": "250"
      },
      {
        "name": "Dar Bank Masr",
        "area": "Tagmo3 El-5ames",
        "fields_number": "5",
        "image": "assets/images/field5.jpg",
        "cost": "250"
      },
    ];
    final nameController = TextEditingController();
    final areaController = TextEditingController();
    final costController = TextEditingController();
    final fieldsNumberController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => FieldsCubit(),
      child: BlocConsumer<FieldsCubit, FieldsStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: Color(0xFFF8F8FF),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                'Fields',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (b) => AlertDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 0.5),
                          content: SingleChildScrollView(
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
                                    InkWell(
                                      onTap: () {
                                        FieldsCubit.get(context).pickImage();
                                      },
                                      child: Stack(
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
                                              backgroundImage: (FieldsCubit.get(
                                                              context)
                                                          .image !=
                                                      null)
                                                  ? FileImage(
                                                      FieldsCubit.get(context)
                                                          .image)
                                                  : AssetImage(
                                                      'assets/images/field1.jpg',
                                                    ),
                                            ),
                                          ),
                                          Container(
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 14.0,
                                            ),
                                            height: 30.0,
                                            width: 30.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    TextFormField(
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
                                    defaultButton(
                                        text: 'Join',
                                        padding: 0.0,
                                        function: () {
                                          if (formKey.currentState.validate()) {
                                            formKey.currentState.save();
                                            print('validate');
                                            FieldsCubit.get(context).uploadData(
                                              name: nameController.text,
                                              area: areaController.text,
                                              cost: costController.text,
                                              fieldsNumber:
                                                  fieldsNumberController.text,
                                            );
                                          }
                                        },
                                        radius: 24.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.green,
            ),
            body: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return buildItem(fields[index] , context , (){
                  navigateTo(
                    context: context,
                    route: FieldDetails(item: fields[index]),
                  );
                });
              },
              itemCount: 5,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 10.0,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildItem(Map item , context , function) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
        ),
      );
}
