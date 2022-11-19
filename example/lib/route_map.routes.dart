// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteMapConfigGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:example/home.dart';
import 'package:example/detail.dart';
import 'package:example/search.dart';

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
  static String root = "/";
  static String detailPage = "/detail_page";
  static String ara = "/ara";
}

final Map<String, RouteModel> _routes = {
  RouteMaps.root: RouteModel(
    (_) => const HomePage(),
  ),
  RouteMaps.detailPage: RouteModel(
    (_) => const DetailPage(),
  ),
  RouteMaps.ara: RouteModel(
    (_) => const SearchPage(),
    fullscreenDialog: true,
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
