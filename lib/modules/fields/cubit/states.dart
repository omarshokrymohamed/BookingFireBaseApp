abstract class FieldsStates{}
class FieldsInitialState extends FieldsStates{}
class FieldsPickImageState extends FieldsStates{}
class FieldsLoadingState extends FieldsStates{}
class FieldsSuccessState extends FieldsStates{}
class FieldsSetImageState extends FieldsStates{}
class FieldsUploadDataState extends FieldsStates{}
class FieldsUploadImageState extends FieldsStates{}
class FieldsErrorState extends FieldsStates{
  String error ;

  FieldsErrorState({this.error});
}