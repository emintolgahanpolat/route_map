import 'package:example/route_map.routes.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap(name: "detailPage")
class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void didChangeDependencies() {
    String? name = context.routeArgs();
    print(name);
    super.didChangeDependencies();
  }

  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: ListView(
        children: [
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
