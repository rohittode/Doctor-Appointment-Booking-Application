
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:mediapp/consts/consts.dart';
// import 'package:mediapp/controlers/appointment_controller.dart';
// import 'package:mediapp/controlers/auth_controller.dart';
// import 'package:mediapp/views/appointment_details_view/appointment_details_view.dart';

// class AppointmentView extends StatefulWidget {
//   final bool isDoctor;

//   const AppointmentView({Key? key, this.isDoctor = false}) : super(key: key);

//   @override
//   _AppointmentViewState createState() => _AppointmentViewState();
// }

// class _AppointmentViewState extends State<AppointmentView> {
//   late StreamSubscription _subscription;
//   late Timer _timer;
//   final AppointmentController controller = Get.put(AppointmentController());

//   @override
//   void initState() {
//     super.initState();
//     // Initialize _subscription
//     _subscription = controller.getAppointmentsStream(widget.isDoctor).listen((event) {});
//     // Set up a periodic timer to refresh every 2 seconds
//     _timer = Timer.periodic(Duration(seconds: 2), (timer) {
//       // Fetch updated data from Firestore
//       controller.getAppointmentsStream(widget.isDoctor);
//     });
//   }

//   @override
//   void dispose() {
//     // Cancel the timer and subscription when the widget is disposed
//     _timer.cancel();
//     _subscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryColor,
//         title: Text(
//           "Booked Appointments",
//           style: TextStyle(
//             color: AppColors.whiteColor,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               AuthController().signout();
//             },
//             icon: Icon(
//               Icons.power_settings_new_rounded,
//               color: AppColors.whiteColor,
//             ),
//           )
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: controller.getAppointmentsStream(widget.isDoctor),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             var data = snapshot.data!.docs;
//             return Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Card(
//                     elevation: 3,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       onTap: () {
//                         Get.to(() => AppointmentDetailsView(
//                           doc: data[index],
//                         ));
//                       },
//                       leading: CircleAvatar(
//                         backgroundImage: AssetImage(AppAssets.imgDoctor),
//                       ),
//                       title: AppStyles.bold(
//                         title: data[index][!widget.isDoctor ? 'appWithName' : 'appName'],
//                       ),
//                       subtitle: Text(
//                         "${data[index]['appDay']} - ${data[index]['appTime']}",
//                         style: TextStyle(
//                           color: AppColors.textColor.withOpacity(0.5),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
