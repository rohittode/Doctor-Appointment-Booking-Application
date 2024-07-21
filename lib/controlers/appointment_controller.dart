import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/controlers/auth_controller.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;

  var appDayController = TextEditingController();
  var appTimeController = TextEditingController();
  var appMobileController = TextEditingController();
  var appNameController = TextEditingController();
  var appMessageController = TextEditingController();

  // get selectedTime => null;

  // get times => null;

  // get selectedDay => null;

  // get days => null;

  bookAppointment(String docId, String docName, context) async {
    isLoading(true);

    var store = FirebaseFirestore.instance.collection('appointments').doc();
    // var docName;
    await store.set({
      'appBy': FirebaseAuth.instance.currentUser?.uid,
      'appDay': appDayController.text,
      'appTime': appTimeController.text,
      'appMobile': appMobileController.text,
      'appName': appNameController.text,
      'appMsg': appMessageController.text,
      'appWith': docId,
      'appWithName': docName,
    });
    isLoading(false);

    VxToast.show(context, msg: "Appointment has booked successfully!");
    Get.back();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAppointmentsStream(
      bool isDoctor) {
    if (isDoctor) {
      return FirebaseFirestore.instance
          .collection('appointments')
          .where('appWith', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('appointments')
          .where('appBy', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots();
    }
  }

 
  // Future<QuerySnapshot> getAppointmentsFuture(bool isDoctor) async {
  //   CollectionReference appointments = FirebaseFirestore.instance.collection('appointments');
  //   String userUid = AuthController().getCurrentUserId();
  //   print("Fetching appointments for user UID: $userUid");

  //   QuerySnapshot querySnapshot;
  //   if (isDoctor) {
  //     print("Fetching appointments for doctor UID: $userUid");
  //     querySnapshot = await appointments.where('doctorUid', isEqualTo: userUid).get();
  //   } else {
  //     print("Fetching appointments for patient UID: $userUid");
  //     querySnapshot = await appointments.where('patientUid', isEqualTo: userUid).get();
  //   }
  //   print("Query completed with ${querySnapshot.docs.length} documents found.");
  //   return querySnapshot;
  // }
}


