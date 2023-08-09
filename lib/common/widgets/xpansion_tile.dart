import 'package:flutter/material.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/titles.dart';

class XpansionTile extends StatelessWidget{
  const XpansionTile({super.key, required this.text1, required this.text2, this.trailing, required this.children, 
  this.onExpansionChanged,
  });

  final String text1;
  final String text2;
  final Widget? trailing;
  final List<Widget>children;
  final void Function(bool)?onExpansionChanged;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConst.kLight,
        borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius),)
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent
        ), 
        child: ExpansionTile(title: BottomTitles(
          text1: text1, 
          text2: text2),
          
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          onExpansionChanged: onExpansionChanged,
          controlAffinity: ListTileControlAffinity.trailing,
          trailing: trailing,
          children: children,

          ),
          
          
          
          ),
    );
  }
}