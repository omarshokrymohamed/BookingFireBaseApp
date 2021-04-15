import 'package:booking_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates>
{
  HomeScreenCubit() : super(HomeScreenInitialState());
  static HomeScreenCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex (int index)
  {
    currentIndex = index ;
    emit(HomeScreenChangeIndexState());
  }

}