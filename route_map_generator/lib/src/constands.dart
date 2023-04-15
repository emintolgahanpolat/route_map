String baseRouteClass = """
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
""";

String routeSettingsExtensiton = """
extension RouteSettingsExtension on RouteSettings {
  T? routeArgs<T>() => arguments as T;
}

extension BuildContextExtension on BuildContext {
  NavigatorState navigator() => Navigator.of(this);
  NavigatorState rootNavigator() => Navigator.of(this, rootNavigator: true);
  T? routeArgs<T>() => ModalRoute.of(this)?.settings.arguments as T;
}
""";

String routeModelClass = """
class RouteModel {
  WidgetBuilder builder;
  bool fullscreenDialog;
  RouteModel(
    this.builder, {
    this.fullscreenDialog = false,
  });
}
""";

String routeBuilderBody = """
  String routeName = routeSettings.name ?? "";
  List? pathRoute = _namedRoute(routeName);
  if (pathRoute != null && routeName != "/") {
    routeName = pathRoute[1]!;
  }
  RouteModel? route = _routes[redirect?.call(routeName) ?? routeName];
  if (route == null) {
    return null;
  }

  return MaterialPageRoute(
    builder: route.builder,
    settings: RouteSettings(name: routeSettings.name, arguments: {
      ...?pathRoute?[2],
      ...?pathRoute?[3],
      if (routeSettings.arguments is Map<String, dynamic>)
        ...(routeSettings.arguments as Map<String, dynamic>)
      else
        'extra': routeSettings.arguments,
    }),
    fullscreenDialog: route.fullscreenDialog,
  );
""";

String namedRouteFunction = """

List? _namedRoute(String path) {
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
  for (String key in _pathRoutes.keys) {
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
          _pathRoutes[key],
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

""";
