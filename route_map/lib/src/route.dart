/// Marks a class as an route
class RouteMap {
  /// The data used to create the route.
  final String? name;
  final String? path;

  /// The `fullscreenDialog` property specifies whether the incoming route is a
  /// fullscreen modal dialog. On iOS, those routes animate from the bottom to the
  /// top rather than horizontally.
  final bool fullScreenDialog;
  const RouteMap({this.name, this.path, this.fullScreenDialog = false});
}

/// Marks a top-level function as an initializer function
/// for configuring Navigator2
class RouteMapInit {
  /// Only files exist in provided directories will be processed
  final List<String> generateForDir;
  final bool typeSafe;
  const RouteMapInit({
    this.generateForDir = const ['lib'],
    this.typeSafe = true,
  });
}

/// Marks a class as an route arg
class RouteMapArg {
  const RouteMapArg();
}
