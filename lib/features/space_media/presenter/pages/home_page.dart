// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'picture_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Space Media'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Welcome to Astronomy Picture of the Day!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(
                  height: 150,
                ),
                RoundButton(
                  label: "Select datetime",
                  onTap: () async {
                    var datePicked = await showDatePicker(
                      helpText: "Select a datetime",
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1995, 06, 16),
                      lastDate: DateTime.now(),
                    );
                    PicturePage.navigate(datePicked);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
