import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sprint1/features/home/data/model/product.dart';
import 'package:sprint1/app/app.dart';
import 'package:sprint1/app/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter()); // Register your model adapter
  await Hive.openBox<Product>('productsBox'); // Open a Hive box for products
  await initDependencies(); // Initialize dependencies before running the app
  runApp(const App());
}