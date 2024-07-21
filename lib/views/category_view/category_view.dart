
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/consts/list.dart';
import 'package:mediapp/views/category_details_view/category_details_view.dart';
class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          AppStrings.category,
          style: TextStyle(
            fontSize: AppSizes.size22,
            color: AppColors.blueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: 220,
          ),
          itemCount: iconsList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => CategoryDetailsView(catName: iconsTitleList[index]));
              },
              child: Hero(
                tag: iconsTitleList[index],
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primaryColor.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        iconsList[index],
                        width: 80,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        iconsTitleList[index],
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: AppSizes.size16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Best specialist",
                        style: TextStyle(
                          color: AppColors.primaryColor.withOpacity(0.7),
                          fontSize: AppSizes.size12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
/*
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/consts/list.dart';
import 'package:mediapp/views/category_details_view/category_details_view.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          AppStrings.category,
          style: TextStyle(
            fontSize: AppSizes.size18,
            color: AppColors.blueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: 220,
          ),
          itemCount: iconsList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => CategoryDetailsView(catName: iconsTitleList[index]));
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.blueColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      iconsList[index],
                      width: 80,
                      color: AppColors.whiteColor,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      iconsTitleList[index],
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: AppSizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Best specialist",
                      style: TextStyle(
                        color: AppColors.whiteColor.withOpacity(0.7),
                        fontSize: AppSizes.size12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
*/