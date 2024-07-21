import 'package:flutter/material.dart';
import 'package:mediapp/consts/colors.dart';

class CustomTextFeild extends StatefulWidget {
  final String hint;
  final TextEditingController? textController;
  final Color textColor;
  final Color borderColor;
  const CustomTextFeild(
      {super.key,
      required this.hint,
      this.textController,
      this.textColor = Colors.black,
      this.borderColor = Colors.black, String? Function(dynamic value)? 
      validator, bool? obscureText,
        TextEditingController? controller,
        String? errorText,
        Null Function(dynamic value)? onChanged,
        IconData? prefixIcon,
        IconData? icon,  Color? iconColor,  Null Function()? onIconTap,  bool? readOnly,
        });

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      cursorColor: AppColors.blueColor,
      decoration: InputDecoration(
        isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: widget.borderColor,
          )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor
              )),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor
              )),
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: widget.textColor,
          )),
    );
  }
}
