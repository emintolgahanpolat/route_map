class RouteMapConfig {
  final String import;
  final String clazz;
  const RouteMapConfig({required this.import, required this.clazz});

  factory RouteMapConfig.fromJson(Map<String, dynamic> json) => RouteMapConfig(
        import: json['import'] as String,
        clazz: json['clazz'] as String,
      );

  Map<String, dynamic> toJson() => {
        'import': import,
        'clazz': clazz,
      };
}

class RouteConfig extends RouteMapConfig {
  final String name;
  final bool fullScreenDialog;

  RouteConfig(
      {required this.name,
      this.fullScreenDialog = false,
      required super.clazz,
      required super.import});

  factory RouteConfig.fromJson(Map<String, dynamic> json) => RouteConfig(
        name: json['name'] as String,
        fullScreenDialog: json['fullScreenDialog'] as bool,
        clazz: json['clazz'] as String,
        import: json['import'] as String,
      );

  @override
  Map<String, dynamic> toJson() => {
        'import': import,
        'name': name,
        'fullScreenDialog': fullScreenDialog,
        'clazz': clazz
      };
}
