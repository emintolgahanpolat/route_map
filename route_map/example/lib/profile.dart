import 'package:example/custom_model.dart';
import 'package:example/route_map.routes.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';

@RouteMap()
class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ProfilRoute().push<CustomModel>(context).then((value) {
                  print(value?.name);
                });
              },
              child: const Text("Next Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, CustomModel(name: "asdcasca"));
              },
              child: const Text("Back Page"),
            )
          ],
        ),
      ),
    );
  }
}
