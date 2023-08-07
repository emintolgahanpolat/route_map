import 'package:example/custom_model.dart';
import 'package:example/home_vm.dart';
import 'package:example/route_map.routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_map/route_map.dart';

Widget homeBuilder(Widget child) {
  return ChangeNotifierProvider(
    create: (_) => HomeViewModel(),
    child: child,
  );
}

@RouteMap(name: "home", builder: homeBuilder)
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print("Home Page");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              DetailPageRoute(
                id: 0,
                name: "push",
                customModel: CustomModel(name: 'test 123'),
                customModel2: CustomModel2(name: 'CustomModel2 123'),
                isShow: false,
              ).push(context);
            },
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (c) => const AlertDialog(
                        content: Text("""
 DetailPageRoute(
                id: "0",
                name: "push",
                isShow: false,
              ).push(context);
"""),
                      ));
            },
            trailing: const Icon(Icons.chevron_right),
            title: const Text("Detail Page"),
            subtitle: const Text('Type Safe Route'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/detail/1234/tolga/?isShow=true",
                arguments: {
                  "customModel": CustomModel(name: 'CustomModel'),
                  "customModel2": CustomModel2(name: 'CustomModel2')
                },
              );
            },
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (c) => const AlertDialog(
                        content: Text("""
 Navigator.pushNamed(
                context,
                "/detail/1234/tolga/?isShow=true",
                arguments: CustomModel(name: 'test'),
              );
"""),
                      ));
            },
            trailing: const Icon(Icons.chevron_right),
            title: const Text("Detail Page"),
            subtitle: const Text("Uri Route"),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/detail_page",
                arguments: {
                  "id": "1234",
                  "name": "deneme",
                  "isShow": true,
                  "customModel": CustomModel(name: 'test'),
                  "customModel2": CustomModel2(name: 'test'),
                  "testDefaultValue": null
                },
              );
            },
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (c) => const AlertDialog(
                        content: Text("""
  Navigator.pushNamed(
                context,
              "/detail_page",
                arguments: {
                  "id": "1234",
                  "name": "deneme",
                  "isShow": true,
                  "customModel": CustomModel(name: 'test'),
                },
              );
"""),
                      ));
            },
            trailing: const Icon(Icons.chevron_right),
            title: const Text("Detail Page"),
            subtitle: const Text("Naming Route"),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                "Unknown",
              );
            },
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (c) => const AlertDialog(
                        content: Text("""
 Navigator.pushNamed(
                context,
                "404",
              );
"""),
                      ));
            },
            trailing: const Icon(Icons.chevron_right),
            title: const Text("Unknown"),
            subtitle: const Text("Unknown Route"),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: context.read<HomeViewModel>().decrementCounter,
                  child: const Text("Decrement")),
              Expanded(
                  child: Text(
                context.watch<HomeViewModel>().counter.toString(),
                textAlign: TextAlign.center,
              )),
              ElevatedButton(
                  onPressed: context.read<HomeViewModel>().incrementCounter,
                  child: const Text("İncrement")),
            ],
          )
        ],
      ),
    );
  }
}
