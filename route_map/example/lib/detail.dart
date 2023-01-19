import 'package:example/route_map.routes.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

abstract class StatefullPage extends StatefulWidget {
  const StatefullPage({super.key});
}

@RouteMap()
class DetailPage extends StatefullPage {
  final String id;
  final String name;
  final bool? isShow;
  const DetailPage(
      {Key? key, required this.id, required this.name, this.isShow})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

extension DetailPageExtension on DetailPage {
  static DetailPage newInstance(String id, String name, {bool? isShow}) {
    return DetailPage(id: id, name: name, isShow: isShow);
  }
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
          Text(widget.id),
          Text(widget.name),
          Text(widget.isShow.toString()),
          Text("$_counter"),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter = _counter + 1;
                });
              },
              child: const Text("Add")),
          ElevatedButton(
              onPressed: () async {
                const DetailPage(id: "1", name: "push")
                    .push(context)
                    .then((value) {
                  print("push");
                });
              },
              child: const Text("push")),
          ElevatedButton(
              onPressed: () async {
                const DetailPage(id: "2", name: "restorablePush")
                    .restorablePush(context);
              },
              child: const Text("restorablePushNamed")),
          ElevatedButton(
              onPressed: () async {
                const DetailPage(id: "3", name: "popAndPush")
                    .popAndPush(context)
                    .then((value) {
                  print("popAndPush");
                });
              },
              child: const Text("popAndPush")),
          ElevatedButton(
              onPressed: () async {
                const DetailPage(id: "4", name: "pushReplacement")
                    .pushReplacement(context)
                    .then((value) {
                  print("pushReplacement");
                });
              },
              child: const Text("pushReplacement")),
          ElevatedButton(
              onPressed: () async {
                const DetailPage(id: "5", name: "restorablePushReplacement")
                    .restorablePushReplacement(context);
              },
              child: const Text("restorablePushReplacement"))
        ],
      ),
    );
  }
}
