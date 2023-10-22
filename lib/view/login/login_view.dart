


import 'package:flutter/material.dart';
import 'package:voco_case_study/components/components.dart';
import 'package:voco_case_study/core/base/view/base_view.dart';
import 'package:voco_case_study/core/extension/context_extension.dart';
import 'package:voco_case_study/core/extension/string_extension.dart';
import 'package:voco_case_study/core/init/language/locale_keys.g.dart';
import 'package:voco_case_study/core/init/theme/app_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      onConnectionEnabledBuilder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.login_view_login.locale),),
          body: SingleChildScrollView(
            child: Padding(
              padding: context.paddingNormal,
              child: Column(
                children: [
                  // username
                  DefaultTextField(labelText: LocaleKeys.login_view_username.locale, inputHeight: context.getDynamicHeight(6),),
                  // email
                  Padding(
                    padding: context.paddingNormalVertical,
                    child: DefaultTextField(labelText: LocaleKeys.login_view_email.locale, inputHeight: context.getDynamicHeight(6),),
                  ),
                  // password
                  DefaultTextField(labelText: LocaleKeys.login_view_password.locale, inputHeight: context.getDynamicHeight(6),),
                  // submit button
                  Padding(
                    padding: EdgeInsets.only(top: context.normalValue),
                    child: AuthenticationButton(title: LocaleKeys.login_view_login.locale),
                  ),
                  // have'nt account
                  Padding(
                    padding: EdgeInsets.only(top: context.getDynamicHeight(24), bottom: context.normalValue),
                    child: Text(LocaleKeys.login_view_haventAccount.locale, style: AppFonts.pageDescriptionStyle,),
                  ),
                  AuthenticationButton(title: LocaleKeys.login_view_register.locale, onPressed: (){},),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}