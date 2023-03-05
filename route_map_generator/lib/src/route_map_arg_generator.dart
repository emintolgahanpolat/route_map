import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:route_map/route_map.dart';
import 'package:source_gen/source_gen.dart';

class RouteMapArgGenerator extends GeneratorForAnnotation<RouteMapArg> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return "import '${buildStep.inputId.uri.toString()}';";
  }
}
