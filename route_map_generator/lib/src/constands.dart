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
  RouteModel? route = _routes[routeSettings.name];
  if (route == null) {
    return null;
  }
  return MaterialPageRoute(
      builder: route.builder,
      settings: routeSettings,
      fullscreenDialog: route.fullscreenDialog);
""";
