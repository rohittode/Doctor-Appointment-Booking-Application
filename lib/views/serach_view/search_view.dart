import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/views/doctor_profile_view/doctor_profile_view.dart';

class SearchView extends StatelessWidget {
  final String searchQuery;
  const SearchView({Key? key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
          title: "Searched Results",
          color: AppColors.textColor,
          size: AppSizes.size18,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('doctors').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Filtered list of documents based on search query
          List<DocumentSnapshot> filteredDocs = snapshot.data!.docs.where((doc) {
            String docName = doc['docName'].toString().toLowerCase();
            return docName.contains(searchQuery.toLowerCase());
          }).toList();

          if (filteredDocs.isEmpty) {
            return Center(
              child: Text('No doctors found matching "$searchQuery"'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 200,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filteredDocs.length,
              itemBuilder: (BuildContext context, int index) {
                var doc = filteredDocs[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => DoctorProfileView(doc: doc));
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppColors.bgDarkColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 200,
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          color: AppColors.blueColor,
                          child: Image.asset(
                            AppAssets.imgDoctor,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            doc['docName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
