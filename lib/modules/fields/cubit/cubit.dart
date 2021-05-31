
import 'dart:io';

import 'package:booking_app/modules/fields/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class FieldsCubit extends Cubit<FieldsStates>{
  FieldsCubit() : super(FieldsInitialState());
  static FieldsCubit get(context)=> BlocProvider.of(context);
  File image;
  String imageUrl;

  Future<void> pickImage() async {
    await ImagePicker().getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image = File(value.path);
        emit(FieldsSetImageState());

        print(value.path);
      }
    });
  }
  uploadData({
    area,
    cost,
    fieldsNumber,
    name,
  }) async {
    emit(FieldsLoadingState());
    FirebaseFirestore.instance
        .collection('fields')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      'area': area,
      'cost': cost,
      'fields_number': fieldsNumber,
      'id': FirebaseAuth.instance.currentUser.uid,
      'image' : '' ,
      'name' : name,
    }).then((value) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('fields/${Uri.file(image.path).pathSegments.last}')
          .putFile(image)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          imageUrl = value.toString();
          FirebaseFirestore.instance
              .collection('fields')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .update({
            'image': imageUrl,
          }).then((value) {
            // navigateAndFinish(context: context , route: LoginScreen());
            emit(FieldsSuccessState());
          }).catchError((error) {
            print(error.toString());
            emit(FieldsErrorState(error: error));
          });
        });
        print('success');
        emit(FieldsUploadImageState());
      }).catchError((error) {
        print(error.toString());
        emit(FieldsErrorState(error: error));
      });
    });
  }

}