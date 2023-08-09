import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/appstyle.dart';
import 'package:to_do_riverpod/common/widgets/hieghtspacer.dart';
import 'package:to_do_riverpod/common/widgets/reusable_text.dart';
import 'package:to_do_riverpod/features/auth/controllers/auth_controller.dart';

class OtpPage extends ConsumerWidget{
  const OtpPage({super.key, required this.smsCodeId, required this.phone});
  final String smsCodeId;
  final String phone;

void verifyOtpCode(
  BuildContext context,WidgetRef ref, String smsCode){
    ref.read(authControllerProvider).verifyOtpCode(context: context,
    smsCodeId:smsCodeId,
    smsCode:smsCode,
    mounted: true);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
    ),
    body: SafeArea(child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ 
          HieghtSpacer(
            hieght: AppConst.kheight*0.15),
          Padding(
            padding:EdgeInsets.symmetric(horizontal:30.w ),
          child: Image.asset('assets/todo.png',
          width: AppConst.kWidth*0.5,),),

          const HieghtSpacer(hieght: 26),
          ReusableText(text: 'Enter Your OTP', 
          style: appstyle(20, AppConst.kLight, FontWeight.bold)),
           const HieghtSpacer(hieght: 26),
          Pinput(
            length: 6,
            showCursor: true,
            onCompleted: (value){
              if(value.length==6){
                return verifyOtpCode(context, ref, value);
              }
            },
            onSubmitted: (value){
              if(value.length==6){
                return verifyOtpCode(context, ref, value);
              }
            },
          ),
         ],
      ),
    )),

   );
  }

}