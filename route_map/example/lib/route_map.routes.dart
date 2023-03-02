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

class RouteMaps {
  static String home = "home";
  static String root = "/";
  static String detailPage = "/detail_page";
  static String ara = "/ara";
  static String settings = "settings";
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
      c.routeArgs()?["id"],
      c.routeArgs()?["abc"],
      isShow: c.routeArgs()?["isShow"],
      name: c.routeArgs()?["name"],
    ),
  ),
  RouteMaps.ara: RouteModel(
    (_) => const SearchPage(),
    fullscreenDialog: true,
  ),
  RouteMaps.settings: RouteModel(
    (c) => SettingsPage(
      name: c.routeArgs()?["name"],
    ),
    fullscreenDialog: true,
  ),
};
Route? $onGenerateRoute(RouteSettings routeSettings,
    {String? Function()? redirect}) {
  RouteModel? route = _routes[redirect?.call() ?? routeSettings.name];
  if (route == null) {
    return null;
  }
  return MaterialPageRoute(
      builder: route.builder,
      settings: routeSettings,
      fullscreenDialog: route.fullscreenDialog);
}

class HomePageRoute extends BaseRoute {
  @override
  String get routeName => RouteMaps.home;
}

class RootPageRoute extends BaseRoute {
  @override
  String get routeName => RouteMaps.root;
}

class DetailPageRoute extends BaseRoute {
  final String id;
  final String abc;
  final bool? isShow;
  final String name;
  DetailPageRoute({
    required this.id,
    required this.abc,
    this.isShow,
    required this.name,
  });
  @override
  String get routeName => RouteMaps.detailPage;
  @override
  Object? get args => {
        "id": id,
        "abc": abc,
        "isShow": isShow,
        "name": name,
      };
}

class SearchPageRoute extends BaseRoute {
  @override
  String get routeName => RouteMaps.ara;
}

class SettingsPageRoute extends BaseRoute {
  final String? name;
  SettingsPageRoute({
    this.name,
  });
  @override
  String get routeName => RouteMaps.settings;
  @override
  Object? get args => {
        "name": name,
      };
}

class BaseRoute {
  late String routeName;
  Object? args;
  Future<T?> push<T extends Object?>(
    BuildContext context, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).pushNamed(
        routeName,
        arguments: args,
      );
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context, {
    bool rootNavigator = false,
    TO? result,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).pushReplacementNamed(
        routeName,
        result: result,
        arguments: args,
      );
  Future<T?> popAndPush<T extends Object?, TO extends Object?>(
    BuildContext context, {
    bool rootNavigator = false,
    TO? result,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).popAndPushNamed(
        routeName,
        result: result,
        arguments: args,
      );
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushNamedAndRemoveUntil(
        routeName,
        predicate,
        arguments: args,
      );
  String restorablePush(
    BuildContext context, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).restorablePushNamed(
        routeName,
        arguments: args,
      );
  String restorablePushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .restorablePushNamedAndRemoveUntil(
        routeName,
        predicate,
        arguments: args,
      );
  String restorablePopAndPush(
    BuildContext context, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .restorablePopAndPushNamed(
        routeName,
        arguments: args,
      );
  String restorablePushReplacement(
    BuildContext context, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .restorablePushReplacementNamed(
        routeName,
        arguments: args,
      );
}

extension RouteSettingsExtension on RouteSettings {
  T? routeArgs<T>() => arguments as T;
}

extension BuildContextExtension on BuildContext {
  NavigatorState navigator() => Navigator.of(this);
  NavigatorState rootNavigator() => Navigator.of(this, rootNavigator: true);
  T? routeArgs<T>() => ModalRoute.of(this)?.settings.arguments as T;
}

class RouteModel {
  WidgetBuilder builder;
  bool fullscreenDialog;
  RouteModel(
    this.builder, {
    this.fullscreenDialog = false,
  });
}
