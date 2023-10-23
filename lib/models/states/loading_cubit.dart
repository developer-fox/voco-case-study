

import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingCubit extends Cubit<bool>{
  LoadingCubit(super.initialState);

  void changeLoadingStatus(bool newValue){
    return emit(newValue);
  }

}
