import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap(name: "settings", fullScreenDialog: true)
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
    );
  }

  login() {}
}
