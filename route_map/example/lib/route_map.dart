import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

import 'route_map.routes.dart';

@RouteMapInit()
Route? onGenerateRoute(RouteSettings routeSettings) =>
    $onGenerateRoute(routeSettings);
