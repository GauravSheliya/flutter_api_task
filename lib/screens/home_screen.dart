import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_task/screens/home_screens/paid_apps_screen.dart';

import 'home_screens/free_apps_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum App { free, paid }

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  App selected = App.free;
  bool isDarkMode =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
        title: Text(
          "Apps",
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        elevation: 1.0,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 35.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CupertinoSearchTextField(
              controller: _searchController,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CupertinoSlidingSegmentedControl(
                groupValue: selected,
                onValueChanged: (App? value) {
                  if (value != null) {
                    setState(() {
                      selected = value;
                    });
                  }
                },
                thumbColor: isDarkMode ? Colors.grey : Colors.white,
                children: <App, Widget>{
                  App.free: Text(
                    "Top Free",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  App.paid: Text(
                    "Top Paid",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                },
              ),
            ),
          ),
          Expanded(
              child: [
            FreeAppsScreen(),
            PaidAppsScreen()
          ][selected == App.free ? 0 : 1]),
        ],
      ),
    );
  }
}
