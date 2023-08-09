

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/appstyle.dart';
import 'package:to_do_riverpod/common/widgets/hieghtspacer.dart';
import 'package:to_do_riverpod/common/widgets/reusable_text.dart';
import 'package:to_do_riverpod/common/widgets/widthspacer.dart';


class NotificationsPage extends StatelessWidget{
  const NotificationsPage ({super.key, this.payload});
  
final String? payload;

  @override
  Widget build(BuildContext context) {
    var title = payload!.split('|')[0];
    var desc = payload!.split('|')[1];
    var date = payload!.split('|')[2];
    var start = payload!.split('|')[3];
    var finish = payload!.split('|')[4];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body:SafeArea(
        child:Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: Container(
                width: AppConst.kWidth,
                height: AppConst.kheight*0.7,
                decoration: BoxDecoration(
                  color: AppConst.kLight,
                  borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius))
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(text: 'Reminder',
                       style: appstyle(40, AppConst.kBkDark, FontWeight.bold)),

                       HieghtSpacer(hieght: 05),

                       Container(
                        width: AppConst.kWidth,
                        padding: EdgeInsets.only( left: 05),
                        decoration: BoxDecoration(
                          color: AppConst.kYellow,
                          borderRadius: BorderRadius.all(Radius.circular(9.h)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReusableText(text: 'Today',
                       style: appstyle(14, 
                       AppConst.kBkDark, 
                       FontWeight.bold)),
                       const WidthSpacer(wydth:15),

                       ReusableText(text: 'From: $start  To: $finish',
                       style: appstyle(15, 
                       AppConst.kBkDark, 
                       FontWeight.w600)),


                          ],
                        ),
                       ),
                       HieghtSpacer(hieght: 10),

                       ReusableText(text: title,
                       style: appstyle(30, 
                       AppConst.kBkDark, 
                       FontWeight.bold)),

                       HieghtSpacer(hieght: 10),
                       Text(desc,
                       maxLines: 8,
                       textAlign: TextAlign.justify,
                       style: appstyle(16, 
                       AppConst.kLight, 
                       FontWeight.normal)),

                       
                    ],
                  ),
                  ),

              ),
              ),
              Positioned(
                right: 12.w, top: -10,
                child:Image.asset('assets/bell.png',
              width: 70.w,height: 70.h,)),


              Positioned(
                bottom: -AppConst.kheight*0.142,
                left:0,right:0,
                child:Image.asset('assets/notification.png',
              width: AppConst.kWidth*0.8,
              height: AppConst.kheight*0.6,)),
          
          ],

        )) ,
    );
  }

}