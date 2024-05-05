

import 'package:flutter/material.dart';
import 'constants.dart';
class EventView extends StatefulWidget{
  final Map<String, dynamic> event;

  const EventView({super.key, required this.event});

  @override
  State<EventView> createState() => _EventViewState(event: this.event);
}


class EventTypeNote extends CustomClipper<Path> {
  int radius;
  EventTypeNote({required this.radius});
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 200);
    path.lineTo(200,200);
    path.lineTo(260,0);
    path.lineTo(30, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class _EventViewState extends State<EventView>{

  Map<String, dynamic> event;

  late String eventName;
  late String eventDescription;

  _EventViewState({required this.event}){
    eventName = this.event["name"];
    eventDescription = this.event["description"];
    _testPrint();
  }

  _testPrint(){
    print(eventName);
  }

  Widget _eventType(BuildContext){
    return Row(
      children: [
        ClipPath(
          child: Container(
            width: 200,
            color: Colors.green,
          ),
          clipper: EventTypeNote(radius: 20),
        )
      ],
    );
  }

  Widget _titleLine(BuildContext context){
    return
      Padding(
        padding: padding,
        child: Row(
          children: [
            Text(
              eventName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
              ),
            )
          ],
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: radius,
        color: lightColor,
        boxShadow: [
          shadow
        ]
      ),
      child: Column(
        children: [
          _titleLine(context),
          _eventType(context)
        ],
      )
    );
  }

}