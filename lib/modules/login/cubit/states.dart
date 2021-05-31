
abstract class LoginScreenStates {}
class LoginScreenInitialState extends LoginScreenStates{}
class LoginScreenLoadingState extends LoginScreenStates{}
class LoginScreenSuccessState extends LoginScreenStates{
}
class LoginScreenErrorState extends LoginScreenStates{
  String error ;

  LoginScreenErrorState({this.error});
}
class LoginScreenAddEmailErrorState extends LoginScreenStates{}
class LoginScreenAddPasswordErrorState extends LoginScreenStates{}
class LoginScreenRemoveEmailErrorState extends LoginScreenStates{}
class LoginScreenRemovePasswordErrorState extends LoginScreenStates{}
class LoginScreenRememberState extends LoginScreenStates{}