import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify/notify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home.dart';
import 'theme.dart';
import 'theme_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifictionServiece.init();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'To do',
      home:
      // Musical(),
      Home(),
      theme:Themes.design_light,
      darkTheme: Themes.design_dark,
      themeMode: ThemeServices().theme,
    );
  }
}

