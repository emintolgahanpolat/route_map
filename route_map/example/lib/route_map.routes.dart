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
import 'package:example/custom_model.dart';

class RouteMaps {
  static const String homePage = "home";
  static const String root = "/";
  static const String detail2Page = "/detail2_page";
  static const String detailPage = "/detail_page";
  static const String searchPage = "/ara";
  static const String settingsPage = "settings";
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
      customModel2:
          c.routeArgsWithKeyExperimental<CustomModel2?>("customModel2"),
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
    onGenerateRouteWithRoutesSettings(
      routeSettings,
      routes,
      pathRoutes: pathRoutes,
      redirect: redirect,
    );

class HomePageRoute extends BaseRoute {
  HomePageRoute() : super(RouteMaps.homePage);
  static const String name = RouteMaps.homePage;
}

class RootPageRoute extends BaseRoute {
  RootPageRoute() : super(RouteMaps.root);
  static const String name = RouteMaps.root;
}

class Detail2PageRoute extends BaseRoute {
  Detail2PageRoute({
    required CustomModel customModel,
  }) : super(RouteMaps.detail2Page,
            args: Detail2PageArgs(
              customModel: customModel,
            ).map);
  static const String name = RouteMaps.detail2Page;
}

class Detail2PageArgs {
  final CustomModel customModel;
  Detail2PageArgs({
    required this.customModel,
  });
  Map<String, dynamic>? get map => {
        "customModel": customModel,
      };
}

class DetailPageRoute extends BaseRoute {
  DetailPageRoute({
    required int id,
    CustomModel? customModel,
    CustomModel2? customModel2,
    bool? isShow,
    required String name,
  }) : super(RouteMaps.detailPage,
            args: DetailPageArgs(
              id: id,
              customModel: customModel,
              customModel2: customModel2,
              isShow: isShow,
              name: name,
            ).map);
  static const String name = RouteMaps.detailPage;
}

class DetailPageArgs {
  final int id;
  final CustomModel? customModel;
  final CustomModel2? customModel2;
  final bool? isShow;
  final String name;
  DetailPageArgs({
    required this.id,
    this.customModel,
    this.customModel2,
    this.isShow,
    required this.name,
  });
  Map<String, dynamic>? get map => {
        "id": id,
        "customModel": customModel,
        "customModel2": customModel2,
        "isShow": isShow,
        "name": name,
      };
}

class SearchPageRoute extends BaseRoute {
  SearchPageRoute() : super(RouteMaps.searchPage);
  static const String name = RouteMaps.searchPage;
}

class SettingsPageRoute extends BaseRoute {
  SettingsPageRoute({
    String? name,
  }) : super(RouteMaps.settingsPage,
            args: SettingsPageArgs(
              name: name,
            ).map);
  static const String name = RouteMaps.settingsPage;
}

class SettingsPageArgs {
  final String? name;
  SettingsPageArgs({
    this.name,
  });
  Map<String, dynamic>? get map => {
        "name": name,
      };
}
