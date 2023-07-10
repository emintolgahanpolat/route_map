import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

import 'route_map.routes.dart';

@RouteMapInit(typeSafe: true)
Route? onGenerateRoute(RouteSettings routeSettings) => $onGenerateRoute(
      routeSettings,
      redirect: (routeName) {
        if (kIsWeb && routeName == RouteMaps.root) {
          return RouteMaps.homePage;
        }
        print(routeName);
        return null;
      },
    );
