import 'package:flutter/material.dart';
import 'api.dart';
import 'event.dart';

class AllEvents extends StatefulWidget{
  final bool handleInvisible;

  const AllEvents({super.key, required this.handleInvisible});

  @override
  State<AllEvents> createState() => _AllEventsState(handleInvisibleEvents: this.handleInvisible);
}

class _AllEventsState extends State<AllEvents>{
  bool handleInvisibleEvents;
  List<dynamic> events = <dynamic>[];

  _AllEventsState({required this.handleInvisibleEvents}){
    _getEvents();
  }

  _getEvents() async{
    List<dynamic> gottenEvents;
    Map<String, dynamic> result = await fetchEvents();
    if(result["events"] != null){
      gottenEvents = result["events"];

      setState(() {
        events = gottenEvents;
      });
    }
  }


  Widget _eventList(BuildContext){
    List<EventView> views = <EventView>[];

    for(dynamic e in events){
      Map<String, dynamic> event = e as Map<String, dynamic>;

      EventView ev = new EventView(event: event);

      views.add(ev);
    }

    return Column(
        children: views
    );

  }


  @override
  Widget build(BuildContext context){
    return Container(
      child: _eventList(context),
    );
  }
}