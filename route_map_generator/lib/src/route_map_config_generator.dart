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
    buffer.writeln("}");

    buffer.writeln("final Map<String, RouteModel> _routes = {");
    for (var element in jsonData) {
      if (element.name == "/") {
        buffer.writeln('RouteMaps.root : RouteModel(');
      } else {
        buffer.writeln(
            'RouteMaps.${element.name.replaceFirst("/", "").toCamelCase()} : RouteModel(');
      }
      if (element.params == null || element.params!.isEmpty) {
        buffer.writeln(" (_) => const ${element.clazz}(),");
      } else {
        buffer.writeln(" (c) =>");
        buffer.writeln("${element.clazz}(");
        (element.params?.forEach((element) {
          buffer.writeln("$element: c.routeArgs()[\"$element\"],");
        }));
        buffer.writeln("),");
      }

      if (element.fullScreenDialog) {
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
