import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:route_map/src/route.dart';
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

  String? processType(DartType type) {
    if (type.element != null && type.element!.library != null) {
      final libraryIdentifier = type.element!.library!.identifier;
      if (libraryIdentifier != 'dart:core') {
        return "import '$libraryIdentifier';";
      }
    }
    return null;
  }

  String? processListType(DartType type) {
    if (type is ParameterizedType && type.typeArguments.isNotEmpty) {
      for (var argument in type.typeArguments) {
        var importStatement = processType(argument);
        if (importStatement != null) {
          return importStatement;
        }
      }
    }
    return null;
  }

  @override
  void visitConstructorElement(ConstructorElement element) {
    for (var item in element.type.parameters) {
      if (item.name != "key") {
        var param = Param(
          isPositional: item.isPositional,
          isRequired: item.isRequired,
          defaultValue: item.defaultValueCode,
          name: item.name,
          type: item.type.toString(),
        );

        String? importStatement;
        if (item.type.isDartCoreList) {
          importStatement = processListType(item.type);
        } else {
          importStatement = processType(item.type);
        }
        if (importStatement != null) {
          param.importPath = importStatement;
        }
        elementList.add(param);
      }
    }
  }
}
