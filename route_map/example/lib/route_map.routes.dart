// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteMapConfigGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';
import 'package:example/home.dart';
import 'package:example/root.dart';
import 'package:example/detail.dart';
import 'package:example/search.dart';
import 'package:example/settings.dart';

/// Type Safe Extra Arg Classes
import 'package:example/custom_model.dart';

class RouteMaps {
  static String homePage = "home";
  static String root = "/";
  static String detailPage = "/detail_page";
  static String searchPage = "/ara";
  static String settingsPage = "settings";
}

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
  RouteMaps.detailPage: RouteModel(
    (c) => DetailPage(
      c.routeArgsWithKey<int>("id")!,
      customModel: c.routeArgsWithKey<CustomModel?>("customModel"),
      isShow: c.routeArgsWithKey<bool?>("isShow"),
      name: c.routeArgsWithKey<String>("name")!,
    ),
  ),
  RouteMaps.searchPage: RouteModel(
    (_) => const SearchPage(),
    fullscreenDialog: true,
  ),
  RouteMaps.settingsPage: RouteModel(
    (c) => SettingsPage(
      name: c.routeArgsWithKey<String?>("name"),
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
