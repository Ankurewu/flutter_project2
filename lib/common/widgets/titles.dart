import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/appstyle.dart';
import 'package:to_do_riverpod/common/widgets/hieghtspacer.dart';
import 'package:to_do_riverpod/common/widgets/reusable_text.dart';
import 'package:to_do_riverpod/common/widgets/widthspacer.dart';
import 'package:to_do_riverpod/features/todo/controllers/todo_provider.dart';

class BottomTitles extends StatelessWidget{
  const BottomTitles({super.key, required this.text1, required this.text2, this.clr});

  final String text1;
  final String text2;
  final Color? clr;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kWidth,
      child: Padding(
        padding:const EdgeInsets.all(8),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (context,ref,child){
                var color= ref.read(todoStateProvider.notifier)
                .getRandomColor();
                return Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: 
                    BorderRadius.all(Radius.circular(AppConst.kRadius),),
  
                    color: color,
                  ),
                );
              },
              ),

              WidthSpacer(wydth: 15),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(text: text1,
                    style: appstyle(24, AppConst.kBkDark, FontWeight.bold)),

                    HieghtSpacer(hieght: 10),
                    ReusableText(text: text2,
                    style: appstyle(12, AppConst.kBkDark, FontWeight.normal)),

                  ],
                ),)

          ],
        ) ),
    );
  }
}