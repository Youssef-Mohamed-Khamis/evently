import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/resources/ColorManager.dart';
import 'package:evently/model/Event.dart';
import 'package:evently/ui/edit_event/screen/edit_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../core/providers/UserProvider.dart';
import '../../../core/remote/network/FirestoreManager.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = 'event_details';
  Event event;

  EventDetails(this.event, {super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    DateTime eventDate = (widget.event.date as Timestamp).toDate();

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEvent(widget.event),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              bool? confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Delete Event"),
                  content: Text("Are you sure you want to delete this event?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await FirestoreManager.deleteEvent(widget.event.id!);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Event deleted successfully")),
                );
              }
            },
            icon: Icon(Icons.delete_rounded, color: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),

                image: DecorationImage(
                  image: AssetImage(getEventTypePath(widget.event.type!)),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.event.title!,
                style: TextStyle(
                  fontSize: 24,
                  color: ColorManager.primaryColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.primaryColor),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.calendar_month,
                      color: ColorManager.whiteColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy').format(eventDate),
                        style: TextStyle(color: ColorManager.primaryColor),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(eventDate),
                        style: TextStyle(color: ColorManager.blackColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.primaryColor),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.location_searching_rounded,
                      color: ColorManager.whiteColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      Text(
                        'Cairo, Egypt',
                        style: TextStyle(color: ColorManager.primaryColor),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: ColorManager.primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text('Description'),
            Text(widget.event.description!),
          ],
        ),
      ),
    );
  }

  String getEventTypePath(String type) {
    if (type == "sport") {
      return "assets/images/sport.png";
    } else if (type == "birthday") {
      return "assets/images/birthday.png";
    } else {
      return "assets/images/Book Club.png";
    }
  }
}
