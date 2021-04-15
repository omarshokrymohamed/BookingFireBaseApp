
import 'package:booking_app/modules/splash/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenCubit extends Cubit<SplashScreenStates>
{
  SplashScreenCubit() : super(SplashScreenInitialState());

  static SplashScreenCubit get (context) => BlocProvider.of(context);
  int currentPage = 0 ;
  void changePage(value)
  {
    currentPage = value ;
    emit(SplashScreenChangePageState());
  }

}