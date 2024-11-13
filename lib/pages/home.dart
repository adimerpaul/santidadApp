import 'package:flutter/material.dart';

import '../services/databaseHelper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carouselGet();
  }
  carouselGet() async {
    var response = await DatabaseHelper().carouselGet();
    print(response);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Santidad Divina'),
      // ),
      body: const Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
