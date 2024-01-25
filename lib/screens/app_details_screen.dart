import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

class AppDetailsScreen extends StatefulWidget {
  final String id;

  const AppDetailsScreen({super.key, required this.id});

  @override
  State<AppDetailsScreen> createState() => _AppDetailsScreenState();
}

class _AppDetailsScreenState extends State<AppDetailsScreen> {
  String appName = "";
  String appIcon = "";
  String companyName = "";
  String rating = "";
  String age = "";
  bool isFree = false;
  String price = "";
  List<dynamic> images = [];
  String description = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    Uri url = Uri.parse("https://itunes.apple.com/lookup?id=${widget.id}");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        appName = data["results"][0]["trackName"].toString();
        appIcon = data["results"][0]["artworkUrl100"].toString();
        companyName = data["results"][0]["artistName"].toString();
        rating =
            data["results"][0]["averageUserRatingForCurrentVersion"].toString();
        age = data["results"][0]["contentAdvisoryRating"].toString();
        isFree = data["results"][0]["formattedPrice"] == "Free" ? true : false;
        price = data["results"][0]["formattedPrice"].toString();

        images = data["results"][0]["screenshotUrls"].toList();

        description = data["results"][0]["description"].toString();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("App Data Not Found."),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
        leadingWidth: 150.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: const [
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                ),
                Text(
                  "Back",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                )
              ],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 35.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            height: 35.0,
            child: Text(
              appName.toString(),
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                appIcon.isEmpty
                    ? Container()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          appIcon.toString(),
                          height: 120.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          companyName.isEmpty ? "" : companyName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 10.0,
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.white,
                              child: Icon(
                                Icons.star,
                                size: 15.0,
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            rating.isEmpty
                                ? Container()
                                : Text(rating.substring(0, 3),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black)),
                            const SizedBox(
                              width: 20.0,
                            ),
                            CircleAvatar(
                              radius: 10.0,
                              backgroundColor: Colors.green.shade400,
                              foregroundColor: Colors.white,
                              child: const Icon(
                                Icons.person,
                                size: 15.0,
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(age,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black)),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                                backgroundColor: isFree
                                    ? Colors.blue
                                    : Colors.pinkAccent.shade200),
                            child: Text(
                              isFree ? "Download" : "Buy $price",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 400.0,
              child: CarouselSlider(
                items: images.map((e) {
                  return Image.network(e);
                }).toList(),
                options: CarouselOptions(
                    height: 400.0,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                    aspectRatio: 9 / 16),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: isDarkMode ? Colors.grey.shade100 : Colors.black),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(description,
                    style: const TextStyle(color: Colors.grey, fontSize: 16.0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
