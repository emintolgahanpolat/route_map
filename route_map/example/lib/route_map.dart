import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:route_map/route_map.dart';

import 'route_map.routes.dart';

@RouteMapInit(typeSafe: true, replaceInRouteName: "Page|Screen|Ekran,Route")
Route? onGenerateRoute(RouteSettings routeSettings) => $onGenerateRoute(
      routeSettings,
      redirect: (routeName) {
        if (kIsWeb && routeName == RouteMaps.root) {
          return RouteMaps.homeRoute;
        }
        print(routeName);
        return null;
      },
      routeBuilder: (builder, routeSettings, fullscreenDial) {
        if (routeSettings.name == ProfilRoute.name) {
          return TransparentRoute(
            builder: builder,
            settings: routeSettings,
            backgroundColor: Colors.transparent,
            transitionDuration: const Duration(milliseconds: 0),
            reverseTransitionDuration: const Duration(milliseconds: 250),
          );
        }
        if (routeSettings.name == DetailRoute.name) {
          return ModalSheetRoute(
              builder: builder,
              expanded: false,
              settings: routeSettings,
              isDismissible: false,
              bounce: true,
              barrierLabel: "sacacs");
        }
        return MaterialPageRoute(
            builder: builder,
            fullscreenDialog: fullscreenDial,
            settings: routeSettings);
      },
    );
