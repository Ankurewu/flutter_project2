import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/appstyle.dart';
import 'package:to_do_riverpod/common/widgets/hieghtspacer.dart';
import 'package:to_do_riverpod/common/widgets/reusable_text.dart';
class PageOne extends StatelessWidget {
  const PageOne({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.kheight,
      width: AppConst.kWidth,
      color: AppConst.kGreyDk,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: 
            EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset('assets/todo.png'),
            ),
            const HieghtSpacer(hieght: 100),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusableText(
                  text: 'ToDO With RiverPod', 
                style: appstyle(30, AppConst.kLight, FontWeight.w600),
                ),

               const HieghtSpacer(hieght:10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: 
                  Text('Welcome! Do you want to create a task fast and with ease',
                  textAlign: TextAlign.center,
                  style: appstyle(16, AppConst.kGreyLight, FontWeight.normal),
                  ),
                  )
              ],

            )

        ],
      ),
    );
  }

}
