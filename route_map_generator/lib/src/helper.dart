import 'package:change_case/change_case.dart';
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

      buffer.write("${page.getClazzName(replaceInRouteName)}():super(");
      if (page.name == "/") {
        buffer.write("RouteMaps.root");
      } else {
        buffer.write(
            "RouteMaps.${page.getClazzName(replaceInRouteName).toCamelCase()}");
      }
      buffer.write(");");
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
      buffer.writeln(
          "}):super(RouteMaps.${page.getClazzName(replaceInRouteName).toCamelCase()},");
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

    buffer.write("static const String name = ");
    if (page.name == "/") {
      buffer.write("RouteMaps.root");
    } else {
      buffer.write(
          "RouteMaps.${page.getClazzName(replaceInRouteName).toCamelCase()}");
    }
    buffer.write(";");

    buffer.writeln("}");

    if (page.params != null && page.params!.isNotEmpty) {
      buffer.write("class ${page.getClazzName(replaceInRouteName)}Args {");

      page.params?.forEach((param) {
        buffer.write("final ${param.type} ${param.name};");
      });
      buffer.writeln("${page.getClazzName(replaceInRouteName)}Args({");
      page.params?.forEach((param) {
        if (param.isRequired == true) {
          buffer.write("required ");
        }
        if (param.defaultValue == null) {
          buffer.write("this.${param.name},");
        } else {
          buffer.write("this.${param.name} = ${param.defaultValue},");
        }
      });
      buffer.writeln("});");

      buffer.write("Map<String,dynamic>? get map => {");
      page.params?.forEach((param) {
        buffer.write(" \"${param.name}\": ${param.name},");
      });
      buffer.write("};");

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

void buildRoutes(StringBuffer buffer, List<RouteConfig> jsonData,
    String replaceInRouteName) {
  buffer.writeln("class RouteMaps{");
  for (var element in jsonData) {
    if (element.name == "/") {
      buffer.write("static const String root = \"/\";");
    } else {
      buffer.write(
          "static const String ${element.getClazzName(replaceInRouteName).toCamelCase()} = \"${element.name}\";");
    }
  }
  buffer.writeln("}");
}

void buildRouteMap(StringBuffer buffer, List<RouteConfig> jsonData,
    String replaceInRouteName) {
  buffer.writeln("Map<String, RouteModel> get routes => _routes;");
  buffer.writeln("final Map<String, RouteModel> _routes = {");
  for (var page in jsonData) {
    if (page.name == "/") {
      buffer.writeln('RouteMaps.root : RouteModel(');
    } else {
      buffer.writeln(
          'RouteMaps.${page.getClazzName(replaceInRouteName).toCamelCase()} : RouteModel(');
    }
    if (page.params == null || page.params!.isEmpty) {
      if (page.builder != null) {
        buffer.writeln("(_) => ${page.builder}( const ${page.clazz}())");
      } else {
        buffer.writeln(" (_) => const ${page.clazz}(),");
      }
    } else {
      buffer.writeln(" (c) =>");
      if (page.builder != null) {
        buffer.writeln(" ${page.builder}(");
      }
      buffer.writeln("${page.clazz}(");
      (page.params?.forEach((param) {
        if (!param.isPositional!) {
          buffer.write("${param.name}:");
        }

        buffer.write("c.routeArgsWithKey<${param.type}>(\"${param.name}\")");

        if (!param.type!.contains("?") && param.defaultValue == null) {
          buffer.write("!");
        }
        if (param.defaultValue != null) {
          buffer.write("?? ${param.defaultValue}");
        }

        buffer.writeln(",");
        // if (param.type == "String" || param.type == "String?") {
        //   buffer.writeln("c.routeArgs()?[\"${param.name}\"],");
        // } else if (param.type == "bool" || param.type == "bool?") {
        //   buffer.writeln(" c.routeArgs()?[\"${param.name}\"]  == \"true\",");
        // } else if (param.type == "int" || param.type == "int?") {
        //   buffer.writeln("int.parse(c.routeArgs()?[\"${param.name}\"]),");
        // } else if (param.type == "double" || param.type == "double?") {
        //   buffer.writeln("double.parse(c.routeArgs()?[\"${param.name}\"]),");
        // } else {
        //   buffer.writeln(
        //       " c.routeArgs()?[\"${param.name}\"] ?? c.routeArgs()?[\"extra\"],");
        // }
      }));
      if (page.builder != null) {
        buffer.writeln(")");
      }
      buffer.writeln("),");
    }

    if (page.fullScreenDialog) {
      buffer.writeln("  fullscreenDialog: true,");
    }
    buffer.writeln("),");
  }

  buffer.writeln("};");
}

void buildRouteGenerator(
    StringBuffer buffer, String displayName, List<RouteConfig> jsonData) {
  buffer.writeln(
      "Route? \$$displayName(RouteSettings routeSettings,{String? Function(String routeName)? redirect}) => onGenerateRouteWithRoutesSettings(routeSettings, routes,);");
}
