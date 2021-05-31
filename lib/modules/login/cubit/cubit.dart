import 'dart:convert';


import 'package:booking_app/modules/login/cubit/states.dart';
import 'package:booking_app/shared/commponents/commponents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenCubit extends Cubit<LoginScreenStates>
{


  LoginScreenCubit() : super(LoginScreenInitialState());
  static LoginScreenCubit get (context) => BlocProvider.of(context);
  List errors = [];
  bool remember = false ;
  BuildContext context ;
  void login({String email , String password})async
  {
    emit(LoginScreenLoadingState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      emit(LoginScreenSuccessState());
    }).catchError((error){
      emit(LoginScreenErrorState());
    });
  }
  void addEmailNullError()
  {
    errors.add(kEmailNullError);
    emit(LoginScreenAddEmailErrorState());
  }
  void addPassWordNullError()
  {
    errors.add(kPassNullError);
    emit(LoginScreenAddPasswordErrorState());
  }
  void addEmailNotValidError()
  {
    errors.add(kInvalidEmailError);
    emit(LoginScreenAddEmailErrorState());
  }
  void addPasswordShortError()
  {
    errors.add(kShortPassError);
    emit(LoginScreenAddPasswordErrorState());
  }
  void removeEmailNullError()
  {
    errors.remove(kEmailNullError);
    emit(LoginScreenAddEmailErrorState());
  }
  void removePassWordNullError()
  {
    errors.remove(kPassNullError);
    emit(LoginScreenAddPasswordErrorState());
  }
  void removeEmailNotValidError()
  {
    errors.remove(kInvalidEmailError);
    emit(LoginScreenAddEmailErrorState());
  }
  void removePasswordShortError()
  {
    errors.remove(kShortPassError);
    emit(LoginScreenAddPasswordErrorState());
  }
  void changeCheck(value)
  {
    remember = value ;
    emit(LoginScreenRememberState());
  }


}