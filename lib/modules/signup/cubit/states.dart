abstract class SignUpScreenStates {}
class SignUpScreenInitialState extends SignUpScreenStates{}
class SignUpScreenPickImageState extends SignUpScreenStates{}
class SignUpScreenLoadingState extends SignUpScreenStates{}
class SignUpScreenSuccessState extends SignUpScreenStates{}
class SignUpScreenSetImageState extends SignUpScreenStates{}
class SignUpScreenUploadDataState extends SignUpScreenStates{}
class SignUpScreenUploadImageState extends SignUpScreenStates{}
class SignUpScreenErrorState extends SignUpScreenStates{
  String error ;

  SignUpScreenErrorState({this.error});
}
class SignUpScreenAddEmailErrorState extends SignUpScreenStates{}
class SignUpScreenAddFNameErrorState extends SignUpScreenStates{}
class SignUpScreenAddLNameErrorState extends SignUpScreenStates{}
class SignUpScreenAddPasswordErrorState extends SignUpScreenStates{}
class SignUpScreenRemoveEmailErrorState extends SignUpScreenStates{}
class SignUpScreenRemoveFNameErrorState extends SignUpScreenStates{}
class SignUpScreenRemoveLNameErrorState extends SignUpScreenStates{}
class SignUpScreenRemovePasswordErrorState extends SignUpScreenStates{}
