import 'package:example/route_map.dart';
import 'package:example/route_map.routes.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap(name: "/")
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final Map<String, GlobalKey<NavigatorState>> _routes = {
    RouteMaps.homeRoute: GlobalKey<NavigatorState>(),
    RouteMaps.searchRoute: GlobalKey<NavigatorState>()
  };

  int currentIndex = 0;
  setCurrentIndex(int value) {
    currentIndex = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // ignore: collection_methods_unrelated_type
        return !await _routes[currentIndex]!.currentState!.maybePop();
      },
      child: Scaffold(
        body: TabSwitchingView(
          currentTabIndex: currentIndex,
          tabCount: _routes.length,
          tabBuilder: (c, index) {
            return Navigator(
                key: _routes.values.toList()[index],
                initialRoute: _routes.keys.toList()[index],
                onUnknownRoute: (settings) {
                  return MaterialPageRoute(
                      builder: (_) => Scaffold(
                            appBar: AppBar(title: const Text("unknown")),
                          ));
                },
                onGenerateRoute: onGenerateRoute);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: setCurrentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings")
            ]),
      ),
    );
  }
}
