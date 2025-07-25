import 'package:flutter/material.dart';
import 'package:to_do/utils/app_styles.dart';
import 'package:to_do/utils/size_config.dart';

class TitleDescription extends StatelessWidget {
  const TitleDescription({
    super.key,
    required this.title,
    required this.hintText,
    required this.maxLines,
    required this.controller,
    required this.prefixIcon,
  });

  final String title;
  final String hintText;
  final int maxLines;
  final TextEditingController controller;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.headingTextStyle.copyWith(fontSize: 18)),
        SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
