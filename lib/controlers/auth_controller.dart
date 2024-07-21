
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/views/appointment_view/appointment_view.dart';
import 'package:mediapp/views/doc_view.dart';
import 'package:mediapp/views/home_view/home.dart';
import 'package:mediapp/views/login_view/login_view.dart';

class AuthController extends GetxController {
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var genderController = TextEditingController();
  var ageController = TextEditingController();
  var signinmobileController = TextEditingController();

  var isLoading = false.obs;

  var aboutController = TextEditingController();
  var addressController = TextEditingController();
  var servicesController = TextEditingController();
  var timingController = TextEditingController();
  var phoneController = TextEditingController();
  var categoryController = TextEditingController();

  UserCredential? userCredential;

  Future<void> isUserAlreadyLoggedIn() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user != null) {
          var data = await FirebaseFirestore.instance
              .collection('doctors')
              .doc(user.uid)
              .get();
          var isDoc = data.data()?.containsKey('docName') ?? false;

          if (isDoc) {
            Get.offAll(() =>  const DocView());
          } else {
            Get.offAll(() => const Home());
          }
        } else {
          Get.offAll(() => const LoginView());
        }
      });
    } catch (e) {
      await showErrorDialog(e.toString());
    }
  }

  // Future<void> loginUser(
  //     {required String email, required String password}) async {
  //   try {
  //     userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text, password: passwordController.text);
  //   } catch (e) {
  //     print("Error");
  //   }
  // }

   Future<void> loginUser({required String email, required String password}) async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      userCredential = null;
      rethrow;
    }
  }

  Future<void> signupUser(bool isDoctor) async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      if (userCredential != null) {
        await storeUserData(userCredential!.user!.uid, fullnameController.text,
            emailController.text, passwordController.text, isDoctor);
      }
    } catch (e) {
      await showErrorDialog(e.toString());
    }
  }

  Future<void> storeUserData(String uid, String fullname, String email,
      String pass, bool isDoctor) async {
    try {
      var store = FirebaseFirestore.instance
          .collection(isDoctor ? 'doctors' : 'users')
          .doc(uid);
      if (isDoctor) {
        await store.set({
          'docAbout': aboutController.text,
          'docAddress': addressController.text,
          'docCategory': categoryController.text,
          'docName': fullname,
          'docPhone': phoneController.text,
          'docService': servicesController.text,
          'docTiming': timingController.text,
          'docId': FirebaseAuth.instance.currentUser?.uid,
          'docRating': 3,
          'docEmail': email,
          'pass': passwordController.text,
        });
      } else {
        await store.set({
          'fullname': fullname,
          'email': email,
          'password': pass,
          'gender' : genderController.text,
          'age' : ageController.text,
          'phn' : signinmobileController.text,
            });
      }
    } catch (e) {
      await showErrorDialog(e.toString());
    }
  }

  Future<void> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      await showErrorDialog(e.toString());
    }
  }

  Future<void> showErrorDialog(String errorMessage) async {
    await Get.defaultDialog(
      title: "Error",
      middleText: errorMessage,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  getCurrentUserId() {}
}
