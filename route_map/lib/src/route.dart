class RouteMap {
  final String? name;
  final bool fullScreenDialog;
  const RouteMap({this.name, this.fullScreenDialog = false});
}

class RouteMapInit {
  final List<String> generateForDir;
  const RouteMapInit({
    this.generateForDir = const ['lib'],
  });
}
