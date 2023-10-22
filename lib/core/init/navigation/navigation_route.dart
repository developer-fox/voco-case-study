
import 'package:flutter/material.dart';
import "../../constants/navigation/navigation_constants.dart";

/// The [NavigationRoute] class makes navigation operations more efficient and manageable over a single instance.
class NavigationRoute {
  static NavigationRoute? _instance = NavigationRoute._init();
  static NavigationRoute get instance {
    _instance ??= NavigationRoute._init();
    return _instance!;
  }

  NavigationRoute._init();
  //
  /// This is how routes to be followed according to the route statics in [NavigationConstants] are defined in [generateRoute].
  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      default:
        return normalNavigate(emptyScaffold);
    }
  }
}

Scaffold get emptyScaffold {
  return const Scaffold(
    body: Center(
      child: Text("core: navigation route default case"),
    ),
  );
}

MaterialPageRoute normalNavigate(Widget widget) {
  return MaterialPageRoute(builder: ((context) => widget));
}