import 'package:booking_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreenCubit extends Cubit<LayoutScreenStates>
{
  LayoutScreenCubit() : super(LayoutScreenInitialState());
  static LayoutScreenCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex (int index)
  {
    currentIndex = index ;
    emit(LayoutScreenChangeIndexState());
  }

}