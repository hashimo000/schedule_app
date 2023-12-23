import 'package:flutter/material.dart';
import 'package:timetable_view/timetable_view.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Timetable(),
    );
  }
}


class Timetable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timetable App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimetableScreen(),
    );
  }
}

class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Timetable'),
      ),
      body: Center(
        child: TimetableGrid(),
      ),
    );
  }
}

class TimetableGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: List<TableRow>.generate(5, (rowIndex) {
        return TableRow(
          children: List<Widget>.generate(5, (columnIndex) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                color: Colors.grey.withOpacity(0.1),
                child: Center(
                  child: Text('Subject ${rowIndex + 1}-${columnIndex + 1}'),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
