import 'package:example/route_map.routes.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap(name: "/")
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteMaps.detailPage, arguments: "Merhaba");
              },
              child: const Text("detailPage")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("Unknown");
              },
              child: const Text("Unknown"))
        ],
      ),
    );
  }
}
