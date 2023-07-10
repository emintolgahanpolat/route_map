import 'package:example/custom_model.dart';
import 'package:example/route_map.routes.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap(path: "/detail/:id/:name")
class DetailPage extends StatefulWidget {
  final int id;
  final String name;
  final bool? isShow;
  final CustomModel? customModel;
  const DetailPage(this.id,
      {Key? key, required this.name, this.isShow, this.customModel})
      : super(key: key);

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
          Text("Custom Model: ${widget.customModel?.name}"),
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
                DetailPageRoute(id: 1, name: "push")
                    .push(context)
                    .then((value) {
                  print("push");
                });
              },
              child: const Text("push")),
          ElevatedButton(
              onPressed: () async {
                DetailPageRoute(id: 2, name: "restorablePush")
                    .restorablePush(context);
              },
              child: const Text("restorablePushNamed")),
          ElevatedButton(
              onPressed: () async {
                DetailPageRoute(id: 3, name: "popAndPush")
                    .popAndPush(context)
                    .then((value) {
                  print("popAndPush");
                });
              },
              child: const Text("popAndPush")),
          ElevatedButton(
              onPressed: () async {
                DetailPageRoute(id: 4, name: "pushReplacement")
                    .pushReplacement(context)
                    .then((value) {
                  print("pushReplacement");
                });
              },
              child: const Text("pushReplacement")),
          ElevatedButton(
              onPressed: () async {
                DetailPageRoute(id: 5, name: "restorablePushReplacement")
                    .restorablePushReplacement(context);
              },
              child: const Text("restorablePushReplacement"))
        ],
      ),
    );
  }
}
