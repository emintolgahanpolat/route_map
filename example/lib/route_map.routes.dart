// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteMapConfigGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:example/home.dart';
import 'package:example/root.dart';
import 'package:example/detail.dart';
import 'package:example/search.dart';
import 'package:example/settings.dart';

extension RouteSettingsEx on RouteSettings {
  T routeArgs<T>() => arguments as T;
}

extension BuildContextEx on BuildContext {
  NavigatorState navigator() => Navigator.of(this);
  NavigatorState rootNavigator() => Navigator.of(this, rootNavigator: true);
  T routeArgs<T>() => ModalRoute.of(this)?.settings.arguments as T;
}

class RouteModel {
  WidgetBuilder builder;
  bool fullscreenDialog;
  RouteModel(
    this.builder, {
    this.fullscreenDialog = false,
  });
}

class RouteMaps {
  static String home = "home";
  static String root = "/";
  static String detailPage = "/detail_page";
  static String ara = "/ara";
  static String settings = "settings";
  static Future<T?> homeNavigate<T extends Object?>(BuildContext context) =>
      Navigator.of(context).pushNamed(RouteMaps.home);
  static Future<T?> rootNavigate<T extends Object?>(BuildContext context) =>
      Navigator.of(context).pushNamed(RouteMaps.root);
  static Future<T?> detailPageNavigate<T extends Object?>(
    BuildContext context, {
    dynamic id,
    dynamic name,
    dynamic isShow,
  }) =>
      Navigator.of(context).pushNamed(RouteMaps.detailPage);
  static Future<T?> araNavigate<T extends Object?>(BuildContext context) =>
      Navigator.of(context).pushNamed(RouteMaps.ara);
  static Future<T?> settingsNavigate<T extends Object?>(BuildContext context) =>
      Navigator.of(context).pushNamed(RouteMaps.settings);
}

final Map<String, RouteModel> _routes = {
  RouteMaps.home: RouteModel(
    (_) => const HomePage(),
  ),
  RouteMaps.root: RouteModel(
    (_) => const RootPage(),
  ),
  RouteMaps.detailPage: RouteModel(
    (c) => DetailPage(
      id: c.routeArgs()["id"],
      name: c.routeArgs()["name"],
      isShow: c.routeArgs()["isShow"],
    ),
  ),
  RouteMaps.ara: RouteModel(
    (_) => const SearchPage(),
    fullscreenDialog: true,
  ),
  RouteMaps.settings: RouteModel(
    (_) => const SettingsPage(),
  ),
};
Route? $onGenerateRoute(RouteSettings routeSettings) {
  RouteModel? route = _routes[routeSettings.name];
  if (route == null) {
    return null;
  }
  return MaterialPageRoute(
      builder: route.builder,
      settings: routeSettings,
      fullscreenDialog: route.fullscreenDialog);
}
