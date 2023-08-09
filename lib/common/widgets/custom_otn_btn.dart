import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_riverpod/common/widgets/appstyle.dart';
import 'package:to_do_riverpod/common/widgets/reusable_text.dart';

class CustomOtnBtn extends StatelessWidget {
  const CustomOtnBtn({super.key,this.onTap, 
  required this.width, required this.height, 
  required this.text, required this.color, this.color2});
  
  final void Function()? onTap;
  final double width;
  final double height;
  final String text;
  final Color color;
  final Color? color2;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          borderRadius: BorderRadius.all(Radius.circular(12),
           ),
           border: Border.all(width: 1,color: Colors.black12),
        ),
        child: Center(
          child: ReusableText(
            text: text, 
            style: appstyle(18, color, FontWeight.bold)),
        ),
      ));
  }
}