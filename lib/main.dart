import 'package:flutter/material.dart';
import 'package:sprint1/app/app.dart';
import 'package:sprint1/app/di/di.dart';
import 'package:sprint1/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // await HiveService().clearStudentBox();

  await initDependencies();

  runApp(
    const App(),
  );
}
