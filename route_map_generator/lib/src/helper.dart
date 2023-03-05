import 'package:change_case/change_case.dart';
import 'package:route_map_generator/src/constands.dart';
import 'package:route_map_generator/src/model/route_config.dart';

void buildTypeSafeNavigator(StringBuffer buffer, List<RouteConfig> jsonData) {
  for (var page in jsonData) {
    buffer.write("class ${page.clazz}Route extends BaseRoute {");

    if (page.params != null && page.params!.isNotEmpty) {
      page.params?.forEach((param) {
        buffer.write("final ${param.type} ${param.name};");
      });
      buffer.writeln("${page.clazz}Route({");
      page.params?.forEach((param) {
        if (!param.type!.contains("?")) {
          buffer.write("required ");
        }
        buffer.write("this.${param.name},");
      });
      buffer.writeln("});");
    }
    buffer.writeln("@override");
    buffer.write("String get routeName => ");
    if (page.name == "/") {
      buffer.write("RouteMaps.root");
    } else {
      buffer
          .write("RouteMaps.${page.name.replaceFirst("/", "").toCamelCase()}");
    }
    buffer.write(";");

    if (page.params != null && page.params!.isNotEmpty) {
      buffer.writeln("@override");
      buffer.write("Object? get args => {");
      page.params?.forEach((param) {
        buffer.write(" \"${param.name}\": ${param.name},");
      });
      buffer.write("};");
    }
    buffer.writeln("}");
  }
  buffer.write(baseRouteClass);
}

void buildImports(StringBuffer buffer, List<RouteConfig> jsonData) {
  buffer.writeln("import 'package:flutter/material.dart';");
  for (var element in jsonData) {
    buffer.writeln(element.import);
  }
}

void buildArgImports(StringBuffer buffer, List<String> jsonData) {
  buffer.writeln("/// model");
  for (var element in jsonData) {
    buffer.writeln(element);
  }
}

void buildRoutes(StringBuffer buffer, List<RouteConfig> jsonData) {
  buffer.writeln("class RouteMaps{");
  for (var element in jsonData) {
    if (element.name == "/") {
      buffer.write("static String root = \"/\";");
    } else {
      buffer.write(
          "static String ${element.name.replaceFirst("/", "").toCamelCase()} = \"${element.name}\";");
    }
  }
  buffer.writeln("}");
}

void buildRouteMap(StringBuffer buffer, List<RouteConfig> jsonData) {
  buffer.writeln("final Map<String, RouteModel> _routes = {");
  for (var page in jsonData) {
    if (page.name == "/") {
      buffer.writeln('RouteMaps.root : RouteModel(');
    } else {
      buffer.writeln(
          'RouteMaps.${page.name.replaceFirst("/", "").toCamelCase()} : RouteModel(');
    }
    if (page.params == null || page.params!.isEmpty) {
      buffer.writeln(" (_) => const ${page.clazz}(),");
    } else {
      buffer.writeln(" (c) =>");
      buffer.writeln("${page.clazz}(");
      (page.params?.forEach((param) {
        if (param.isPositional!) {
          buffer.writeln("c.routeArgs()?[\"${param.name}\"],");
        } else {
          buffer.writeln("${param.name}: c.routeArgs()?[\"${param.name}\"],");
        }
      }));
      buffer.writeln("),");
    }

    if (page.fullScreenDialog) {
      buffer.writeln("  fullscreenDialog: true,");
    }
    buffer.writeln("),");
  }

  buffer.writeln("};");
}

void buildRouteGenerator(StringBuffer buffer, String displayName) {
  buffer.writeln(
      "Route? \$$displayName(RouteSettings routeSettings,{String? Function()? redirect}) {");
  buffer.writeln(routeBuilderBody);
  buffer.writeln("}");
}
