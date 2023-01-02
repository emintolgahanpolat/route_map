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
              child: const Text("Add"))
        ],
      ),
    );
  }
}
