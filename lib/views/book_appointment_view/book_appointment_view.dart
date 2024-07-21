import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/controlers/appointment_controller.dart';
import 'package:mediapp/controlers/settings_controller.dart';
import 'package:mediapp/res/components/custom_button.dart';
import 'package:mediapp/views/payment_view.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class BookAppointmentView extends StatefulWidget {
  final String docId;
  final String docName;

  const BookAppointmentView({
    Key? key,
    required this.docId,
    required this.docName,
  }) : super(key: key);

  @override
  _BookAppointmentViewState createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  var controller = Get.put(AppointmentController());
  late List<String> timeSlots;

  @override
  void initState() {
    super.initState();
    timeSlots = generateTimeSlots();
  }

  List<String> generateTimeSlots() {
    List<String> slots = [];
    for (int i = 10; i <= 18; i++) {
      String hour =
          i > 12 ? (i - 12).toString().padLeft(2, '0') : i.toString().padLeft(2, '0');
      slots.add('$hour:00 ${i > 12 ? 'PM' : 'AM'}');
      slots.add('$hour:15 ${i > 12 ? 'PM' : 'AM'}');
    }
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.docName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select appointment day",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  DateTime tomorrow = DateTime.now().add(Duration(days: 1)); // Get tomorrow's date
                  var pickedDate = await showDatePicker(
                    context: context,
                    initialDate: tomorrow,
                    firstDate: tomorrow,
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      controller.appDayController.text =
                          '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.appDayController.text.isEmpty
                            ? "Select day"
                            : controller.appDayController.text,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Select appointment time",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.appTimeController.text = timeSlots[index];
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue.withOpacity(0.5),
                      ),
                      child: Text(
                        timeSlots[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: controller.appTimeController.text == timeSlots[index]
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // const Text(
              //   "Mobile Number",
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 10),

              const Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: AppStrings.fullname,
                  labelText: "Name",
                  border: const OutlineInputBorder(),
                ),
                controller: controller.appNameController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Name cannot contain numbers';
                  }
                  if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                    return 'Name cannot contain special characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const Text(
                "Problem",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter your problem",
                ),
                controller: controller.appMessageController,
                readOnly: false,
                maxLength: 50,
                keyboardType: TextInputType.text,
                validator: (value) {
                  return _validateMessage(value);
                },
                style: TextStyle(
                  color: _validateMessage(controller.appMessageController.text) != null
                      ? Colors.red
                      : Colors.black,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        
                        Get.to(() => PaymentScreen());
                      
                      },
                      child: Text('Pay Now'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {

                         Get.snackbar(
                              "Pay at Clinic",
                              "You can pay in cash or online",
                            );
                      },
                      child: Text('Pay at Clinic'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
        //       CustomButton(
        //         buttonText: "Book an appointment",
        //         onTap: () async {
        //           if (controller.appDayController.text.isEmpty ||
        //               controller.appMessageController.text.isEmpty ||
        //               controller.appNameController.text.isEmpty ||
        //               controller.appTimeController.text.isEmpty) {
        //                 Get.snackbar(
        //   "Incomplete Information",
        //   "Please fill all the fields correctly to book an appointment.",
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        // );
                   
        //           } else {
        //             await controller.bookAppointment(
        //                 widget.docId, widget.docName, context);
        //             // Clear text fields after booking appointment
        //             controller.appDayController.clear();
        //             controller.appTimeController.clear();
        //             // controller.appMobileController.clear();
        //             controller.appNameController.clear();
        //             controller.appMessageController.clear();
        //           }
        //         },
        //       ),
        CustomButton(
  buttonText: "Book an appointment",
  onTap: () async {
    if (controller.appDayController.text.isEmpty ||
        controller.appMessageController.text.isEmpty ||
        controller.appNameController.text.isEmpty ||
        controller.appTimeController.text.isEmpty) {
      Get.snackbar(
        "Incomplete Information",
        "Please fill all the fields correctly to book an appointment.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      await controller.bookAppointment(
          widget.docId, widget.docName, context);
      
      // Send email confirmation
      // final Email email = Email(
      //   body: 'Dear ${controller.appNameController.text},\n\n'
      //         'Your appointment with ${widget.docName} on '
      //         '${controller.appDayController.text} at '
      //         '${controller.appTimeController.text} has been successfully booked.\n\n'
      //         'Thank you!',
      //   subject: 'Appointment Confirmation',
      //   recipients: [SettingsController().email.value],
      //   isHTML: false,
      // );

      // await FlutterEmailSender.send(email);

      // Clear text fields after booking appointment
      controller.appDayController.clear();
      controller.appTimeController.clear();
      controller.appNameController.clear();
      controller.appMessageController.clear();
    }
  },
)
            ],
          ),
        ),
      ),
    );
  }

  String? _validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your message';
    }
    // Regular expression to allow only letters and numbers
    RegExp messageRegExp = RegExp(r'^[a-zA-Z0-9 ]{1,50}$');
    if (!messageRegExp.hasMatch(value)) {
      return 'Message should not contain Special Characters';
    }
    return null;
  }
}
