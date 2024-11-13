import 'dart:io';

import 'package:flutter/material.dart';

import '../services/databaseHelper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List carousel = [];

  @override
  void initState() {
    super.initState();
    carouselGet();
  }

  carouselGet() async {
    var response = await DatabaseHelper().carouselGet();
    setState(() {
      carousel = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: carousel.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image container with rounded corners
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              child: Image.file(
                                File(carousel[index]['image']),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text(
                          //     carousel[index]['title'],
                          //     style: TextStyle(
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.teal[700],
                          //     ),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
