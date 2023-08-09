import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/appstyle.dart';
import 'package:to_do_riverpod/common/widgets/hieghtspacer.dart';
import 'package:to_do_riverpod/common/widgets/reusable_text.dart';
import 'package:to_do_riverpod/common/widgets/widthspacer.dart';

class TodoTile extends StatelessWidget{
 const TodoTile({super.key, 
 this.color, this.title, this.description, this.start, this.end, this.editWidget, this.delete, this.switcher });
 final Color?color;
 final String? title;
 final String? description;
 final String? start;
 final String? end;
 final Widget? editWidget;
 final  void Function()? delete;
 final Widget? switcher;



  @override
  Widget build(BuildContext context) {
   return Padding(
    padding: EdgeInsets.only(bottom:8.h),
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8.h),
          width: AppConst.kWidth,
          decoration: BoxDecoration(
            color: AppConst.kBkDark,
            borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: 
                    BorderRadius.all(Radius.circular(AppConst.kRadius),),
                    //TODO: ADD DYNAMIC COLORS
                    color: color?? AppConst.kred,
                  ),
                  ),

                  WidthSpacer(wydth: 15),

                  Padding(padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: AppConst.kWidth*0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(text: title??"Title of Todo", 
                        style: appstyle(18, AppConst.kLight, FontWeight.bold),),

                        HieghtSpacer(hieght: 3),
                        ReusableText(text: description??"Description of Todo", 
                        style: appstyle(12, AppConst.kLight, FontWeight.bold),),
                      
                       const HieghtSpacer(hieght: 10),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: AppConst.kWidth*0.3,
                            height:25.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.3,
                                color: AppConst.kGreyDk,
                                ),
                                borderRadius: 
                                BorderRadius.all(Radius.circular(AppConst.kRadius),
                                ),
                                color: AppConst.kLight,
                            ),
                            child: Center(
                            child: ReusableText(
                              text: "$start | $end",
                               style: appstyle(12, AppConst.kBlueLight, FontWeight.normal),),
                               ),
                          ),

                          WidthSpacer(wydth: 20),
                          Row(
                            children: [
                              SizedBox(
                                child:editWidget ,
                              ),

                              WidthSpacer(wydth: 10),
                              GestureDetector(
                                onTap:delete,
                                child:
                                  const Icon(MaterialCommunityIcons.delete_circle),
                              )

                            ],
                          )
                        ],

                       )
                      ],
                    ),
                  ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom:0.h),
                child: switcher,
              )
              
            ],
          ),
        )
      ],
    ),
   );
  }

}