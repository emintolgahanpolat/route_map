import 'package:change_case/change_case.dart';
import 'package:route_map_generator/src/model/route_config.dart';

void buildExtensions(StringBuffer buffer, List<RouteConfig> jsonData) {
  for (var page in jsonData) {
    buffer.write("extension ${page.clazz}Ex on ${page.clazz}{");

    // pushNamed START
    buffer.write(
        "Future<T?> push<T extends Object?>(BuildContext context,{bool rootNavigator = false,}) =>  Navigator.of(context,rootNavigator:rootNavigator).pushNamed(");
    _buildBody(buffer, page);
    _buildArgs(buffer, page);
    buffer.writeln(");");
    // pushNamed END

    // pushReplacementNamed START
    buffer.write(
        "Future<T?> pushReplacement<T extends Object?>(BuildContext context,{bool rootNavigator = false,}) =>  Navigator.of(context,rootNavigator:rootNavigator).pushReplacementNamed(");
    _buildBody(buffer, page);
    _buildArgs(buffer, page);
    buffer.writeln(");");
    // pushReplacementNamed END

    // popAndPushNamed START
    buffer.write(
        "Future<T?> popAndPush<T extends Object?>(BuildContext context,{bool rootNavigator = false,}) =>  Navigator.of(context,rootNavigator:rootNavigator).popAndPushNamed(");
    _buildBody(buffer, page);
    _buildArgs(buffer, page);
    buffer.writeln(");");
    // popAndPushNamed END

    // pushNamedAndRemoveUntil START
    buffer.write(
        "Future<T?> pushAndRemoveUntil<T extends Object?>(BuildContext context,bool Function(Route<dynamic>) predicate,{bool rootNavigator = false,}) =>  Navigator.of(context,rootNavigator:rootNavigator).pushNamedAndRemoveUntil(");
    _buildBody(buffer, page);
    buffer.write(",predicate");
    _buildArgs(buffer, page);
    buffer.writeln(");");
    // pushNamedAndRemoveUntil END

    buffer.writeln("}");
  }
}

_buildBody(StringBuffer buffer, RouteConfig page) {
  if (page.name == "/") {
    buffer.write("RouteMaps.root");
  } else {
    buffer.write("RouteMaps.${page.name.replaceFirst("/", "").toCamelCase()}");
  }
}

_buildArgs(StringBuffer buffer, RouteConfig page) {
  if (page.params != null && page.params!.isNotEmpty) {
    buffer.write(",arguments: {");
    page.params?.forEach((param) {
      buffer.write(" \"${param.name}\": ${param.name},");
    });
    buffer.write("},");
  }
}
