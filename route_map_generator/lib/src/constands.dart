String routeBuilderBody = """
  String routeName = routeSettings.name ?? "";
  final pathRoute = namedRoute(_pathRoutes,routeName);
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
