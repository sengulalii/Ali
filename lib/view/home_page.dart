import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/page_helper.dart';
import '../viewmodel/content_viewmodel.dart';
import 'content_page.dart';

class HomePage extends StatefulWidget with PageHelper {
  HomePage({super.key}) {
    //PrintHelper.printPageData("HomePage");
    printPageData("HomePage");
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PageHelper {
  @override
  Widget build(BuildContext context) {
    var contentViewModel =
        Provider.of<ContentViewModel>(context, listen: true).color;

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  color = Colors.amber;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContentPage(),
                  ),
                );
              },
              child: const Text('Sayfa 1 e git'),
            ),
          ),
        ],
      ),
    );
  }
}
