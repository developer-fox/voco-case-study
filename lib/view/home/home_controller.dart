
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voco_case_study/core/constants/enums/locale_keys_enum.dart';
import 'package:voco_case_study/core/constants/navigation/navigation_constants.dart';
import 'package:voco_case_study/core/init/cache/locale_manager.dart';
import 'package:voco_case_study/core/init/navigation/navigation_service.dart';
import 'package:voco_case_study/core/init/network/bloc/network_bloc.dart';
import 'package:voco_case_study/core/init/network/network_manager.dart';
import 'package:voco_case_study/models/endpoints/responses/users.dart';

mixin HomeController<T extends StatefulWidget> on State<T>{

  void onInitState(){
    getUsersListRequest();
  }

  void getUsersListRequest(){
    var requestMethod = NetworkManagement.instance.getDio("/users", responseModel: UsersResponseModel.blank());
    context.read<NetworkBloc<UsersResponseModel>>().add(HttpRequestEvent(requestMethod: requestMethod));
  }

  void onLogout(){
    LocaleManager.instance.setBoolValue(PreferencesKeys.is_logined, false);
    NavigationService.instance.navigateToPageClear(path: NavigationConstants.login_view);
  }


}

