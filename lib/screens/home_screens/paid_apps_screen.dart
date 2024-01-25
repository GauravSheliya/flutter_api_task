import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../cards/item_card.dart';
import '../../modal/item_modal.dart';

class PaidAppsScreen extends StatefulWidget {
  const PaidAppsScreen({super.key});

  @override
  State<PaidAppsScreen> createState() => _PaidAppsScreenState();
}

class _PaidAppsScreenState extends State<PaidAppsScreen> {
  List<ItemModal> allPaidAppsList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    Uri url = Uri.parse(
        "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json");

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
          allPaidAppsList.add(modal);
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
      body: allPaidAppsList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allPaidAppsList.length,
              itemBuilder: (context, index) {
                if (allPaidAppsList.isNotEmpty) {
                  return ItemCard(
                    itemModal: allPaidAppsList[index],
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
