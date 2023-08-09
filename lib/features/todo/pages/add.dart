
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_riverpod/common/helpers/notifications_helpers.dart';
import 'package:to_do_riverpod/common/models/task_model.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/appstyle.dart';
import 'package:to_do_riverpod/common/widgets/custom_otn_btn.dart';
import 'package:to_do_riverpod/common/widgets/custom_text.dart';
import 'package:to_do_riverpod/common/widgets/hieghtspacer.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'as picker;
import 'package:to_do_riverpod/features/todo/controllers/dates/dates_provider.dart';
import 'package:to_do_riverpod/features/todo/controllers/todo_provider.dart';
import 'package:to_do_riverpod/features/todo/pages/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AddTask extends ConsumerStatefulWidget{
  const AddTask({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState()=> _AddTaskState();
  }

  class _AddTaskState extends ConsumerState<AddTask>{
    final TextEditingController title=TextEditingController();
    final TextEditingController desc=TextEditingController();

    List<int> notification = [];

    late NotificationsHelper notifierHelper;
    late NotificationsHelper controller;
     final TextEditingController search =TextEditingController();
  
  @override
  void initState(){
    notifierHelper= NotificationsHelper(ref: ref);
    Future.delayed(const Duration(seconds: 0),(){
      controller= NotificationsHelper(ref: ref);
    });

    notifierHelper.initilizeNotification();
    //notifierHelper.requestIOSPermissions();
    super.initState();
  }


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
              color2: const Color.fromARGB(255, 10, 18, 228)),

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
                     notification= ref.read(startTimeStateProvider.notifier).dates(date);
                  }, 
                  locale: picker.LocaleType.en);
                  },
                  width: AppConst.kWidth*0.4, height: 52.h, 
                  text:  start==""?"Start Time": start.substring(10,16), 
                  color: AppConst.kLight,
                  color2: const Color.fromARGB(255, 10, 18, 228)),

              CustomOtnBtn(//For_FinishTime
                onTap: () {
                   picker.DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            onConfirm: (date) {
                                ref.read(finishTimeStateProvider.notifier)
                                  .setFinish(date.toString());
                                   }, 
                                      locale: picker.LocaleType.en,
                                      );
                                        },
                                        width: AppConst.kWidth * 0.4,
                                         height: 52.h, 
                                          text: ref.watch(finishTimeStateProvider) == "" ? "Finish Time" : ref.watch(finishTimeStateProvider).substring(10, 16), 
                                          color: AppConst.kLight,
                                          color2: const Color.fromARGB(255, 10, 18, 228)),
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
                  Task task= Task(
                    
                  title: title.text,
                  desc: desc.text,
                  isCompleted: 0,
                  date: scheduledDate,
                  startTime: start.substring(10,16),
                  endTime:  finish.substring(10,16),
                  remind: 0,
                  repeat: "yes", 

                ); 
                notifierHelper.scheduleNotification(
                  notification[0],
                  notification[1],
                  notification[2],
                  notification[3],
                  task);
                ref.read(todoStateProvider.notifier).addItem(task);
                //ref.read(finishTimeStateProvider.notifier).setFinish('');
                //ref.read(startTimeStateProvider.notifier).setStart('');
                //ref.read(dateStateProvider.notifier).setDate('');        
               
               Navigator.push(
                context,
               MaterialPageRoute(builder: (context)=> const HomePage()));
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill all the fields")),
                );
                
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