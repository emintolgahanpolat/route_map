import 'package:example/custom_model.dart';
import 'package:example/custom_model2.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap()
class Detail2Page extends StatefulWidget {
  final CustomModel customModel;
  final List<CustomModel2> items;
  const Detail2Page({Key? key, required this.customModel, required this.items})
      : super(key: key);
  @override
  State<Detail2Page> createState() => _Detail2PageState();
}

class _Detail2PageState extends State<Detail2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail2Page'),
      ),
    );
  }
}
