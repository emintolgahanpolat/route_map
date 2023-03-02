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
  final List<Param>? params;
  final bool fullScreenDialog;

  RouteConfig(
      {required this.name,
      this.params,
      this.fullScreenDialog = false,
      required super.clazz,
      required super.import});

  factory RouteConfig.fromJson(Map<String, dynamic> json) => RouteConfig(
        name: json['name'] as String,
        params:
            (json['params'] as List?)?.map((e) => Param.fromJson(e)).toList(),
        fullScreenDialog: json['fullScreenDialog'] as bool,
        clazz: json['clazz'] as String,
        import: json['import'] as String,
      );

  @override
  Map<String, dynamic> toJson() => {
        'import': import,
        'name': name,
        'params': params,
        'fullScreenDialog': fullScreenDialog,
        'clazz': clazz
      };
}

class Param {
  bool? isPositional;
  String? type;
  String? name;

  Param({this.isPositional, this.type, this.name});

  factory Param.fromJson(Map<String, dynamic> json) => Param(
        isPositional: json['isPositional'] as bool,
        type: json['type'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() =>
      {"isPositional": isPositional, "type": type, "name": name};
}
