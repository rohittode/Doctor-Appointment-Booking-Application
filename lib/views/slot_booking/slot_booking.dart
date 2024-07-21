import 'package:flutter/material.dart';


class Booking extends StatefulWidget {
  Booking({Key? key}) : super(key: key);

  final List<String> timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    var timeSlots;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Time Slot'),
      ),
      body: ListView.builder(
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          final slot = timeSlots[index];
          return ListTile(
            title: Text(slot),
            onTap: () {
              Navigator.pop(context, slot);
            },
          );
        },
      ),
    );

  }
}
