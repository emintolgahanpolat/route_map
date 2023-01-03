import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:change_case/change_case.dart';
import 'package:glob/glob.dart';
import 'package:route_map/route_map.dart';
import 'package:route_map_generator/src/model/route_config.dart';
import 'package:source_gen/source_gen.dart';

class RouteMapConfigGenerator extends GeneratorForAnnotation<RouteMapInit> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final generateForDir = annotation
        .read('generateForDir')
        .listValue
        .map((e) => e.toStringValue());
    final dirPattern = generateForDir.length > 1
        ? '{${generateForDir.join(',')}}'
        : '${generateForDir.first}';
    final injectableConfigFiles = Glob("$dirPattern/**.map.json");
    final jsonData = <RouteConfig>[];
    await for (final id in buildStep.findAssets(injectableConfigFiles)) {
      final RouteConfig json =
          RouteConfig.fromJson(jsonDecode(await buildStep.readAsString(id)));
      jsonData.add(json);
    }

    var buffer = StringBuffer();
    buffer.writeln("import 'package:flutter/material.dart';");

    for (var element in jsonData) {
      buffer.writeln(element.import);
    }

    buffer.writeln("extension RouteSettingsEx on RouteSettings {");
    buffer.writeln("T routeArgs<T>() => arguments as T;");
    buffer.writeln("}");

    buffer.writeln("extension BuildContextEx on BuildContext {");
    buffer.writeln("NavigatorState navigator() => Navigator.of(this);");
    buffer.writeln(
        "NavigatorState rootNavigator() => Navigator.of(this, rootNavigator: true);");
    buffer.writeln(
        "T routeArgs<T>() => ModalRoute.of(this)?.settings.arguments as T;");
    buffer.writeln("}");

    buffer.writeln("class RouteModel {");
    buffer.writeln("WidgetBuilder builder;");
    buffer.writeln("bool fullscreenDialog;");
    buffer.writeln("RouteModel(");
    buffer.writeln("this.builder,");
    buffer.writeln("{this.fullscreenDialog = false,");
    buffer.writeln("});");
    buffer.writeln("}");

    buffer.writeln("class RouteMaps{");
    for (var element in jsonData) {
      if (element.name == "/") {
        buffer.write("static String root = \"/\";");
      } else {
        buffer.write(
            "static String ${element.name.replaceFirst("/", "").toCamelCase()} = \"${element.name}\";");
      }
    }

    for (var page in jsonData) {
      buffer.write("static Future<T?>");
      if (page.name == "/") {
        buffer.write('rootNavigate');
      } else {
        buffer
            .write("${page.name.replaceFirst("/", "").toCamelCase()}Navigate");
      }

      buffer.write("<T extends Object?>(BuildContext context");
      // if (page.params != null && page.params!.isNotEmpty) {
      buffer.write(",{");
      buffer.write("bool rootNavigator = false,");
      page.params?.forEach((param) {
        if (param.type!.contains("?")) {
          buffer.write("${param.type} ${param.name},");
        } else {
          buffer.write("required ${param.type} ${param.name},");
        }
      });
      buffer.write("}");
      // }
      buffer.write(
          ") =>  Navigator.of(context,rootNavigator:rootNavigator).pushNamed(");
      if (page.name == "/") {
        buffer.write("RouteMaps.root");
      } else {
        buffer.write(
            "RouteMaps.${page.name.replaceFirst("/", "").toCamelCase()}");
      }
      if (page.params != null && page.params!.isNotEmpty) {
        buffer.write(",arguments: {");
        page.params?.forEach((param) {
          buffer.write(" \"${param.name}\": ${param.name},");
        });
        buffer.write("},");
      }

      buffer.writeln(");");
    }

    buffer.writeln("}");

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
          buffer.writeln("${param.name}: c.routeArgs()[\"${param.name}\"],");
        }));
        buffer.writeln("),");
      }

      if (page.fullScreenDialog) {
        buffer.writeln("  fullscreenDialog: true,");
      }
      buffer.writeln("),");
    }

    buffer.writeln("};");

    buffer.writeln(
        "Route? \$${element.displayName}(RouteSettings routeSettings) {");

    buffer.writeln("RouteModel? route = _routes[routeSettings.name];");
    buffer.writeln("if (route == null) {");
    buffer.writeln("return null;");
    buffer.writeln("  }");
    buffer.writeln("return MaterialPageRoute(");
    buffer.writeln("builder: route.builder,");
    buffer.writeln("settings: routeSettings,");
    buffer.writeln("fullscreenDialog: route.fullscreenDialog);");
    buffer.writeln("}");

    return buffer.toString();
  }
}
