import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/consts/list.dart';
import 'package:mediapp/controlers/home_controller.dart';
import 'package:mediapp/res/components/custom_textfeild.dart';
import 'package:mediapp/views/category_details_view/category_details_view.dart';
import 'package:mediapp/views/doctor_profile_view/doctor_profile_view.dart';
import 'package:mediapp/views/serach_view/search_view.dart';
import 'package:mediapp/views/viewall.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        elevation: 0.0,
        title: AppStyles.bold(
          title: "Welcome User",
          color: AppColors.whiteColor,
          size: AppSizes.size22,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                color: AppColors.blueColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextFeild(
                        textController: controller.searchQueryController,
                        hint: AppStrings.search,
                        borderColor: AppColors.whiteColor,
                        textColor: AppColors.whiteColor,
                      ),
                    ),
                    10.widthBox,
                    IconButton(
                      onPressed: () {
                        Get.to(() => SearchView(
                              searchQuery: controller.searchQueryController.text,
                            ));
                      },
                      icon: Icon(
                        Icons.search,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              20.heightBox,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (index) => GestureDetector(
                      onTap: () {
                        Get.to(() => CategoryDetailsView(
                              catName: iconsTitleList[index],
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              iconsList[index],
                              width: 30,
                              color: AppColors.whiteColor,
                            ),
                            5.heightBox,
                            AppStyles.normal(
                              title: iconsTitleList[index],
                              color: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              20.heightBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppStyles.bold(                    
                    title: "Popular Doctors",
                    color: AppColors.blueColor,
                    size: AppSizes.size20,
                  ),
                  SizedBox(
                    height: 150,
                    child: FutureBuilder<QuerySnapshot>(
                      future: controller.getDoctorList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              "No doctors available",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 16,
                              ),
                            ),
                          );
                        } else {
                          var data = snapshot.data!.docs;
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                      () => DoctorProfileView(doc: data[index]));
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: AppColors.bgDarkColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: const EdgeInsets.only(right: 8),
                                  height: 100,
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                          AppAssets.imgDoctor,
                                        ),
                                        radius: 35,
                                      ),
                                      5.heightBox,
                                      AppStyles.normal(
                                        title: data[index]['docName'],
                                      ),
                                      AppStyles.normal(
                                        title: data[index]['docCategory'],
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              20.heightBox,
              GestureDetector(
                onTap: () async {
                  Get.to(() => ViewAllPage(doctorListFuture: FirebaseFirestore.instance.collection('doctors').get()));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppStyles.normal(
                    title: " View All     ",
                    color: AppColors.blueColor,
                  ),
                ),
              ),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.icBody,
                          width: 30,
                          color: AppColors.whiteColor,
                        ),
                        5.heightBox,
                        AppStyles.normal(
                          title: "Lab Test",
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "MediApp - Your Health Companion",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Our vision is to help mankind live healthier, longer lives by making quality healthcare accessible, affordable, and convenient.",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Made by - Rohit, Sanjana, Priyanka, Neha",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
