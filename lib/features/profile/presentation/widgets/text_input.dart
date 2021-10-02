import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnable;
  final String hintText;
  final IconData icon;
  final Function() onTap;
  final String? Function(String? text)? validator;
  const TextInput({Key? key, required this.controller, required this.isEnable, required this.hintText, required this.onTap, required this.icon, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        enableSuggestions: true,
        enableInteractiveSelection: true,
        validator: validator,
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        enabled: isEnable,             
        decoration: InputDecoration(
          // key: for_V2
          // hintText: hintText,
          labelText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          isDense: true,
          prefixIcon: Icon(icon, color: Colors.grey[600], size: 22.nsp),
          suffixIcon: !isEnable
              ? Icon(Icons.edit_outlined,
                  color: Colors.grey, size: 24.nsp)
              : SizedBox.shrink(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}