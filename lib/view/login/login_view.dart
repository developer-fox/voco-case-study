


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_case_study/components/components.dart';
import 'package:voco_case_study/core/base/view/base_view.dart';
import 'package:voco_case_study/core/extension/context_extension.dart';
import 'package:voco_case_study/core/extension/string_extension.dart';
import 'package:voco_case_study/core/init/language/locale_keys.g.dart';
import 'package:voco_case_study/core/init/network/models/network_bloc_listener.dart';
import 'package:voco_case_study/core/init/network/models/unmodified_response_model.dart';
import 'package:voco_case_study/core/init/theme/app_fonts.dart';
import 'package:voco_case_study/models/states/loading_cubit.dart';
import 'package:voco_case_study/view/login/login_controller.dart';


class LoginView extends ConsumerWidget with LoginController{
  LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NetworkBlocListener<UnmodifiedResponseDataModel>(
      onLoading: (context) => context.read<LoadingCubit>().changeLoadingStatus(true),
      onInvalidValueError: onLoginError,
      onSuccess: onLoginSuccess,
      child: BaseView(
        onModelDispose: onDispose,
        onModelReady: ()=> onInitState(ref),
        onConnectionEnabledBuilder: (context) {
          final currentState = ref.watch(authProvider);
          return Scaffold(
            appBar: AppBar(title: Text(LocaleKeys.login_view_login.locale),),
            body: LoadingArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: context.paddingNormal,
                  child: Column(
                    children: [
                      // username
                      DefaultTextField(
                        labelText: LocaleKeys.login_view_username.locale, 
                        inputHeight: context.getDynamicHeight(6),
                        controller: usernameController,
                      ),
                      // email
                      Padding(
                        padding: context.paddingNormalVertical,
                        child: DefaultTextField(
                          labelText: LocaleKeys.login_view_email.locale, 
                          inputHeight: context.getDynamicHeight(6),
                          controller: emailController,
                        ),
                      ),
                      // password
                      DefaultTextField(
                        labelText: LocaleKeys.login_view_password.locale, 
                        inputHeight: context.getDynamicHeight(6),
                        controller: passwordController,
                      ),
                      // submit button
                      Padding(
                        padding: EdgeInsets.only(top: context.normalValue),
                        child: AuthenticationButton(
                          title: LocaleKeys.login_view_login.locale,
                          onPressed: !currentState.isButtonEnabled ? null : ()=> onLoginButton(context),
                        ),
                      ),
                      // have'nt account
                      Padding(
                        padding: EdgeInsets.only(top: context.getDynamicHeight(24), bottom: context.normalValue),
                        child: Text(LocaleKeys.login_view_haventAccount.locale, style: AppFonts.pageDescriptionStyle,),
                      ),
                      // navigate to register
                      AuthenticationButton(title: LocaleKeys.login_view_register.locale, onPressed: onRegisterButton,),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}