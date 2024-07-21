import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediapp/consts/colors.dart';
import 'package:mediapp/controlers/auth_controller.dart';
import 'package:intl/intl.dart';

import 'package:mediapp/views/appointment_details_view/appointment_details_view.dart'; // Import the details view

class AppointmentView extends StatefulWidget {
  const AppointmentView({Key? key}) : super(key: key);

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Booked Appointments",
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("appointments")
            .where("appBy", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              var data = snapshot.data!.docs;
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var appointment = snapshot.data!.docs[index];
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                        ),
                        title: Text(
                          "${appointment['appWithName']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          "${appointment['appDay']} - ${appointment['appTime']}",
                          style: TextStyle(
                            color: AppColors.textColor.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentDetailsView(
                                doc: data[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text("No appointments found"));
              }
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error.toString()}"));
            } else {
              return Center(child: Text("No data found"));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
