import 'package:example/route_map.dart';
import 'package:example/route_map.routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        materialTapTargetSize: kIsWeb ? MaterialTapTargetSize.padded : null,
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: RouteMaps.root,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(title: const Text("unknown")),
                ));
      },
    );
  }
}
