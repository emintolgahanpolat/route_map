import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:change_case/change_case.dart';
import 'package:glob/glob.dart';
import 'package:route_map/route_map.dart';
import 'package:route_map_generator/src/model/route_config.dart';
import 'package:route_map_generator/src/helper.dart';
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
// imports
    for (var element in jsonData) {
      buffer.writeln(element.import);
    }
// route names
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
// route map
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
          buffer.writeln("${param.name}: c.routeArgs()?[\"${param.name}\"],");
        }));
        buffer.writeln("),");
      }

      if (page.fullScreenDialog) {
        buffer.writeln("  fullscreenDialog: true,");
      }
      buffer.writeln("),");
    }

    buffer.writeln("};");
// reference code
    buffer.writeln(
        "Route? \$${element.displayName}(RouteSettings routeSettings) {");
    buffer.writeln("""
  RouteModel? route = _routes[routeSettings.name];
  if (route == null) {
    return null;
  }
  return MaterialPageRoute(
      builder: route.builder,
      settings: routeSettings,
      fullscreenDialog: route.fullscreenDialog);
}
""");

// write extension
    buffer.writeln("""
extension RouteSettingsExtension on RouteSettings {
  T? routeArgs<T>() => arguments as T;
}

extension BuildContextExtension on BuildContext {
  NavigatorState navigator() => Navigator.of(this);
  NavigatorState rootNavigator() => Navigator.of(this, rootNavigator: true);
  T? routeArgs<T>() => ModalRoute.of(this)?.settings.arguments as T;
}

class RouteModel {
  WidgetBuilder builder;
  bool fullscreenDialog;
  RouteModel(
    this.builder, {
    this.fullscreenDialog = false,
  });
}
""");

    if (annotation.read('typeSafe').isBool &&
        annotation.read('typeSafe').boolValue) {
      buildTypeSafeNavigator(buffer, jsonData);
    }

    return buffer.toString();
  }
}
