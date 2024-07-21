import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    getData = getUserData(); // Assigning the Future to getData
    super.onInit();
  }

  var isLoading = true.obs; // Initially set to true
  var currentUser = FirebaseAuth.instance.currentUser;
  var username = ''.obs;
  var email = ''.obs;
  var age = ''.obs;
  var gender = ''.obs;
  var phn = ''.obs;

  Future<void>? getData; // Change Future? to Future<void>?

  Future<void> getUserData() async {
    try {
      isLoading(true); // Set loading to true initially
      DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      var userData = user.data();
      username.value = userData!['fullname'] ?? "";
      email.value = currentUser!.email ?? "";
      age.value = userData['age'] ?? ""; // Assuming 'age' is a field in Firestore
      gender.value = userData['gender'] ?? ""; // Assuming 'gender' is a field in Firestore
      phn.value = userData['phn'] ?? ""; // Assuming 'phn' is a field in Firestore
    } catch (e) {
      print("Error fetching user data: $e");
      // Handle error if needed
    } finally {
      isLoading(false); // Set loading to false after data retrieval
    }
  }
}
