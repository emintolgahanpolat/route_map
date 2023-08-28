import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap()
class DenemeEkran extends StatefulWidget {
  const DenemeEkran({Key? key}) : super(key: key);
  @override
  State<DenemeEkran> createState() => _DenemeEkranState();
}

class _DenemeEkranState extends State<DenemeEkran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DenemeEkran'),
      ),
    );
  }
}
