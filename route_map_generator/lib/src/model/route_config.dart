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
  final String? path;
  final List<Param>? params;
  final bool fullScreenDialog;
  final String? builder;

  RouteConfig(
      {required this.name,
      this.path,
      this.params,
      this.fullScreenDialog = false,
      this.builder,
      required super.clazz,
      required super.import});

  factory RouteConfig.fromJson(Map<String, dynamic> json) => RouteConfig(
        name: json['name'] as String,
        path: json['path'] as String?,
        builder: json['builder'] as String?,
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
        'path': path,
        'params': params,
        'builder': builder,
        'fullScreenDialog': fullScreenDialog,
        'clazz': clazz
      };
}

class Param {
  bool? isPositional;
  bool? isRequired;
  String? defaultValue;
  String? type;
  String? name;
  String? importPath;

  Param(
      {this.isPositional,
      this.isRequired,
      this.defaultValue,
      this.type,
      this.name,
      this.importPath});

  factory Param.fromJson(Map<String, dynamic> json) => Param(
        isPositional: json['isPositional'] as bool?,
        isRequired: json['isRequired'] as bool?,
        defaultValue: json['defaultValue'] as String?,
        type: json['type'] as String?,
        name: json['name'] as String?,
        importPath: json['importPath'] as String?,
      );

  Map<String, dynamic> toJson() => {
        "isPositional": isPositional,
        "isRequired": isRequired,
        "defaultValue": defaultValue,
        "type": type,
        "name": name,
        "importPath": importPath
      };
}
