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

Map<String, String> get pathRoutes => _pathRoutes;
final Map<String, String> _pathRoutes = {
  "/detail/:id/:name": RouteMaps.detailRoute,
  "/settings/:name": RouteMaps.settingsRoute,
};
Map<String, RouteModel> get routes => _routes;
final Map<String, RouteModel> _routes = {
  RouteMaps.homeRoute: RouteModel((_) => homeBuilder(const HomePage())),
  RouteMaps.profilRoute: RouteModel(
    (_) => const Profil(),
  ),
  RouteMaps.root: RouteModel(
    (_) => const RootPage(),
  ),
  RouteMaps.detail2Route: RouteModel(
    (c) => Detail2Page(
      customModel: c.routeArgsWithKey<CustomModel>("customModel")!,
      items: c.routeArgsWithKey<List<CustomModel2>>("items")!,
    ),
  ),
  RouteMaps.testRoute: RouteModel(
    (_) => const TestScreen(),
  ),
  RouteMaps.detailRoute: RouteModel(
    (c) => DetailPage(
      c.routeArgsWithKeyExperimental<int>("id")!,
      customModel: c.routeArgsWithKeyExperimental<CustomModel?>("customModel"),
      customModel2:
          c.routeArgsWithKeyExperimental<CustomModel2?>("customModel2"),
      isShow: c.routeArgsWithKeyExperimental<bool?>("isShow"),
      items: c.routeArgsWithKeyExperimental<List<CustomModel2>?>("items"),
      name: c.routeArgsWithKeyExperimental<String>("name")!,
      testDefaultIntValue:
          c.routeArgsWithKeyExperimental<int>("testDefaultIntValue") ?? 0,
      testDefaultValue:
          c.routeArgsWithKeyExperimental<String>("testDefaultValue") ??
              "deneme",
    ),
  ),
  RouteMaps.searchRoute: RouteModel(
    (_) => const SearchPage(),
    fullscreenDialog: true,
  ),
  RouteMaps.denemeRoute: RouteModel(
    (_) => const DenemeEkran(),
  ),
  RouteMaps.settingsRoute: RouteModel(
    (c) => SettingsPage(
      name: c.routeArgsWithKeyExperimental<String?>("name"),
    ),
    fullscreenDialog: true,
  ),
};
Route? $onGenerateRoute(RouteSettings routeSettings,
        {String? Function(String routeName)? redirect,
        RouterBuilder? routeBuilder}) =>
    onGenerateRouteWithRoutesSettings(
      routeSettings,
      routes,
      pathRoutes: pathRoutes,
      redirect: redirect,
      routeBuilder: routeBuilder,
    );

class HomeRoute extends BaseRoute {
  HomeRoute() : super(RouteMaps.homeRoute);
  static const String name = RouteMaps.homeRoute;
}

class ProfilRoute extends BaseRoute {
  ProfilRoute() : super(RouteMaps.profilRoute);
  static const String name = RouteMaps.profilRoute;
}

class RootRoute extends BaseRoute {
  RootRoute() : super(RouteMaps.root);
  static const String name = RouteMaps.root;
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
  static const String name = RouteMaps.detail2Route;
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
  static const String name = RouteMaps.testRoute;
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
  static const String name = RouteMaps.detailRoute;
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
  static const String name = RouteMaps.searchRoute;
}

class DenemeRoute extends BaseRoute {
  DenemeRoute() : super(RouteMaps.denemeRoute);
  static const String name = RouteMaps.denemeRoute;
}

class SettingsRoute extends BaseRoute {
  SettingsRoute({
    String? name,
  }) : super(RouteMaps.settingsRoute,
            args: SettingsRouteArgs(
              name: name,
            ).map);
  static const String name = RouteMaps.settingsRoute;
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
