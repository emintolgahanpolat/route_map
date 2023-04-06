import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap(name: "settings", fullScreenDialog: true, path: "/settings/:name")
class SettingsPage extends StatelessWidget {
  final String? name;
  const SettingsPage({Key? key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(children: [Text(name ?? "Name null")]),
    );
  }
}
