import 'package:coconut_chronicles/core/models/selected_entry_model.dart';
import 'package:coconut_chronicles/core/storage/preferences_model.dart';
import 'package:coconut_chronicles/core/storage/theming_model.dart';
import 'package:coconut_chronicles/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sharedPreferences = await SharedPreferences.getInstance();

  var preferencesModel = PreferencesModel(sharedPreferences);
  var themingModel = ThemingModel(sharedPreferences);
  var selectedEntryModel = SelectedEntryModel();

  runApp(ScopedModel<ThemingModel>(
      model: themingModel,
      child: ScopedModel<PreferencesModel>(
          model: preferencesModel,
          child: ScopedModel<SelectedEntryModel>(
            model: selectedEntryModel,
            child: const CoreApp(),
          ))));
}

class CoreApp extends StatelessWidget {
  const CoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScopedModelDescendant<ThemingModel>(builder: (context, child, model) {
      return MaterialApp(
        title: 'Coconut Chronicles',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          brightness: model.darkMode ? Brightness.dark : Brightness.light,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      );
    });
  }
}
