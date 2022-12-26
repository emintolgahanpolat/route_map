import 'dart:convert';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:route_map/route_map.dart';
import 'package:route_map_generator/src/model/route_config.dart';
import 'package:source_gen/source_gen.dart';
import 'package:change_case/change_case.dart';

class RouteMapGenerator extends GeneratorForAnnotation<RouteMap> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    String importPath = "import '${buildStep.inputId.uri.toString()}';";
    String name = "/${element.name!.toConstantCase().toLowerCase()}";

    if (annotation.read("name").isString) {
      name = annotation.read("name").stringValue;
    }

    List<String>? params;
    if (annotation.read("params").isList) {
      params = annotation
          .read("params")
          .listValue
          .map((e) => "${e.toStringValue()}")
          .toList();
    }

    var rc = RouteConfig(
        import: importPath,
        name: name,
        params: params,
        clazz: element.name!,
        fullScreenDialog: annotation.read("fullScreenDialog").boolValue);

    return jsonEncode(rc.toJson());
  }
}
