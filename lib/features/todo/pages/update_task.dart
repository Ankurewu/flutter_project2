import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/appstyle.dart';
import 'package:to_do_riverpod/common/widgets/custom_otn_btn.dart';
import 'package:to_do_riverpod/common/widgets/custom_text.dart';
import 'package:to_do_riverpod/common/widgets/hieghtspacer.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'as picker;
import 'package:to_do_riverpod/features/todo/controllers/dates/dates_provider.dart';
import 'package:to_do_riverpod/features/todo/controllers/todo_provider.dart';

class UpdateTask extends ConsumerStatefulWidget{
  const UpdateTask({super.key,required this.id,});

  final int id;
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState()=> _UpdateTaskState();
  }

  class _UpdateTaskState extends ConsumerState<UpdateTask>{
    final TextEditingController title=TextEditingController(text: titles);
    final TextEditingController desc=TextEditingController(text: descs);
  @override
Widget build(BuildContext context){
  
  var scheduledDate= ref.watch(dateStateProvider);
  var start= ref.watch(startTimeStateProvider);
   var finish= ref.watch(finishTimeStateProvider);
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView(
        children: [
          const HieghtSpacer(hieght: 20),
          CustomTextField(
            hintText: "Add Title", 
            controller: title,
            hintStyle: appstyle(16, AppConst.kGreyLight, FontWeight.w600),
            ),
            HieghtSpacer(hieght: 20.w),
            CustomTextField(
            hintText: "Add Description", 
            controller: desc,
            hintStyle: appstyle(16, AppConst.kGreyLight, FontWeight.w600),
            ),

            const HieghtSpacer(hieght: 20),

            CustomOtnBtn(//For_ChooseDate
              onTap: (){
                picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1900,1, 1),
                      maxTime: DateTime(2299, 12, 31),
                      theme: const picker.DatePickerTheme(
                          doneStyle:
                              TextStyle(color: AppConst.kGreen, 
                              fontSize: 16)),
                    onConfirm: (date) {
                      ref
                      .read(dateStateProvider.notifier)
                      .setDate(date.toString());
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
              width: AppConst.kWidth, 
              height: 52.h, 
              text:scheduledDate==""? "Set Date": scheduledDate.substring(0,10),
               color: AppConst.kLight,
              color2: Color.fromARGB(255, 10, 18, 228)),

             const HieghtSpacer(hieght: 20),

             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtnBtn(//For_StartTime
                  onTap: (){
                     picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                     onConfirm: (date) {
                      ref.read(startTimeStateProvider.notifier)
                      .setStart(date.toString());
                  }, 
                  locale: picker.LocaleType.en);
                  },
                  width: AppConst.kWidth*0.4, height: 52.h, 
                  text:  start==""?"Start Time": start.substring(10,16), 
                  color: AppConst.kLight,
                  color2: Color.fromARGB(255, 10, 18, 228)),

              CustomOtnBtn(//For_FinishTime
                onTap: (){
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                     onConfirm: (date) {
                      ref.read(finishTimeStateProvider.notifier)
                      .setFinish(date.toString());
                  }, 
                  locale: picker.LocaleType.en);
                },
              width: AppConst.kWidth*0.4, height: 52.h, 
              text:finish==""?"Finish Time": finish.substring(10,16), 
              color: AppConst.kLight,
              color2: Color.fromARGB(255, 10, 18, 228)
              ),
              ],),

            const HieghtSpacer(hieght: 20),

            CustomOtnBtn(//For_SubmitButton
            onTap: (){
              if(
                title.text.isNotEmpty&&
                desc.text.isNotEmpty&&
                scheduledDate.isNotEmpty&&
                start.isNotEmpty&&
                finish.isNotEmpty
              ){
              
                ref.read(todoStateProvider.notifier).updateItem(widget.id,
                title.text,
                desc.text,
                0,
                scheduledDate,
                start.substring(10,16),
                finish.substring(10,16)
                );
                ref.read(finishTimeStateProvider.notifier).setFinish('');
                ref.read(startTimeStateProvider.notifier).setStart('');
                ref.read(dateStateProvider.notifier).setDate('');        
               Navigator.pop(context);
              }
              else{
                print("failed to add task");

              }
            },
              width: AppConst.kWidth, height: 52.h, 
              text: "Submit", 
              color: AppConst.kLight,
              color2: AppConst.kGreen),


        ],
      ),
      ),
  );

}
  }