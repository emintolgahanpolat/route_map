// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteMapConfigGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';
import 'package:example/home.dart';
import 'package:example/profile.dart';
import 'package:example/root.dart';
import 'package:example/detail2.dart';
import 'package:example/test_screen.dart';
import 'package:example/detail.dart';
import 'package:example/search.dart';
import 'package:example/deneme_ekran.dart';
import 'package:example/settings.dart';
import 'package:example/custom_model.dart';
import 'package:example/custom_model2.dart';

/// URL tabanlı sayfa yönlendirmesi hala deneyseldir. Tür dönüştürmeleriyle ilgili sorunlar var ve henüz kapsamlı bir şekilde test edilmedi.
/// Yardıma ihtiyacım var.
/// URL tabanlı sayfa yönlendirmede tür dönüştürme konusunda yardıma ihtiyacım var. int, double, string ve bool'u destekler.

Map<String, String> get pathRoutes => _pathRoutes;
final Map<String, String> _pathRoutes = {
  "/detail/:id/:name": DetailRoute.name,
  "/settings/:name": SettingsRoute.name,
};
Map<String, RouteModel> get routes => _routes;
final Map<String, RouteModel> _routes = {
  HomeRoute.name: RouteModel(
    HomeRoute.builder,
    fullscreenDialog: HomeRoute.fullScreenDialog,
  ),
  ProfilRoute.name: RouteModel(
    ProfilRoute.builder,
    fullscreenDialog: ProfilRoute.fullScreenDialog,
  ),
  RootRoute.name: RouteModel(
    RootRoute.builder,
    fullscreenDialog: RootRoute.fullScreenDialog,
  ),
  Detail2Route.name: RouteModel(
    Detail2Route.builder,
    fullscreenDialog: Detail2Route.fullScreenDialog,
  ),
  TestRoute.name: RouteModel(
    TestRoute.builder,
    fullscreenDialog: TestRoute.fullScreenDialog,
  ),
  DetailRoute.name: RouteModel(
    DetailRoute.builder,
    fullscreenDialog: DetailRoute.fullScreenDialog,
  ),
  SearchRoute.name: RouteModel(
    SearchRoute.builder,
    fullscreenDialog: SearchRoute.fullScreenDialog,
  ),
  DenemeRoute.name: RouteModel(
    DenemeRoute.builder,
    fullscreenDialog: DenemeRoute.fullScreenDialog,
  ),
  SettingsRoute.name: RouteModel(
    SettingsRoute.builder,
    fullscreenDialog: SettingsRoute.fullScreenDialog,
  ),
};
Route? $onGenerateRoute(RouteSettings routeSettings,
        {String? Function(String routeName)? redirect}) =>
    onGenerateRouteWithRoutesSettings(
      routeSettings,
      routes,
      pathRoutes: pathRoutes,
      redirect: redirect,
    );

class HomeRoute extends BaseRoute {
  HomeRoute() : super(name);
  static const String name = "home";
  static WidgetBuilder builder = (_) => homeBuilder(const HomePage());
  static const bool fullScreenDialog = false;
}

class ProfilRoute extends BaseRoute {
  ProfilRoute() : super(name);
  static const String name = "/profil";
  static WidgetBuilder builder = (_) => const Profil();
  static const bool fullScreenDialog = false;
}

class RootRoute extends BaseRoute {
  RootRoute() : super(name);
  static const String name = "/";
  static WidgetBuilder builder = (_) => const RootPage();
  static const bool fullScreenDialog = false;
}

class Detail2Route extends BaseRoute {
  Detail2Route({
    required CustomModel customModel,
    required List<CustomModel2> items,
  }) : super(Detail2Route.name,
            args: Detail2RouteArgs(
              customModel: customModel,
              items: items,
            ).map);
  static const String name = "/detail2_page";
  static WidgetBuilder builder = (c) {
    Detail2RouteArgs args = Detail2RouteArgs.getArgs(c);
    return Detail2Page(
      customModel: args.customModel,
      items: args.items,
    );
  };
  static const bool fullScreenDialog = false;
}

