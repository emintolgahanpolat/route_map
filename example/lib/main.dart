import 'package:example/route_map.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      onGenerateRoute: onGenerateRoute,
      initialRoute: "/",
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(title: const Text("unknown")),
                ));
      },
    );
  }
}
