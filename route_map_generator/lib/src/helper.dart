import 'package:route_map_generator/src/model/route_config.dart';

void buildTypeSafeNavigator(StringBuffer buffer, List<RouteConfig> jsonData,
    String replaceInRouteName) {
  for (var page in jsonData) {
    if (page.params != null && page.params!.isNotEmpty) {
      buffer.write(
          "class ${page.getClazzName(replaceInRouteName)} extends BaseRoute {");
    } else {
      buffer.write(
          "class ${page.getClazzName(replaceInRouteName)} extends BaseRoute {");

      buffer.write("${page.getClazzName(replaceInRouteName)}():super(name);");
    }
    if (page.params != null && page.params!.isNotEmpty) {
      buffer.writeln("${page.getClazzName(replaceInRouteName)}({");
      page.params?.forEach((param) {
        if (param.isRequired == true) {
          buffer.write("required ");
        }
        if (param.defaultValue == null) {
          buffer.write(" ${param.type} ${param.name},");
        } else {
          buffer.write(" ${param.type}? ${param.name},");
        }
      });
      buffer
          .writeln("}):super( ${page.getClazzName(replaceInRouteName)}.name,");
      if (page.params != null && page.params!.isNotEmpty) {
        buffer.writeln("args: ");
        buffer.write("${page.getClazzName(replaceInRouteName)}Args (");
        page.params?.forEach((param) {
          if (param.defaultValue == null) {
            buffer.write("${param.name}:${param.name},");
          } else {
            buffer.write(
                "${param.name}: ${param.name} ?? ${param.defaultValue},");
          }
        });
        buffer.writeln(").map");
      }
      buffer.writeln(");");
    }

    if (page.name == "/") {
      buffer.write("static const String name = \"/\";");
    } else {
      buffer.write("static const String name = \"${page.name}\";");
    }

    buffer.write(" static WidgetBuilder builder =");
    if (page.params == null || page.params!.isEmpty) {
      if (page.builder != null) {
        buffer.writeln("(_) => ${page.builder}( const ${page.clazz}());");
      } else {
        buffer.writeln(" (_) => const ${page.clazz}();");
      }
    } else {
      buffer.writeln(" (c) {");
      if (page.builder != null) {
        buffer.writeln(" ${page.builder}(");
      }
      buffer.writeln(
          "${page.getClazzName(replaceInRouteName)}Args args = ${page.getClazzName(replaceInRouteName)}Args.getArgs(c);");
      buffer.writeln("return ${page.clazz}(");
      (page.params?.forEach((param) {
        if (!param.isPositional!) {
          buffer.write("${param.name}:");
        }
        if (param.defaultValue == null) {
          buffer.write("args.${param.name},");
        } else {
          buffer.write("args.${param.name} ?? ${param.defaultValue} ,");
        }
      }));
      buffer.writeln(");};");
    }

    buffer.writeln(
        "static const bool fullScreenDialog = ${page.fullScreenDialog};");

    buffer.writeln("}");

    if (page.params != null && page.params!.isNotEmpty) {
      buffer.write("class ${page.getClazzName(replaceInRouteName)}Args {");

      page.params?.forEach((param) {
        if (param.defaultValue == null) {
          buffer.write("final ${param.type} ${param.name};");
        } else {
          buffer.write("final ${param.type}? ${param.name};");
        }
      });
      buffer.writeln("${page.getClazzName(replaceInRouteName)}Args({");
      page.params?.forEach((param) {
        if (param.isRequired == true) {
          buffer.write("required ");
        }
        buffer.write("this.${param.name},");
      });
      buffer.writeln("});");

      buffer.write("Map<String,dynamic>? get map => {");
      page.params?.forEach((param) {
        buffer.write(" \"${param.name}\": ${param.name},");
      });
      buffer.write("};");

      buffer.write(
          "static ${page.getClazzName(replaceInRouteName)}Args getArgs(BuildContext context) {");
      buffer.writeln(
          " Map<String, dynamic> args =  ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;");
      buffer.write("return ${page.getClazzName(replaceInRouteName)}Args(");
      page.params?.forEach((param) {
        if (param.defaultValue == null) {
          buffer.write(
              " ${param.name}: args[\"${param.name}\"] as ${param.type},");
        } else {
          buffer.write(
              " ${param.name}: args[\"${param.name}\"] as ${param.type}?,");
        }
      });
      buffer.writeln(");}");
      buffer.writeln("}");
    }
  }
  // buffer.write(baseRouteClass);
}

void buildImports(StringBuffer buffer, List<RouteConfig> jsonData) {
  buffer.writeln("import 'package:flutter/material.dart';");
  buffer.writeln("import 'package:route_map/route_map.dart';");
  var imports = jsonData.map((element) => element.import).toList();
  var paramsImport = jsonData
      .expand((element) => [...?element.params].map((e) => e.importPath ?? ""))
      .toList();

  var uniqueItems = {...imports, ...paramsImport}.toList();

  for (var item in uniqueItems) {
    buffer.writeln(item);
  }
}

// Type Safe Extra Arg imports
void buildArgImports(StringBuffer buffer, List<String> jsonData) {
  for (var element in jsonData) {
    buffer.writeln(element);
  }
}

void buildPathRoutes(StringBuffer buffer, List<RouteConfig> jsonData,
    String replaceInRouteName) {
  buffer.writeln("Map<String, String> get pathRoutes => _pathRoutes;");
  buffer.writeln("final Map<String, String> _pathRoutes = {");
  for (var element in jsonData) {
    if (element.path != null) {
      if (element.path == "/") {
        buffer.write("\"/\": RouteMaps.root,");
      } else {
        buffer.write(
            "\"${element.path}\": ${element.getClazzName(replaceInRouteName)}.name ,");
      }
    }
  }
  buffer.writeln("};");
}

void buildRouteMap(StringBuffer buffer, List<RouteConfig> jsonData,
    String replaceInRouteName) {
  buffer.writeln("Map<String, RouteModel> get routes => _routes;");
  buffer.writeln("final Map<String, RouteModel> _routes = {");
  for (var page in jsonData) {
    buffer.writeln(
        ' ${page.getClazzName(replaceInRouteName)}.name  : RouteModel(');

    buffer.writeln(" ${page.getClazzName(replaceInRouteName)}.builder,");

    buffer.writeln(
        "fullscreenDialog: ${page.getClazzName(replaceInRouteName)}.fullScreenDialog,");

    buffer.writeln("),");
  }

  buffer.writeln("};");
}

void buildRouteGenerator(
    StringBuffer buffer, String displayName, List<RouteConfig> jsonData) {
  buffer.writeln(
      "Route? \$$displayName(RouteSettings routeSettings,{String? Function(String routeName)? redirect}) => onGenerateRouteWithRoutesSettings(routeSettings, routes,");
  if (jsonData.any((element) => element.path != null)) {
    buffer.writeln("pathRoutes: pathRoutes,");
  }
  buffer.writeln("redirect: redirect,");
  buffer.writeln(");");
}