class Detail2RouteArgs {
  final CustomModel customModel;
  final List<CustomModel2> items;
  Detail2RouteArgs({
    required this.customModel,
    required this.items,
  });
  Map<String, dynamic>? get map => {
        "customModel": customModel,
        "items": items,
      };
  static Detail2RouteArgs getArgs(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    return Detail2RouteArgs(
      customModel: args["customModel"] as CustomModel,
      items: args["items"] as List<CustomModel2>,
    );
  }
}

class TestRoute extends BaseRoute {
  TestRoute() : super(name);
  static const String name = "/test_screen";
  static WidgetBuilder builder = (_) => const TestScreen();
  static const bool fullScreenDialog = false;
}

class DetailRoute extends BaseRoute {
  DetailRoute({
    required int id,
    CustomModel? customModel,
    CustomModel2? customModel2,
    bool? isShow,
    List<CustomModel2>? items,
    required String name,
    int? testDefaultIntValue,
    String? testDefaultValue,
  }) : super(DetailRoute.name,
            args: DetailRouteArgs(
              id: id,
              customModel: customModel,
              customModel2: customModel2,
              isShow: isShow,
              items: items,
              name: name,
              testDefaultIntValue: testDefaultIntValue ?? 9999,
              testDefaultValue: testDefaultValue ?? "testDefaultValue",
            ).map);
  static const String name = "/detail_page";
  static WidgetBuilder builder = (c) {
    DetailRouteArgs args = DetailRouteArgs.getArgs(c);
    return DetailPage(
      args.id,
      customModel: args.customModel,
      customModel2: args.customModel2,
      isShow: args.isShow,
      items: args.items,
      name: args.name,
      testDefaultIntValue: args.testDefaultIntValue ?? 9999,
      testDefaultValue: args.testDefaultValue ?? "testDefaultValue",
    );
  };
  static const bool fullScreenDialog = false;
}

class DetailRouteArgs {
  final int id;
  final CustomModel? customModel;
  final CustomModel2? customModel2;
  final bool? isShow;
  final List<CustomModel2>? items;
  final String name;
  final int? testDefaultIntValue;
  final String? testDefaultValue;
  DetailRouteArgs({
    required this.id,
    this.customModel,
    this.customModel2,
    this.isShow,
    this.items,
    required this.name,
    this.testDefaultIntValue,
    this.testDefaultValue,
  });
  Map<String, dynamic>? get map => {
        "id": id,
        "customModel": customModel,
        "customModel2": customModel2,
        "isShow": isShow,
        "items": items,
        "name": name,
        "testDefaultIntValue": testDefaultIntValue,
        "testDefaultValue": testDefaultValue,
      };
  static DetailRouteArgs getArgs(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    return DetailRouteArgs(
      id: args["id"] as int,
      customModel: args["customModel"] as CustomModel?,
      customModel2: args["customModel2"] as CustomModel2?,
      isShow: args["isShow"] as bool?,
      items: args["items"] as List<CustomModel2>?,
      name: args["name"] as String,
      testDefaultIntValue: args["testDefaultIntValue"] as int?,
      testDefaultValue: args["testDefaultValue"] as String?,
    );
  }
}

class SearchRoute extends BaseRoute {
  SearchRoute() : super(name);
  static const String name = "/ara";
  static WidgetBuilder builder = (_) => const SearchPage();
  static const bool fullScreenDialog = true;
}

class DenemeRoute extends BaseRoute {
  DenemeRoute() : super(name);
  static const String name = "/deneme_ekran";
  static WidgetBuilder builder = (_) => const DenemeEkran();
  static const bool fullScreenDialog = false;
}

class SettingsRoute extends BaseRoute {
  SettingsRoute({
    String? name,
  }) : super(SettingsRoute.name,
            args: SettingsRouteArgs(
              name: name,
            ).map);
  static const String name = "settings";
  static WidgetBuilder builder = (c) {
    SettingsRouteArgs args = SettingsRouteArgs.getArgs(c);
    return SettingsPage(
      name: args.name,
    );
  };
  static const bool fullScreenDialog = true;
}

class SettingsRouteArgs {
  final String? name;
  SettingsRouteArgs({
    this.name,
  });
  Map<String, dynamic>? get map => {
        "name": name,
      };
  static SettingsRouteArgs getArgs(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    return SettingsRouteArgs(
      name: args["name"] as String?,
    );
  }
}
