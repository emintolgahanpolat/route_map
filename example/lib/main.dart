import 'package:example/route_map.config.dart';
import 'package:example/route_map.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  appBar: AppBar(title: Text("unknown")),
                ));
      },
    );
  }
}
