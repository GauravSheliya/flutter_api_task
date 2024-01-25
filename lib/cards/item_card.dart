import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_task/modal/item_modal.dart';
import 'package:flutter_task/screens/app_details_screen.dart';

class ItemCard extends StatelessWidget {
  final ItemModal itemModal;
  final String number;

  const ItemCard({super.key, required this.itemModal, required this.number});

  @override
  Widget build(BuildContext context) {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AppDetailsScreen(id: itemModal.id.toString()),
            ));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 84.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        itemModal.image != null
                            ? itemModal.image.toString()
                            : "",
                        height: 70.0,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 11.5,
                      child: CircleAvatar(
                        radius: 10.0,
                        child: Text(number),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemModal.title.toString(),
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black),
                      ),
                      Text(
                        itemModal.subtitle.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const Text(
                        "Entertainment, Photo & Video, Social Networking",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        child: Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 15.0,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
