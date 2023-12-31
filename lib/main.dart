import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_case_study/core/constants/app/app_constants.dart';
import 'package:voco_case_study/core/constants/enums/locale_keys_enum.dart';
import 'package:voco_case_study/core/init/language/language_manager.dart';
import 'package:voco_case_study/core/init/network/bloc/network_bloc.dart';
import 'package:voco_case_study/core/init/network/connectivity/connectivity_bloc.dart';
import 'package:voco_case_study/core/init/network/models/unmodified_response_model.dart';
import 'package:voco_case_study/core/init/theme/app_theme_light.dart';
import 'package:voco_case_study/models/endpoints/responses/users.dart';
import 'package:voco_case_study/models/states/loading_cubit.dart';
import 'package:voco_case_study/view/home/home_view.dart';
import 'package:voco_case_study/view/login/login_view.dart';

import 'core/init/cache/locale_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  LocaleManager.preferencesInit();
  runApp(
    ProviderScope(
      child: EasyLocalization(
       supportedLocales: LanguageManager.instance.supportedLocales,
       startLocale: LanguageManager.instance.trLocale, 
       fallbackLocale: LanguageManager.instance.trLocale,
       path: ApplicationConstants.LANG_ASSET_PATH,
        child: MyApp(),
      ),
    )
  );
}
class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool get isLogined {
    var value = LocaleManager.instance.getBoolValue(PreferencesKeys.is_logined);
    return value == true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> ConnectivityBloc()),
        BlocProvider(create: (_)=> LoadingCubit(false)),
        BlocProvider(create: (_)=> NetworkBloc<UnmodifiedResponseDataModel>()),
        BlocProvider(create: (_)=> NetworkBloc<UsersResponseModel>()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            theme: AppThemeLight.instance.theme,
            locale: context.locale,
            onGenerateRoute: NavigationRoute.instance.generateRoute,
            navigatorKey: NavigationService.instance.navigatorKey,
            home: isLogined ? const HomeView() : LoginView(),
          );
        }
      ),
    );
  }
}