import 'package:flutter/material.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to the Medi-App!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please read these terms and conditions carefully before using the app.',
              ),
              SizedBox(height: 20),
              Text(
                '1. Acceptance of Terms',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'By downloading, installing, or using the Medi-App, you agree to be bound by these terms and conditions.',
              ),
              SizedBox(height: 20),
              Text(
                '2. Use of Android Mobile Services',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The Medi App utilizes Android Mobile Services  to provide various features. By using this app, you agree to comply with Huawei\'s Terms of Service and Privacy Policy.',
              ),
              SizedBox(height: 20),
              Text(
                '3. User Conduct',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'You agree not to engage in any activity that may interfere with the proper functioning of the app or HMS. This includes but is not limited to unauthorized access, distribution of harmful code, or violation of any laws.',
              ),
              SizedBox(height: 20),
              Text(
                '4. Disclaimer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The HMS App is provided "as is" without any warranties, express or implied. We do not guarantee the accuracy, reliability, or suitability of the app for any purpose.',
              ),
              SizedBox(height: 20),
              Text(
                '5. Changes to Terms',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We reserve the right to modify or update these terms and conditions at any time. It is your responsibility to review this document periodically for changes.',
              ),
              SizedBox(height: 20),
              Text(
                'By using the HMS App, you acknowledge that you have read, understood, and agree to these terms and conditions.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
