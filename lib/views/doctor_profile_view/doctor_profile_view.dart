/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/res/components/custom_button.dart';
import 'package:mediapp/views/book_appointment_view/book_appointment_view.dart';

class DoctorProfileView extends StatelessWidget {
  final DocumentSnapshot doc;
  const DoctorProfileView({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        title: Text(
          "Doctor Details",
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: AppSizes.size18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                        AppAssets.imgDoctor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc['docName'],
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: AppSizes.size16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doc['docCategory'],
                            style: TextStyle(
                              color: AppColors.textColor.withOpacity(0.7),
                              fontSize: AppSizes.size14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Rating: ',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: AppSizes.size14,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.yelloColor,
                                size: 20,
                              ),
                              Text(
                                doc['docRating'].toString(),
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: AppSizes.size14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        "Phone Number",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: AppSizes.size16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        doc['docPhone'],
                        style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.7),
                          fontSize: AppSizes.size14,
                        ),
                      ),
                      trailing: Container(
                        width: 50,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.yelloColor,
                        ),
                        child: Icon(
                          Icons.phone,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "About",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: AppSizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doc['docAbout'],
                      style: TextStyle(
                        color: AppColors.textColor.withOpacity(0.7),
                        fontSize: AppSizes.size14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Address",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: AppSizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doc['docAddress'],
                      style: TextStyle(
                        color: AppColors.textColor.withOpacity(0.7),
                        fontSize: AppSizes.size14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Working Time",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: AppSizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doc['docTiming'],
                      style: TextStyle(
                        color: AppColors.textColor.withOpacity(0.7),
                        fontSize: AppSizes.size14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Services",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: AppSizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doc['docService'],
                      style: TextStyle(
                        color: AppColors.textColor.withOpacity(0.7),
                        fontSize: AppSizes.size14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          buttonText: "Book an Appointment",
          onTap: () {
            Get.to(() => BookAppointmentView(
                  docId: doc['docId'],
                  docName: doc['docName'],
                ));
          },
        ),
      ),
    );
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/res/components/custom_button.dart';
import 'package:mediapp/views/book_appointment_view/book_appointment_view.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileView extends StatelessWidget {
  final DocumentSnapshot doc;
  const DoctorProfileView({Key? key, required this.doc}) : super(key: key);

  Future<void> _launchPhoneDialer(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        title: Text(
          "Doctor Details",
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: AppSizes.size18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                        AppAssets.imgDoctor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc['docName'],
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: AppSizes.size16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doc['docCategory'],
                            style: TextStyle(
                              color: AppColors.textColor.withOpacity(0.7),
                              fontSize: AppSizes.size14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Rating: ',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: AppSizes.size14,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.yelloColor,
                                size: 20,
                              ),
                              Text(
                                doc['docRating'].toString(),
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: AppSizes.size14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        "Phone Number",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: AppSizes.size16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        doc['docPhone'],
                        style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.7),
                          fontSize: AppSizes.size14,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () => _launchPhoneDialer(doc['docPhone']),
                        child: Container(
                          width: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.yelloColor,
                          ),
                          child: Icon(
                            Icons.phone,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "About",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: AppSizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doc['docAbout'],
                      style: TextStyle(
                        color: AppColors.textColor.withOpacity(0.7),
                        fontSize: AppSizes.size14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Address",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: AppSizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doc['docAddress'],
                      style: TextStyle(
                        color: AppColors.textColor.withOpacity(0.7),
                        fontSize: AppSizes.size14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Working Time",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: AppSizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doc['docTiming'],
                      style: TextStyle(
                        color: AppColors.textColor.withOpacity(0.7),
                        fontSize: AppSizes.size14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Services",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: AppSizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      doc['docService'],
                      style: TextStyle(
                        color: AppColors.textColor.withOpacity(0.7),
                        fontSize: AppSizes.size14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          buttonText: "Book an Appointment",
          onTap: () {
            Get.to(() => BookAppointmentView(
                  docId: doc['docId'],
                  docName: doc['docName'],
                ));
          },
        ),
      ),
    );
  }
}
