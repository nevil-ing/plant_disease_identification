import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:plant_app/models/disease_info.dart';

import 'screens/maize_disease.dart';
import 'themes/themes.dart';

const apiKey = "AIzaSyDmyjxNXMn9zuQW4Y1DpGmjr2LnY-SI2C0";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DiseaseInfoAdapter());
  Hive.openBox<DiseaseInfo>('maize rust');
  Hive.openBox<DiseaseInfo>('grey leaf spot');
  Hive.openBox<DiseaseInfo>('streak');

  Box<DiseaseInfo> maizeRust = Hive.box<DiseaseInfo>('maize rust');
  var maizeDiseaseInfo =
      DiseaseInfo(causes: 'causes', effects: 'weird', prevention: 'nevil');

  await maizeRust.put(maizeDiseaseInfo, maizeDiseaseInfo);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: MaizeDisease(),
      /*
      routes: {
        '/MaizeDisease':(context) => MaizeDisease(),
      },
      */
    );
  }
}
