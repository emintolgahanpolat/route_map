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

Map<String, RoutePathModel> get pathRoutes => _pathRoutes;
final Map<String, RoutePathModel> _pathRoutes = {
  "/detail/:id/:name": RoutePathModel(
    (c, p) {
      Map<String, dynamic> args =
          ModalRoute.of(c)?.settings.arguments as Map<String, dynamic>;
      Map<String, dynamic> pathArgs = getPathArgs(p, "/detail/:id/:name");
      args.addAll(pathArgs);
      return DetailPage(
        args["id"]!,
        customModel: args["customModel"],
        customModel2: args["customModel2"],
        isShow: args["isShow"],
        items: args["items"],
        name: args["name"]!,
        testDefaultIntValue: args["testDefaultIntValue"] ?? 0,
        testDefaultValue: args["testDefaultValue"] ?? "deneme",
      );
    },
    "/detail_page",
  ),
  "/settings/:name": RoutePathModel(
    (c, p) {
      Map<String, dynamic> args =
          ModalRoute.of(c)?.settings.arguments as Map<String, dynamic>;
      Map<String, dynamic> pathArgs = getPathArgs(p, "/settings/:name");
      args.addAll(pathArgs);
      return SettingsPage(
        name: args["name"],
      );
    },
    "settings",
    fullscreenDialog: true,
  ),
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
    (c) {
      Map<String, dynamic> args =
          ModalRoute.of(c)?.settings.arguments as Map<String, dynamic>;
      return Detail2Page(
        customModel: args["customModel"]!,
        items: args["items"]!,
      );
    },
  ),
  RouteMaps.testRoute: RouteModel(
    (_) => const TestScreen(),
  ),
  RouteMaps.detailRoute: RouteModel(
    (c) {
      Map<String, dynamic> args =
          ModalRoute.of(c)?.settings.arguments as Map<String, dynamic>;
      return DetailPage(
        args["id"]!,
        customModel: args["customModel"],
        customModel2: args["customModel2"],
        isShow: args["isShow"],
        items: args["items"],
        name: args["name"]!,
        testDefaultIntValue: args["testDefaultIntValue"] ?? 0,
        testDefaultValue: args["testDefaultValue"] ?? "deneme",
      );
    },
  ),
  RouteMaps.searchRoute: RouteModel(
    (_) => const SearchPage(),
    fullscreenDialog: true,
  ),
  RouteMaps.denemeRoute: RouteModel(
    (_) => const DenemeEkran(),
  ),
  RouteMaps.settingsRoute: RouteModel(
    (c) {
      Map<String, dynamic> args =
          ModalRoute.of(c)?.settings.arguments as Map<String, dynamic>;
      return SettingsPage(
        name: args["name"],
      );
    },
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
