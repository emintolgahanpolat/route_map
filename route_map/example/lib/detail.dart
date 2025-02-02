import 'package:example/custom_model.dart';
import 'package:example/custom_model2.dart';
import 'package:example/route_map.routes.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap(path: "/detail/:id/:name")
class DetailPage extends StatefulWidget {
  final int id;
  final String name;
  final String testDefaultValue;
  final int testDefaultIntValue;
  final bool? isShow;
  final CustomModel? customModel;
  final CustomModel2? customModel2;
  final List<CustomModel2>? items;
  const DetailPage(this.id,
      {super.key,
      required this.name,
      this.testDefaultValue = "deneme",
      this.testDefaultIntValue = 0,
      this.isShow,
      this.customModel,
      this.customModel2,
      this.items});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: ListView(
        children: [
          Text("Default Value: ${widget.testDefaultValue}"),
          Text("Custom Model: ${widget.customModel?.name}"),
          Text("Custom Model 2: ${widget.customModel2?.name}"),
          Text("items Model 2: ${widget.items?.toString()}"),
          Text("id : ${widget.id}"),
          Text("name : ${widget.name}"),
          Text("isShow : ${widget.isShow}"),
          Text("counter : $_counter"),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter = _counter + 1;
                });
              },
              child: const Text("Add")),
          ElevatedButton(
              onPressed: () async {
                DetailRoute(id: 1, name: "push").push(context).then((value) {
                  print("push");
                });
              },
              child: const Text("push")),
          ElevatedButton(
              onPressed: () async {
                DetailRoute(id: 2, name: "restorablePush")
                    .restorablePush(context);
              },
              child: const Text("restorablePushNamed")),
          ElevatedButton(
              onPressed: () async {
                DetailRoute(id: 3, name: "popAndPush")
                    .popAndPush(context)
                    .then((value) {
                  print("popAndPush");
                });
              },
              child: const Text("popAndPush")),
          ElevatedButton(
              onPressed: () async {
                DetailRoute(id: 4, name: "pushReplacement")
                    .pushReplacement(context)
                    .then((value) {
                  print("pushReplacement");
                });
              },
              child: const Text("pushReplacement")),
          ElevatedButton(
              onPressed: () async {
                DetailRoute(id: 5, name: "restorablePushReplacement")
                    .restorablePushReplacement(context);
              },
              child: const Text("restorablePushReplacement"))
        ],
      ),
    );
  }
}
