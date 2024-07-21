/*
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Forgot Your Password?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Please enter your email address below and we will send you instructions on how to reset your password.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement forgot password logic here
                // You can send a reset password link to the provided email
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ForgotPasswordView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPassword(BuildContext context) async {
    String email = emailController.text.trim();

    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password reset email sent successfully"),
          duration: Duration(seconds: 2),
        ));
      } catch (e) {
        print("Error sending password reset email: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error sending password reset email"),
          duration: Duration(seconds: 2),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter your email address"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Forgot Your Password?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Please enter your email address below and we will send you instructions on how to reset your password.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                resetPassword(context);
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}

}
*/


// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      // ignore: use_build_context_synchronously
      VxToast.show(context, msg: "Password reset email sent to your email");
      Get.back();
      // Handle navigation or show a success message
    } catch (error) {
      // Handle password reset email sending error
      print(error.toString());
      // Show an error message to the user
    }
  }

  Future<void> updatePasswordInFirestore(User user, String newPassword) async {
    try {
      String userId = user.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(userId).update({'password': newPassword});
      // Password in Firestore updated successfully
      // Handle navigation or show a success message
    } catch (error) {
      // Handle Firestore update error
      print(error.toString());
      // Show an error message to the user
    }
  }

  Future<void> handlePasswordReset() async {
    String email = emailController.text;
    String newPassword = newPasswordController.text;

    try {
      // Send password reset email
      await resetPassword(email);

      // Wait for the user to reset their password using the email link

      // Get the current user after password reset
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update the password in Firestore
        await updatePasswordInFirestore(user, newPassword);
      }
    } catch (error) {
      // Handle password reset and Firestore update errors
      print(error.toString());
      // Show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Reset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            30.heightBox,
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_rounded),
                labelText: 'Enter your Email',
                border: OutlineInputBorder(borderSide: BorderSide()),
              ),
            ),
            const SizedBox(height: 16.0),
            // TextField(
            //   controller: newPasswordController,
            //   decoration: const InputDecoration(
            //     prefixIcon: Icon(Icons.key),
            //     labelText: 'Enter New Password',
            //     border: OutlineInputBorder(borderSide: BorderSide()),
            //   ),
            // ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textColor,
                shape: const StadiumBorder(),
              ),
              onPressed: () => handlePasswordReset(),
              child: const Text(
                'Reset Password',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
