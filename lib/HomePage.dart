import 'package:flutter/material.dart';
import 'package:timetable_view/timetable_view.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '時間割アプリ',
      home: TimetableScreen(),
    );
  }
}

class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('私の時間'),
      ),
      body: Timetable(),
    );
  }
}

class Timetable extends StatelessWidget {
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Timetable View Demo'),
      ),
      body: TimetableView(
        laneEventsList: _buildLaneEvents(),
        onEventTap: onEventTapCallBack,
        timetableStyle: TimetableStyle(),
        onEmptySlotTap: onTimeSlotTappedCallBack,
      ),
    );
  }

  List<LaneEvents> _buildLaneEvents() {
    return [
      LaneEvents(
        lane: Lane(name: 'Track A', laneIndex: 1),
        events: [
          TableEvent(
            title: 'An event 1',
            eventId: 11,
            startTime: TableEventTime(hour: 8, minute: 0),
            endTime: TableEventTime(hour: 10, minute: 0),
            laneIndex: 1,
          ),
          TableEvent(
            eventId: 12,
            title: 'An event 2',
            laneIndex: 1,
            startTime: TableEventTime(hour: 12, minute: 0),
            endTime: TableEventTime(hour: 13, minute: 20),
          ),
        ],
      ),
      LaneEvents(
        lane: Lane(name: 'Track B', laneIndex: 2),
        events: [
          TableEvent(
            title: 'An event 3',
            laneIndex: 2,
            eventId: 21,
            startTime: TableEventTime(hour: 10, minute: 10),
            endTime: TableEventTime(hour: 11, minute: 45),
          ),
        ],
      ),
    ];
  }

  void onEventTapCallBack(TableEvent event) {
    print(
        "Event Clicked!! LaneIndex ${event.laneIndex} Title: ${event.title} StartHour: ${event.startTime.hour} EndHour: ${event.endTime.hour}");
  }

  void onTimeSlotTappedCallBack(
      int laneIndex, TableEventTime start, TableEventTime end) {
    print(
        "Empty Slot Clicked !! LaneIndex: $laneIndex StartHour: ${start.hour} EndHour: ${end.hour}");
  }}