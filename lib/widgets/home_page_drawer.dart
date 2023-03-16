import 'package:coconut_chronicles/core/storage/preferences_model.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PreferencesModel>(builder: (context, child, model) {
      return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
            child: Container(),
          ),
          FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  return Padding(padding: const EdgeInsets.only(top: 16.0, left: 20), child: Text(data.version));
                }

                return Container();
              })
        ]),
      );
    });
  }
}
