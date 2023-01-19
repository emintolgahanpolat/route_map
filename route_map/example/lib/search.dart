import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap(name: "/ara", fullScreenDialog: true)
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
    );
  }
}
