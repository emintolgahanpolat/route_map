import 'package:flutter/material.dart';

class BaseRoute {
  final String _name;
  final Object? args;
  BaseRoute(this._name, {this.args});
  Future<T?> push<T extends Object?>(
    BuildContext context, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushNamed(
            _name,
            arguments: args,
          )
          .then((value) => value as T?);
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context, {
    bool rootNavigator = false,
    TO? result,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).pushReplacementNamed(
        _name,
        result: result,
        arguments: args,
      );
  Future<T?> popAndPush<T extends Object?, TO extends Object?>(
    BuildContext context, {
    bool rootNavigator = false,
    TO? result,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .popAndPushNamed(
            _name,
            result: result,
            arguments: args,
          )
          .then((value) => value as T?);
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushNamedAndRemoveUntil(
            _name,
            predicate,
            arguments: args,
          )
          .then((value) => value as T?);
  String restorablePush(
    BuildContext context, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).restorablePushNamed(
        _name,
        arguments: args,
      );
  String restorablePushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .restorablePushNamedAndRemoveUntil(
        _name,
        predicate,
        arguments: args,
      );
  String restorablePopAndPush(
    BuildContext context, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .restorablePopAndPushNamed(
        _name,
        arguments: args,
      );
  String restorablePushReplacement(
    BuildContext context, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator)
          .restorablePushReplacementNamed(
        _name,
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
  T? routeArgsWithKey<T>(String key) => routeArgs()?[key];
}

class RouteModel {
  WidgetBuilder builder;
  bool fullscreenDialog;
  RouteModel(
    this.builder, {
    this.fullscreenDialog = false,
  });
}

Route<dynamic>? onGenerateRouteWithRoutesSettings(
  RouteSettings routeSettings,
  Map<String, RouteModel> routes, {
  String? Function(String name)? redirect,
}) {
  String name = routeSettings.name ?? "";
  Map<String, Object?> args = {};

  if (routeSettings.arguments is Map<String, dynamic>) {
    args.addAll(routeSettings.arguments as Map<String, dynamic>);
  } else {
    args.addAll({"extra": routeSettings.arguments});
  }

  var newName = redirect?.call(name) ?? name;
  RouteModel? route = routes[newName];
  if (route == null) {
    return null;
  }

  return MaterialPageRoute(
    builder: route.builder,
    settings: RouteSettings(name: newName, arguments: args),
    fullscreenDialog: route.fullscreenDialog,
  );
}
