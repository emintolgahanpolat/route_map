import 'package:flutter/material.dart';

class BaseRoute {
  final String _name;
  final Object? args;
  BaseRoute(this._name, {this.args});
  Future<T?> push<T extends Object?>(
    BuildContext context, {
    bool rootNavigator = false,
  }) =>
      Navigator.of(context, rootNavigator: rootNavigator).pushNamed(
        _name,
        arguments: args,
      );
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
      Navigator.of(context, rootNavigator: rootNavigator).popAndPushNamed(
        _name,
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
        _name,
        predicate,
        arguments: args,
      );
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
  T? routeArgsWithKey<T>(String key) => _typeConverter<T>(routeArgs()?[key]);
  T? routeArgsWithKeyExperimental<T>(String key) =>
      _typeConverter<T>(routeArgs()?[key]);
}

class RouteModel {
  WidgetBuilder builder;
  bool fullscreenDialog;
  RouteModel(
    this.builder, {
    this.fullscreenDialog = false,
  });
}

List? namedRoute(Map<String, String> pathRoutes, String path) {
  bool found = false;
  Map<String, dynamic> params = {};
  Map<String, dynamic> query = {};

  // check for query parameters
  int queryIndex = path.indexOf('/?');
  if (queryIndex != -1) {
    String queryString = path.substring(queryIndex + 2);
    path = path.substring(0, queryIndex);
    List<String> queryParts = queryString.split('&');
    for (String queryPart in queryParts) {
      List<String> queryParam = queryPart.split('=');
      if (queryParam.length == 2) {
        query[queryParam[0]] = queryParam[1];
      }
    }
  }
  for (String key in pathRoutes.keys) {
    List<String> pathParts = path.split('/');
    List<String> keyParts = key.split('/');

    if (pathParts.length == keyParts.length) {
      bool match = true;

      for (int i = 0; i < pathParts.length; i++) {
        if (keyParts[i].startsWith(':')) {
          params[keyParts[i].substring(1)] = pathParts[i];
        } else if (pathParts[i] != keyParts[i]) {
          match = false;
          break;
        }
      }

      if (match) {
        found = true;
        return [
          key,
          pathRoutes[key],
          params.isNotEmpty ? params : null,
          query.isNotEmpty ? query : null,
        ];
      } else {
        params.clear();
      }
    }
  }

  if (!found) {
    return null;
  }
  return null;
}

Route? mOnGenerateRoute(
    RouteSettings routeSettings, Map<String, RouteModel> routes,
    {Map<String, String>? pathRoutes,
    String? Function(String name)? redirect}) {
  String name = routeSettings.name ?? "";
  Map<String, Object?> args = {};
  if (pathRoutes != null) {
    final pathRoute = namedRoute(pathRoutes, name);
    if (pathRoute != null && name != "/") {
      name = pathRoute[1]!;
      Map<String, dynamic>? args1 = pathRoute[2];
      if (args1 != null) {
        args.addAll(args1);
      }
      Map<String, dynamic>? args2 = pathRoute[3];
      if (args2 != null) {
        args.addAll(args2);
      }
    }
  }
  if (routeSettings.arguments is Map<String, dynamic>) {
    args.addAll(routeSettings.arguments as Map<String, dynamic>);
  } else {
    args.addAll({"extra": routeSettings.arguments});
  }

  RouteModel? route = routes[redirect?.call(name) ?? name];
  if (route == null) {
    return null;
  }

  return MaterialPageRoute(
    builder: route.builder,
    settings: RouteSettings(name: routeSettings.name, arguments: args),
    fullscreenDialog: route.fullscreenDialog,
  );
}

// TODO: add support for nested routes
T? _typeConverter<T>(dynamic value) {
  if (value == null) {
    return null;
  } else if (value is String) {
    if (T == int) {
      return int.parse(value) as T;
    } else if (T == double) {
      return double.parse(value) as T;
    } else if (T == bool) {
      return value == "true" as dynamic ? true as T : false as T;
    } else if (T.toString() == "bool?") {
      return value == "true" as dynamic ? true as T? : false as T?;
    } else if (T.toString() == "int?") {
      return int.tryParse(value) as T?;
    } else if (T.toString() == "double?") {
      return double.tryParse(value) as T?;
    } else if (T.toString() == "String?") {
      return value as T?;
    }
  }
  return value as T;
}
