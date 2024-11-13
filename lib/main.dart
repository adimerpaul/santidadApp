import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:santidad/pages/home.dart';
import 'package:santidad/pages/product.dart';
import 'package:santidad/services/databaseHelper.dart';

Future<void> main() async {
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  await dotenv.load(fileName: isProduction ? '.env.production' : '.env');
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santidad Divina',
      // home: Home(),
      routes: {
        '/': (context) => Home(),
        '/products': (context) => Product(),
      },
      initialRoute: '/',
    );
  }
}
