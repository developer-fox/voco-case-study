
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_case_study/core/constants/enums/locale_keys_enum.dart';
import 'package:voco_case_study/core/constants/navigation/navigation_constants.dart';
import 'package:voco_case_study/core/init/cache/locale_manager.dart';
import 'package:voco_case_study/core/init/navigation/navigation_service.dart';
import 'package:voco_case_study/core/init/network/bloc/network_bloc.dart';
import 'package:voco_case_study/core/init/network/models/unmodified_response_model.dart';
import 'package:voco_case_study/core/init/network/network_manager.dart';
import 'package:voco_case_study/models/endpoints/requests/auth_request.dart';
import 'package:voco_case_study/models/states/loading_cubit.dart';

import '../../models/riverpod_models/auth_model.dart';

mixin LoginController on Widget{

final authProvider = StateProvider<AuthModel>((ref) => AuthModel(isUsernameValid: false, isEmailValid: false, isPasswordValid: false, obscureText: false));

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  void onInitState(WidgetRef ref){
    emailController.addListener(() {
      if(ref.read(authProvider).isEmailValid != emailValidator(emailController.text)){
        ref.read(authProvider.notifier).state = ref.read(authProvider.notifier).state.copyWith(isEmailValid: emailValidator(emailController.text));
      }
    });
    usernameController.addListener(() {
      if(ref.read(authProvider).isUsernameValid != usernameValidator(usernameController.text)){
        ref.read(authProvider.notifier).state = ref.read(authProvider.notifier).state.copyWith(isUsernameValid: usernameValidator(usernameController.text));

      }
    });
    passwordController.addListener(() {
      if(ref.read(authProvider).isPasswordValid != passwordValidator(passwordController.text)){
        ref.read(authProvider.notifier).state = ref.read(authProvider.notifier).state.copyWith(isPasswordValid: passwordValidator(passwordController.text));

      }
    });
  }

  bool emailValidator(String value){
    var regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(value);
  }

  bool passwordValidator(String value){
    return value.length > 3;
  }

  bool usernameValidator(String value){
    return value.isNotEmpty;
  }

  void onDispose(){
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  void onLoginButton(BuildContext context){
    var requestModel = AuthRequest(username: usernameController.text, email: emailController.text, password: passwordController.text);
    var requestMethod = NetworkManagement.instance.postDio("/login", requestModel: requestModel);
    context.read<NetworkBloc<UnmodifiedResponseDataModel>>().add(HttpRequestEvent(requestMethod: requestMethod));
  }

  void onRegisterButton(){
    NavigationService.instance.navigateToPage(path: NavigationConstants.register_view);
  }

  void onLoginSuccess(BuildContext context, NetworkSuccess<UnmodifiedResponseDataModel> success){
    context.read<LoadingCubit>().changeLoadingStatus(false);
    LocaleManager.instance.setBoolValue(PreferencesKeys.is_logined, true);
    NavigationService.instance.navigateToPageClear(path: NavigationConstants.home_view);
  }

  void onLoginError(BuildContext context, NetworkError error){
    context.read<LoadingCubit>().changeLoadingStatus(false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Giriş işlemi başarısız")));
  }

}

