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

class RouteMaps {
  static const String homeRoute = "home";
  static const String profilRoute = "/profil";
  static const String root = "/";
  static const String detail2Route = "/detail2_page";
  static const String testRoute = "/test_screen";
  static const String detailRoute = "/detail_page";
  static const String searchRoute = "/ara";
  static const String denemeRoute = "/deneme_ekran";
  static const String settingsRoute = "settings";
}

/// URL tabanlı sayfa yönlendirmesi hala deneyseldir. Tür dönüştürmeleriyle ilgili sorunlar var ve henüz kapsamlı bir şekilde test edilmedi.
/// Yardıma ihtiyacım var.
/// URL tabanlı sayfa yönlendirmede tür dönüştürme konusunda yardıma ihtiyacım var. int, double, string ve bool'u destekler.

Map<String, RouteMapModel> get pathRoutes => _pathRoutes;
final Map<String, RouteMapModel> _pathRoutes = {
  HomeRoute.name: RouteMapModel(
    (_, arguments) => homeBuilder(const HomePage()),
    name: "home",
  ),
  ProfilRoute.name: RouteMapModel(
    (_, arguments) => const Profil(),
    name: "/profil",
  ),
  RootRoute.name: RouteMapModel(
    (_, arguments) => const RootPage(),
    name: "/",
  ),
  Detail2Route.name: RouteMapModel(
    (context, arguments) {
      return Detail2Page(
        customModel: arguments["customModel"]!,
        items: arguments["items"]!,
      );
    },
    name: "/detail2_page",
  ),
  TestRoute.name: RouteMapModel(
    (_, arguments) => const TestScreen(),
    name: "/test_screen",
  ),
  "/detail/:id/:name": RouteMapModel(
    (context, arguments) {
      var route = ModalRoute.of(context)!;
      Map<String, dynamic> pathArgs =
          getPathArgs(route.settings.name!, "/detail/:id/:name");
      Map<String, dynamic> pathArgs2 = {};
      pathArgs2.addAll(arguments);
      pathArgs2["id"] = int.parse(pathArgs["id"]);
      pathArgs2["name"] = pathArgs["name"];
      return _pathRoutes["/detail_page"]!.builder(context, pathArgs2);
    },
    name: "/detail_page",
  ),
  DetailRoute.name: RouteMapModel(
    (context, arguments) {
      return DetailPage(
        arguments["id"]!,
        customModel: arguments["customModel"],
        customModel2: arguments["customModel2"],
        isShow: arguments["isShow"],
        items: arguments["items"],
        name: arguments["name"]!,
        testDefaultIntValue: arguments["testDefaultIntValue"] ?? 0,
        testDefaultValue: arguments["testDefaultValue"] ?? "deneme",
      );
    },
    name: "/detail_page",
  ),
  SearchRoute.name: RouteMapModel(
    (_, arguments) => const SearchPage(),
    name: "/ara",
    fullScreenDialog: true,
  ),
  DenemeRoute.name: RouteMapModel(
    (_, arguments) => const DenemeEkran(),
    name: "/deneme_ekran",
  ),
  "/settings/:name": RouteMapModel(
    (context, arguments) {
      var route = ModalRoute.of(context)!;
      Map<String, dynamic> pathArgs =
          getPathArgs(route.settings.name!, "/settings/:name");
      Map<String, dynamic> pathArgs2 = {};
      pathArgs2.addAll(arguments);
      pathArgs2["name"] = int.parse(pathArgs["name"]);
      return _pathRoutes["settings"]!.builder(context, pathArgs2);
    },
    name: "settings",
    fullScreenDialog: true,
  ),
  SettingsRoute.name: RouteMapModel(
    (context, arguments) {
      return SettingsPage(
        name: arguments["name"],
      );
    },
    name: "settings",
    fullScreenDialog: true,
  ),
};
Route? $onGenerateRoute(RouteSettings routeSettings,
        {String? Function(String routeName)? redirect}) =>
    onGenerateRouteWithRoutesSettings(
      routeSettings,
      pathRoutes,
      redirect: redirect,
    );

class HomeRoute extends BaseRoute {
  HomeRoute() : super(RouteMaps.homeRoute);
  static const String name = "home";
}

class ProfilRoute extends BaseRoute {
  ProfilRoute() : super(RouteMaps.profilRoute);
  static const String name = "/profil";
}

class RootRoute extends BaseRoute {
  RootRoute() : super(RouteMaps.root);
  static const String name = "/";
}

class Detail2Route extends BaseRoute {
  Detail2Route({
    required CustomModel customModel,
    required List<CustomModel2> items,
  }) : super(RouteMaps.detail2Route,
            args: Detail2RouteArgs(
              customModel: customModel,
              items: items,
            ).map);
  static const String name = "/detail2_page";
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
}

class TestRoute extends BaseRoute {
  TestRoute() : super(RouteMaps.testRoute);
  static const String name = "/test_screen";
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
  }) : super(RouteMaps.detailRoute,
            args: DetailRouteArgs(
              id: id,
              customModel: customModel,
              customModel2: customModel2,
              isShow: isShow,
              items: items,
              name: name,
              testDefaultIntValue: testDefaultIntValue ?? 0,
              testDefaultValue: testDefaultValue ?? "deneme",
            ).map);
  static const String name = "/detail_page";
}

class DetailRouteArgs {
  final int id;
  final CustomModel? customModel;
  final CustomModel2? customModel2;
  final bool? isShow;
  final List<CustomModel2>? items;
  final String name;
  final int testDefaultIntValue;
  final String testDefaultValue;
  DetailRouteArgs({
    required this.id,
    this.customModel,
    this.customModel2,
    this.isShow,
    this.items,
    required this.name,
    this.testDefaultIntValue = 0,
    this.testDefaultValue = "deneme",
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
}

class SearchRoute extends BaseRoute {
  SearchRoute() : super(RouteMaps.searchRoute);
  static const String name = "/ara";
}

class DenemeRoute extends BaseRoute {
  DenemeRoute() : super(RouteMaps.denemeRoute);
  static const String name = "/deneme_ekran";
}

class SettingsRoute extends BaseRoute {
  SettingsRoute({
    String? name,
  }) : super(RouteMaps.settingsRoute,
            args: SettingsRouteArgs(
              name: name,
            ).map);
  static const String name = "settings";
}

class SettingsRouteArgs {
  final String? name;
  SettingsRouteArgs({
    this.name,
  });
  Map<String, dynamic>? get map => {
        "name": name,
      };
}
