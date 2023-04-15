import 'dart:convert';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
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
    String? path;

    if (annotation.read("name").isString) {
      name = annotation.read("name").stringValue;
    }

    if (annotation.read("path").isString) {
      path = annotation.read("path").stringValue;
    }
    String? builder;
    var obj = annotation.read("builder");
    if (!obj.isNull) {
      builder = obj.objectValue.toFunctionValue()?.name;
    }

    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    var rc = RouteConfig(
        import: importPath,
        name: name,
        path: path,
        params: visitor.elementList,
        clazz: element.name!,
        builder: builder,
        fullScreenDialog: annotation.read("fullScreenDialog").boolValue);

    return jsonEncode(rc.toJson());
  }
}

class ModelVisitor extends SimpleElementVisitor<void> {
  final fields = <String, dynamic>{};
  final List<Param> elementList = [];

  @override
  void visitConstructorElement(ConstructorElement element) {
    for (var item in element.type.parameters) {
      if (item.name != "key") {
        elementList.add(Param(
            isPositional: item.isPositional,
            name: item.name,
            type: item.type.toString()));
      }
    }
  }
}
