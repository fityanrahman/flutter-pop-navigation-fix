import 'package:flutter/material.dart';
import 'package:router_experiment/utils/app.dart';
import 'package:router_experiment/router/app_router.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppRouter.init();
  
  runApp(const App());
}