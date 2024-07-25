import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:route_map/route_map.dart';
@RouteMap()
class Profil extends StatefulWidget {
  const Profil({super.key});
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      direction: DismissiblePageDismissDirection.multi,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
        ),
      ),
    );
  }
}