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
    buildArgImports(buffer, jsonArgData);
    buildRoutes(buffer, jsonData);
    buildPathRoutes(buffer, jsonData);
    buildRouteMap(buffer, jsonData);
    buildRouteGenerator(buffer, element.displayName);

    if (annotation.read('typeSafe').isBool &&
        annotation.read('typeSafe').boolValue) {
      buildTypeSafeNavigator(buffer, jsonData);
    }

    return buffer.toString();
  }
}
