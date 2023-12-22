import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:route_map/src/route.dart';
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
    final injectableArgConfigFiles = Glob("$dirPattern/**.arg.json");
    final jsonArgData = <String>[];
    await for (final id in buildStep.findAssets(injectableArgConfigFiles)) {
      final String json = await buildStep.readAsString(id);
      jsonArgData.add(json);
    }
    var buffer = StringBuffer();
    buildImports(buffer, jsonData);
    var isTypeSafe = annotation.read('typeSafe').isBool &&
        annotation.read('typeSafe').boolValue;
    if (isTypeSafe) {
      buildArgImports(buffer, jsonArgData);
    }

    String replaceInRouteName =
        annotation.read('replaceInRouteName').stringValue;

    buildRoutes(buffer, jsonData, replaceInRouteName);
    if (jsonData.any((element) => element.path != null)) {
      buffer.writeln("""
  /// URL tabanlı sayfa yönlendirmesi hala deneyseldir. Tür dönüştürmeleriyle ilgili sorunlar var ve henüz kapsamlı bir şekilde test edilmedi.
  /// Yardıma ihtiyacım var.
  /// URL tabanlı sayfa yönlendirmede tür dönüştürme konusunda yardıma ihtiyacım var. int, double, string ve bool'u destekler.

""");
      buildPathRoutes(buffer, jsonData, replaceInRouteName, isTypeSafe);
    }

    //buildRouteMap(buffer, jsonData, replaceInRouteName, isTypeSafe);
    buildRouteGenerator(buffer, element.displayName, jsonData);

    if (annotation.read('typeSafe').isBool &&
        annotation.read('typeSafe').boolValue) {
      buildTypeSafeNavigator(buffer, jsonData, replaceInRouteName);
    }

    return buffer.toString();
  }
}
