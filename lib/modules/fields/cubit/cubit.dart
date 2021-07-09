import 'dart:io';

import 'package:booking_app/modules/fields/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class FieldsCubit extends Cubit<FieldsStates> {
  FieldsCubit() : super(FieldsInitialState());
  static FieldsCubit get(context) => BlocProvider.of(context);
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
  }) async {}
}
