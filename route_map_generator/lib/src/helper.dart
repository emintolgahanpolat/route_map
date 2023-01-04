import 'package:change_case/change_case.dart';
import 'package:route_map_generator/src/model/route_config.dart';

void buildNavigatorExtensions(StringBuffer buffer, List<RouteConfig> jsonData) {
  for (var page in jsonData) {
    buffer.write("extension ${page.clazz}Extension on ${page.clazz}{");

    if (page.params != null && page.params!.isNotEmpty) {
      buffer.write(" Object get _args => {");
      page.params?.forEach((param) {
        buffer.write(" \"${param.name}\": ${param.name},");
      });
      buffer.write("};");
    }
    // pushNamed START
    buffer.write(
        "Future<T?> push<T extends Object?>(BuildContext context,{bool rootNavigator = false,}) =>  Navigator.of(context,rootNavigator:rootNavigator).pushNamed(");
    _buildBody(buffer, page);
    _buildArgs(buffer, page);
    buffer.writeln(");");
    // pushNamed END

    // pushReplacementNamed START
    buffer.write(
        "Future<T?> pushReplacement<T extends Object?, TO extends Object?>(BuildContext context,{bool rootNavigator = false,TO? result,}) =>  Navigator.of(context,rootNavigator:rootNavigator).pushReplacementNamed(");
    _buildBody(buffer, page);
    buffer.writeln(",result:result");
    _buildArgs(buffer, page);
    buffer.writeln(");");
    // pushReplacementNamed END

    // popAndPushNamed START
    buffer.write(
        "Future<T?> popAndPush<T extends Object?, TO extends Object?>(BuildContext context,{bool rootNavigator = false,TO? result,}) =>  Navigator.of(context,rootNavigator:rootNavigator).popAndPushNamed(");
    _buildBody(buffer, page);
    buffer.writeln(",result:result");
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

    // restorablePushNamed START
    buffer.write(
        "String restorablePush(BuildContext context,{bool rootNavigator = false,}) =>  Navigator.of(context,rootNavigator:rootNavigator).restorablePushNamed(");
    _buildBody(buffer, page);
    _buildArgs(buffer, page);
    buffer.writeln(");");
    // restorablePushNamed END

    // restorablePushNamedAndRemoveUntil START
    buffer.write(
        "String restorablePushAndRemoveUntil<T extends Object?>(BuildContext context,bool Function(Route<dynamic>) predicate,{bool rootNavigator = false,}) =>  Navigator.of(context,rootNavigator:rootNavigator).restorablePushNamedAndRemoveUntil(");
    _buildBody(buffer, page);
    buffer.write(",predicate");
    _buildArgs(buffer, page);
    buffer.writeln(");");
    // restorablePushNamedAndRemoveUntil END

    // restorablePopAndPushNamed START
    buffer.write(
        "String restorablePopAndPush(BuildContext context,{bool rootNavigator = false,}) =>  Navigator.of(context,rootNavigator:rootNavigator).restorablePopAndPushNamed(");
    _buildBody(buffer, page);
    _buildArgs(buffer, page);
    buffer.writeln(");");
    // restorablePopAndPushNamed END
    // restorablePushReplacementNamed START
    buffer.write(
        "String restorablePushReplacement(BuildContext context,{bool rootNavigator = false,}) =>  Navigator.of(context,rootNavigator:rootNavigator).restorablePushReplacementNamed(");
    _buildBody(buffer, page);
    _buildArgs(buffer, page);
    buffer.writeln(");");
    buffer.writeln("}");
    // restorablePushReplacementNamed END
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
    buffer.writeln(",arguments:_args,");
  }
}
