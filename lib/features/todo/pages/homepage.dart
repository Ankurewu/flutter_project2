import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_riverpod/common/helpers/notifications_helpers.dart';
import 'package:to_do_riverpod/common/utils/constants.dart';
import 'package:to_do_riverpod/common/widgets/appstyle.dart';
import 'package:to_do_riverpod/common/widgets/custom_text.dart';
import 'package:to_do_riverpod/common/widgets/hieghtspacer.dart';
import 'package:to_do_riverpod/common/widgets/reusable_text.dart';
import 'package:to_do_riverpod/common/widgets/widthspacer.dart';
import 'package:to_do_riverpod/common/widgets/xpansion_tile.dart';
import 'package:to_do_riverpod/features/todo/controllers/todo_provider.dart';
import 'package:to_do_riverpod/features/todo/controllers/xpansion_provider.dart';
import 'package:to_do_riverpod/features/todo/pages/add.dart';
import 'package:to_do_riverpod/features/todo/widgets/completed_task.dart';
import 'package:to_do_riverpod/features/todo/widgets/todo_tile.dart';
import 'package:to_do_riverpod/features/todo/widgets/tomorrow_list.dart';

import '../widgets/todayTask.dart';

class HomePage extends ConsumerStatefulWidget{
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState()=> _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin{
  late final TabController tabController = TabController(
    length: 2, vsync: this);
  late NotificationsHelper notifierHelper;
  late NotificationsHelper controller;
  final TextEditingController search =TextEditingController();
  
  @override
  void initState(){
    notifierHelper= NotificationsHelper(ref: ref);
    Future.delayed(const Duration(seconds: 0),(){
      controller= NotificationsHelper(ref: ref);
    });

    //notifierHelper.initilizeNotifications();
    //notifierHelper.requestIOSPermissions();
    super.initState();
  }



  @override
  Widget build(BuildContext context){
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
           preferredSize: Size.fromHeight(85), 
          child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(text: 'Dashboard',
                   style: appstyle(18, AppConst.kLight, FontWeight.bold),),
                  Container(
                    width: 25.w,
                    height: 26.h,
                    decoration: const BoxDecoration(
                      color: AppConst.kLight,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child:GestureDetector(
                      onTap: (){
                      Navigator.push(context, MaterialPageRoute
                      (builder: (context)=> const AddTask()));
                      },
                      child: Icon(Icons.add,color:AppConst.kBkDark),
                    ) ,
                  )
                ],
              ),
            ),
            const HieghtSpacer(hieght: 20),
            CustomTextField(
              hintText: 'Search', 
              controller: search,
              prefixIcon: Container(
                padding: EdgeInsets.all(14 ),
                child: GestureDetector(
                  onTap: null,
                  child:const Icon(AntDesign.search1,
                  color: AppConst.kGreyDk,) ,
                ),
              ),
              suffixIcon: const Icon(
                FontAwesome.sliders,
                color: AppConst.kGreyDk,),
              ),
              const HieghtSpacer(hieght: 15),
          ],
          ),
        ),
      ),
        body: SafeArea(child:Padding(padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const HieghtSpacer(hieght: 25),

            Row(
              children: [
                Icon(FontAwesome.tasks,size:20,color: AppConst.kLight,),
                
                WidthSpacer(wydth: 10),
                ReusableText(text: "Today's Task", style: appstyle(18, 
               AppConst.kLight, FontWeight.bold),)

              ],
            ),
            const HieghtSpacer(hieght: 25),
            Container(
              decoration: BoxDecoration(
                color: AppConst.kLight,
                borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius))
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  color: AppConst.kGreyLight,
                  borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius),),
                ),
                controller: tabController,
                labelPadding: EdgeInsets.zero,
                isScrollable: false,
                labelColor: AppConst.kBlueLight,
                labelStyle: appstyle(24, AppConst.kBlueLight, FontWeight.w700),
                unselectedLabelColor: AppConst.kLight,
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: AppConst.kWidth*0.5,
                      child: Center(
                        child: ReusableText(text: 'Pending', style: appstyle(16, 
                        AppConst.kBkDark, FontWeight.bold),),
                      ),
                    ),
                  ),

                  Tab(
                    child: Container(
                      padding: EdgeInsets.only(left:30.w),
                      width: AppConst.kWidth*0.5,
                      child: Center(
                        child: ReusableText(text: 'Completed', style: appstyle(16, 
                        AppConst.kBkDark, FontWeight.bold),),
                      ),
                    ),
                  ),
                ],
                ),
            ),

            const HieghtSpacer(hieght: 20),
            SizedBox(
              height: AppConst.kheight*0.3,
              width: AppConst.kWidth,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius),),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      color: AppConst.kLight,
                      height: AppConst.kheight*0.3,
                      child: const TodayTask()
                    ),

                    Container(
                      color: AppConst.kGreen,
                      height: AppConst.kheight*0.3,
                      child: const CompletedTask(),
                    )
                  ]),
              ),
            ),
          HieghtSpacer(hieght: 20),

          const TomorrowList(),

          const HieghtSpacer(hieght: 20),

          XpansionTile(
            text1: DateTime.now().add( const Duration(days:2)).toString().substring(5,10), 
            text2: "Day After Tomorrow's Tasks", 
            onExpansionChanged: (bool expanded){
              ref.read(xpansionStateProvider.notifier).
              setStart(!expanded);
            },
            trailing:
            Padding(
              padding: EdgeInsets.only(right:12.0.w),
              child:ref.watch(xpansionStateProvider)? 
              const Icon(AntDesign.circledown,color:AppConst.kBkDark)
              :const Icon(AntDesign.checkcircle,color: AppConst.kred),
            ),
            children: [
              TodoTile(
                            start: "03:00",
                            end: "05:00",
                            switcher: Switch(value: true, 
                            onChanged: (value){}),  
                          ),
            ]),
          ],  
        
        ),
        ))

    );
  }
}




 