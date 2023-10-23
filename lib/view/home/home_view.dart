

import 'package:flutter/material.dart';
import 'package:voco_case_study/components/components.dart';
import 'package:voco_case_study/core/base/view/base_view.dart';
import 'package:voco_case_study/core/extension/context_extension.dart';
import 'package:voco_case_study/core/extension/string_extension.dart';
import 'package:voco_case_study/core/init/language/locale_keys.g.dart';
import 'package:voco_case_study/core/init/network/models/network_bloc_builder.dart';
import 'package:voco_case_study/core/init/theme/app_fonts.dart';
import 'package:voco_case_study/models/endpoints/responses/users.dart';
import 'package:voco_case_study/view/home/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeController{
  @override
  Widget build(BuildContext context) {
    return  BaseView(
      onModelReady: onInitState,
      onConnectionEnabledBuilder:(context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.home_view_appbarTitle.locale),
            actions: [
              IconButton(
                icon: Icon(Icons.exit_to_app_rounded, size: 28,),
                onPressed: onLogout, 
              ),
            ],
          ),
          body: NetworkBlocBuilder<UsersResponseModel>(
            onLoading: (context) => const Center(child: CircularProgressIndicator(),),
            onSuccess:(context, successObject) {
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder:(context, index) {
                  return const Divider(thickness: 1, height: 1,);
                }, 
                itemBuilder:(context, index) {
                  var currentItem = successObject.data.users[index];
                  return Padding(
                    padding: context.paddingNormal,
                    child: UserTile(model: currentItem),
                  );
                }, 
                itemCount: successObject.data.users.length,
              );
            },
          ),
        );
      },
    );
  }
}