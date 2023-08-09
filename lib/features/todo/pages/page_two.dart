import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/custom_otn_btn.dart';

import '../../../common/widgets/hieghtspacer.dart';
import '../../auth/pages/login_page.dart';
class PageTwo extends StatelessWidget {
  const PageTwo({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.kheight,
      width: AppConst.kWidth,
      color: AppConst.kLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal:30.w),
            child: Image.asset('assets/todo.png'),
            ),
            const HieghtSpacer(hieght: 50),
            CustomOtnBtn(
              onTap: (){
                Navigator.pushReplacement(context,
                 MaterialPageRoute(builder: (context)=>const LoginPage()));
              },

              width:AppConst.kWidth*0.9, 
              height: AppConst.kheight*0.06, 
              color: AppConst.kBkDark,
              text: 'Login with a phone number',
            ),
        ],
      ),
    );
  }

}
