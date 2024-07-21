
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediapp/consts/consts.dart';

class AppointmentDetailsView extends StatelessWidget {
  final DocumentSnapshot doc;

  const AppointmentDetailsView({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Appointment Details',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: AppSizes.size20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem("Appointment Day", doc['appDay']),
              _buildDetailItem("Appointment Time", doc['appTime']),
              // _buildDetailItem("Mobile Number", doc['appMobile']),
              _buildDetailItem("Full Name", doc['appName']),
              _buildDetailItem("Problem", doc['appMsg']),
              const SizedBox(height: 30), // Add space between details and button
              _buildCancelButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _onCancelPressed(context),
        child: const Text('Cancel Appointment'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 160, 203, 239),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          textStyle: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  Future<void> _onCancelPressed(BuildContext context) async {
    bool confirm = await _showConfirmationDialog(context);
    if (confirm) {
      await _cancelAppointment();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Appointment canceled successfully")),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cancel Appointment"),
          content: const Text("Are you sure you want to cancel this appointment?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ).then((value) => value ?? false); // Handle null case
  }

  Future<void> _cancelAppointment() async {
    await doc.reference.delete();
  }
}
