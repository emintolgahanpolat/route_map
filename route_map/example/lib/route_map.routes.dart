// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteMapConfigGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';
import 'package:example/home.dart';
import 'package:example/root.dart';
import 'package:example/detail2.dart';
import 'package:example/detail.dart';
import 'package:example/search.dart';
import 'package:example/settings.dart';

/// Type Safe Extra Arg Classes
import 'package:example/custom_model.dart';

class RouteMaps {
  static String homePage = "home";
  static String root = "/";
  static String detail2Page = "/detail2_page";
  static String detailPage = "/detail_page";
  static String searchPage = "/ara";
  static String settingsPage = "settings";
}

/// URL tabanlı sayfa yönlendirmesi hala deneyseldir. Tür dönüştürmeleriyle ilgili sorunlar var ve henüz kapsamlı bir şekilde test edilmedi.
/// Yardıma ihtiyacım var.
/// URL tabanlı sayfa yönlendirmede tür dönüştürme konusunda yardıma ihtiyacım var. int, double, string ve bool'u destekler.

Map<String, String> get pathRoutes => _pathRoutes;
final Map<String, String> _pathRoutes = {
  "/detail/:id/:name": RouteMaps.detailPage,
  "/settings/:name": RouteMaps.settingsPage,
};
Map<String, RouteModel> get routes => _routes;
final Map<String, RouteModel> _routes = {
  RouteMaps.homePage: RouteModel((_) => homeBuilder(const HomePage())),
  RouteMaps.root: RouteModel(
    (_) => const RootPage(),
  ),
  RouteMaps.detail2Page: RouteModel(
    (c) => Detail2Page(
      customModel: c.routeArgsWithKeyExperimental<CustomModel>("customModel")!,
    ),
  ),
  RouteMaps.detailPage: RouteModel(
    (c) => DetailPage(
      c.routeArgsWithKeyExperimental<int>("id")!,
      customModel: c.routeArgsWithKeyExperimental<CustomModel?>("customModel"),
      isShow: c.routeArgsWithKeyExperimental<bool?>("isShow"),
      name: c.routeArgsWithKeyExperimental<String>("name")!,
    ),
  ),
  RouteMaps.searchPage: RouteModel(
    (_) => const SearchPage(),
    fullscreenDialog: true,
  ),
  RouteMaps.settingsPage: RouteModel(
    (c) => SettingsPage(
      name: c.routeArgsWithKeyExperimental<String?>("name"),
    ),
    fullscreenDialog: true,
  ),
};
Route? $onGenerateRoute(RouteSettings routeSettings,
        {String? Function(String routeName)? redirect}) =>
    mOnGenerateRoute(
      routeSettings,
      routes,
      pathRoutes: pathRoutes,
      redirect: redirect,
    );

class HomePageRoute extends BaseRoute {
  @override
  String get routeName => RouteMaps.homePage;
}

class RootPageRoute extends BaseRoute {
  @override
  String get routeName => RouteMaps.root;
}

class Detail2PageRoute extends BaseRoute {
  final CustomModel customModel;
  Detail2PageRoute({
    required this.customModel,
  });
  @override
  String get routeName => RouteMaps.detail2Page;
  @override
  Map<String, dynamic>? get args => {
        "customModel": customModel,
      };
}

class DetailPageRoute extends BaseRoute {
  final int id;
  final CustomModel? customModel;
  final bool? isShow;
  final String name;
  DetailPageRoute({
    required this.id,
    this.customModel,
    this.isShow,
    required this.name,
  });
  @override
  String get routeName => RouteMaps.detailPage;
  @override
  Map<String, dynamic>? get args => {
        "id": id,
        "customModel": customModel,
        "isShow": isShow,
        "name": name,
      };
}

class SearchPageRoute extends BaseRoute {
  @override
  String get routeName => RouteMaps.searchPage;
}

class SettingsPageRoute extends BaseRoute {
  final String? name;
  SettingsPageRoute({
    this.name,
  });
  @override
  String get routeName => RouteMaps.settingsPage;
  @override
  Map<String, dynamic>? get args => {
        "name": name,
      };
}
