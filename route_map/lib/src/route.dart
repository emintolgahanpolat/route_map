class RouteMap {
  final String? name;
  final List<String>? params;
  final bool fullScreenDialog;
  const RouteMap({this.name, this.params, this.fullScreenDialog = false});
}

class RouteMapInit {
  final List<String> generateForDir;
  const RouteMapInit({
    this.generateForDir = const ['lib'],
  });
}
