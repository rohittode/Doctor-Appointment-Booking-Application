import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/consts/list.dart';
import 'package:mediapp/controlers/auth_controller.dart';
import 'package:mediapp/controlers/settings_controller.dart';
import 'package:mediapp/views/Forgot_password_view/Forgot_password.dart';
import 'package:mediapp/views/login_view/login_view.dart';
import 'package:mediapp/views/term_condition_view/term_condition_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          AppStrings.settings,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: AppSizes.size20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showUserDetailsDialog(context, controller);
            },
            icon: Icon(
              Icons.person,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                        child: Image.asset(
                          AppAssets.imgDoctor,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.username.value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: AppSizes.size18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.email.value,
                            style: TextStyle(
                              color: AppColors.textColor.withOpacity(0.7),
                              fontSize: AppSizes.size16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: settingsList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          try {
                            if (index == 0) {
                              Get.to(() => ForgotPasswordPage());
                            }
                            if (index == 1) {
                              Get.to(() => TermsAndConditionsView());
                            }
                            if (index == 2) {
                              AuthController().signout();
                              VxToast.show(context, msg: "Logged Out!");
                              Get.offAll(() => const LoginView());
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: ${e.toString()}'),
                                action: SnackBarAction(
                                  label: 'Retry',
                                  onPressed: () {
                                    // Retry logic here
                                  },
                                ),
                              ),
                            );
                          }
                        },
                        leading: Icon(
                          settingsListIcon[index],
                          color: AppColors.blueColor,
                        ),
                        title: Text(
                          settingsList[index],
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: AppSizes.size18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _showUserDetailsDialog(BuildContext context, SettingsController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 16,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfoCard(
                  context,
                  icon: Icons.person,
                  label: 'Name',
                  value: controller.username.value,
                ),
                _buildUserInfoCard(
                  context,
                  icon: Icons.cake,
                  label: 'Age',
                  value: controller.age.value,
                ),
                _buildUserInfoCard(
                  context,
                  icon: Icons.transgender,
                  label: 'Gender',
                  value: controller.gender.value,
                ),
                _buildUserInfoCard(
                  context,
                  icon: Icons.phone,
                  label: 'Phone',
                  value: controller.phn.value,
                ),
                _buildUserInfoCard(
                  context,
                  icon: Icons.email,
                  label: 'Email',
                  value: controller.email.value,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfoCard(BuildContext context,
      {required IconData icon, required String label, required String value}) {
    return Card(
      color: Theme.of(context).primaryColorLight,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }
}
