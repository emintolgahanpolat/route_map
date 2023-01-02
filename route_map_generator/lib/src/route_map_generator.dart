import 'dart:convert';

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

    if (annotation.read("name").isString) {
      name = annotation.read("name").stringValue;
    }

    List<Param>? params = [];
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    for (final field in visitor.fields.entries) {
      params.add(Param(type: field.value, name: field.key));
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

class ModelVisitor extends SimpleElementVisitor<void> {
  // 2
  late String className;
  final fields = <String, dynamic>{};

  // 3
  @override
  void visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();
    // 4
    className = elementReturnType.replaceFirst('*', '');
  }

  // 5
  @override
  void visitFieldElement(FieldElement element) {
    final elementType = element.type.toString();
    // 7
    fields[element.name] = elementType.replaceFirst('*', '');
  }
}
