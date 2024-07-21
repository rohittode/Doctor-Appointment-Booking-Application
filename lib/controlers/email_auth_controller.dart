import 'package:email_auth/email_auth.dart';
import 'package:get/get.dart';


class EmailAuthController extends GetxController {
  EmailAuth emailAuth = EmailAuth(sessionName: "Mediapp Session");
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  var status = "".obs;
  
//   get emailAuthController => null;


// // Assuming you have a function to configure the email authentication module in your EmailAuthController class
// void configureProductionServer() {
//   var productionServerConfig = {
//     "server": "production_server_url",
//     "serverKey": "production_server_key"
//   };
//   emailAuthController.config(productionServerConfig);
// }



  void sendOTP(String email) async {
    var res =
        await emailAuth.sendOtp(recipientMail: email.trim(), otpLength: 5);
    if (res) {
      Get.snackbar(
        "Otp Sent",
       "Check your email",
      );

      // status.value = "OTP Sent";
      //  VxToast.show(context, msg: "Fill all the details!");
    } else {
      // status.value = "OTP Not Sent";
      Get.snackbar(
        "Otp Not Sent",
       "Please Retry"
      );
    }
  }
/*
  void validateOTP(String email, String otp) async {
    var res = emailAuth.validateOtp(recipientMail: email.trim(), userOtp: otp);
    if (res) {
      Get.snackbar(
        "Otp Verified",
        "SignUp to continue",
       
      );
      status.value = "OTP Verified";
    } else {
      Get.snackbar(
        "Otp Not Verified",
        "Please "
       
      );
      // status.value = "OTP Not Verified";
    }
  }
*/
Future<bool> validateOTP(String email, String otp) async {
  bool res = await emailAuth.validateOtp(recipientMail: email.trim(), userOtp: otp);
  if (res) {
    Get.snackbar(
      "Otp Verified",
      "SignUp to continue",
    );
    status.value = "OTP Verified";
  } else {
    Get.snackbar(
      "Otp Not Verified",
      "Please try again",
    );
    // status.value = "OTP Not Verified";
  }
  return res;
}


}
