
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/appstyle.dart';
import 'package:to_do_riverpod/common/widgets/custom_otn_btn.dart';
import 'package:to_do_riverpod/common/widgets/custom_text.dart';
import 'package:to_do_riverpod/common/widgets/hieghtspacer.dart';
import 'package:to_do_riverpod/common/widgets/reusable_text.dart';
import 'package:to_do_riverpod/common/widgets/showDialogue.dart';
import 'package:to_do_riverpod/features/auth/controllers/auth_controller.dart';


class LoginPage extends ConsumerStatefulWidget{
  const LoginPage({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState()=> _LoginPageSate();
   
  }
  
  class _LoginPageSate extends ConsumerState<LoginPage> {
    final TextEditingController phone= TextEditingController();
    Country country = Country(
      phoneCode:'880',
      countryCode: 'BD',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Bangladesh',
       displayName: 'Bangladesh', 
       displayNameNoCountryCode: 'BD',
       e164Key: "", example: 'Bangladesh',
    );

 sendCodeToUser(){
    if(phone.text.isEmpty){
     return showAlertDialog(context: context,
       message: "Please enter your phone number");
 }else if(phone.text.length<8){
        return showAlertDialog(context: context,
            message: "Your number is too short");
 }
 else{
  print('+${country.phoneCode}${phone.text}');
  ref.read(authControllerProvider).sendSms(
    context: context,
   phone: '+${country.phoneCode}${phone.text}');
 }
 }
  @override
  Widget build (BuildContext context){
    return  Scaffold(
      body: SafeArea(
        child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child:ListView(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.all(25.w),
                child: Image.asset('assets/todo.png',width: 350,),),
                const HieghtSpacer(hieght: 30),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left:16.w),
                  child: ReusableText(text: 'Please Enter Your Phone Number', 
                  style: appstyle(17, AppConst.kLight, FontWeight.w500)),
                ),
                const HieghtSpacer(hieght:18),
                Center(
                  child: CustomTextField(
                    controller: phone,
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: (){
                          showCountryPicker(context: context,
                          countryListTheme: CountryListThemeData(
                            backgroundColor: AppConst.kGreyLight,
                            bottomSheetHeight: AppConst.kheight*0.6,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppConst.kRadius),
                              topRight: Radius.circular(AppConst.kRadius),
                            ),
                          ),
                           onSelect: (code){
                            setState(() {
                              country= code;
                            });
                            
                           });
                           
                        },
                        child: ReusableText(
                          text: '${country.flagEmoji}+ ${country.phoneCode}', 
                          style:appstyle(18,
                         AppConst.kBkDark, FontWeight.bold)),
                      ),
                       
                    ),
                    keyboardType: TextInputType.number,
                    hintText: "Enter Phone Number",
                    hintStyle: appstyle(16, AppConst.kBkDark, FontWeight.w600),

                  ),
                ),

              
                 const HieghtSpacer(hieght: 18),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomOtnBtn(
                    onTap: (){
                      sendCodeToUser();

                    },
                    width: AppConst.kWidth*0.9, 
                  height: AppConst.kheight*0.07, 
                  text:'Send Code', 
                  color: AppConst.kBkDark,
                  color2: AppConst.kLight,),
                )

            ],
          ),
          
          )),
    );
  }
  }
