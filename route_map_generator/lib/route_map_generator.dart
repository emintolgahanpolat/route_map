import 'package:build/build.dart';
import 'package:route_map_generator/src/route_map_arg_generator.dart';
import 'package:route_map_generator/src/route_map_config_generator.dart';
import 'package:route_map_generator/src/route_map_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder routeMapBuilder(BuilderOptions options) {
  return LibraryBuilder(
    RouteMapGenerator(),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.map.json',
  );
}

Builder routeMapArgBuilder(BuilderOptions options) {
  return LibraryBuilder(
    RouteMapArgGenerator(),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.arg.json',
  );
}

Builder routeMapConfigBuilder(BuilderOptions options) =>
    LibraryBuilder(RouteMapConfigGenerator(),
        generatedExtension: ".routes.dart");
