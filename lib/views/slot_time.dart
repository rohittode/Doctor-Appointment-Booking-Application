// import 'package:flutter/material.dart';

// class SlotTimeView extends StatefulWidget {
//   final void Function(String) onSlotSelected;

//   SlotTimeView({required this.onSlotSelected});

//   @override
//   _SlotTimeViewState createState() => _SlotTimeViewState();
// }

// class _SlotTimeViewState extends State<SlotTimeView> {
//   String? selectedTime; // Nullable String to avoid initialization issues

//   // Function to generate time slots
//   List<String> generateTimeSlots() {
//     List<String> slots = [];
//     slots.addAll(_generateTimeSlots(10, 18)); // Adjusted endHour to 19 (7 PM)
//     return slots;
//   }

//   // Helper function to generate time slots in 15-minute intervals
//   List<String> _generateTimeSlots(int startHour, int endHour) {
//     List<String> slots = [];
//     for (int hour = startHour; hour <= endHour; hour++) {
//       for (int minute = 0; minute < 60; minute += 15) {
//         slots.add(_formatTime(hour, minute));
//       }
//     }
//     return slots;
//   }

//   // Helper function to format time
//   String _formatTime(int hour, int minute) {
//     TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);
//     return timeOfDay.format(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<String> timeSlots = generateTimeSlots();

//     return GridView.count(
//       crossAxisCount: 5, // Number of slots per row
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       children: timeSlots.map((timeSlot) {
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedTime = timeSlot;
//             });
//             widget.onSlotSelected(timeSlot); // Call callback with selected time
//           },
//           child: Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: selectedTime == timeSlot
//                     ? Colors.blue // Highlight selected time
//                     : Colors.grey.shade300,
//                 width: 2,
//               ),
//               borderRadius: BorderRadius.circular(8),
//               color: selectedTime == timeSlot
//                   ? Colors.blue.withOpacity(0.2) // Highlight background for selected time
//                   : Colors.transparent,
//             ),
//             child: Center(
//               child: Text(
//                 timeSlot,
//                 style: TextStyle(
//                   fontSize: 14, // Adjusted font size for smaller slots
//                   color: selectedTime == timeSlot
//                       ? Colors.blue // Highlight selected time
//                       : Colors.black,
//                   fontWeight: selectedTime == timeSlot
//                       ? FontWeight.bold // Bold text for selected time
//                       : FontWeight.normal,
//                 ),
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

// class TimeSelectionPage extends StatefulWidget {
//   @override
//   _TimeSelectionPageState createState() => _TimeSelectionPageState();
// }

// class _TimeSelectionPageState extends State<TimeSelectionPage> {
//   String? selectedTime;

//   void _onSlotSelected(String timeSlot) {
//     setState(() {
//       selectedTime = timeSlot;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Appointment Time'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Available Time Slots',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: SlotTimeView(
//                 onSlotSelected: _onSlotSelected,
//               ),
//             ),
//             SizedBox(height: 20),
//             if (selectedTime != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: TextFormField(
//                   initialValue: selectedTime,
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     labelText: 'Selected Time',
//                     border: OutlineInputBorder(),
//                     fillColor: Colors.grey.shade200,
//                     filled: true,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
