import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/cards/item_card.dart';
import 'package:http/http.dart' as http;

import '../../modal/item_modal.dart';

class FreeAppsScreen extends StatefulWidget {
  const FreeAppsScreen({super.key});

  @override
  State<FreeAppsScreen> createState() => _FreeAppsScreenState();
}

class _FreeAppsScreenState extends State<FreeAppsScreen> {
  List<ItemModal> allFreeAppsList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    Uri url = Uri.parse(
        "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        data["feed"]["results"].map((e) {
          ItemModal modal = ItemModal(
            image: e["artworkUrl100"].toString(),
            title: e["name"].toString(),
            subtitle: e["artistName"].toString(),
            id: e["id"].toString(),
          );
          allFreeAppsList.add(modal);
        }).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something Went Wrong."),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allFreeAppsList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allFreeAppsList.length,
              itemBuilder: (context, index) {
                if (allFreeAppsList.isNotEmpty) {
                  return ItemCard(
                    itemModal: allFreeAppsList[index],
                    number: (index + 1).toString(),
                  );
                } else {
                  return const Center(child: Text("No Data Found."));
                }
              },
            ),
    );
  }
}
