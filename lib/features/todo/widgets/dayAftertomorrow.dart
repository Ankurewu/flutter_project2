import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_riverpod/features/todo/controllers/todo_provider.dart';
import 'package:to_do_riverpod/features/todo/pages/update_task.dart';
import 'package:to_do_riverpod/features/todo/widgets/todo_tile.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/xpansion_tile.dart';
import '../controllers/xpansion_provider.dart';

class DayAfter extends ConsumerWidget{
  const DayAfter({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){ //these_are_widgets
    final todos= ref.watch(todoStateProvider);
     var color= ref.watch(todoStateProvider.notifier).getRandomColor(); 
    String dayafter = ref.read(todoStateProvider.notifier).getDayAfter();

    var tomorrowTasks= todos.where((element)=>element.date!
            .contains(dayafter));
    return   XpansionTile(
                 text1: DateTime.now().add(const Duration(days:2))
                          .toString().substring(5,10), 
                 text2: "Day After Tomorrow's Tasks", 
            onExpansionChanged: (bool expanded){
              ref.read(xpansionStateProvider.notifier)
              .setStart(!expanded );
            },
            trailing:
            Padding(
              padding: EdgeInsets.only(right:12.0.w),
              child:ref.watch(xpansionStateProvider)? 
              Icon(AntDesign.circledown,color:AppConst.kBkDark)
              :Icon(AntDesign.checkcircle,color: AppConst.kred),
            ),
            children: [
              for(final todo in tomorrowTasks)
              TodoTile(
                      title: todo.title,
                      description: todo.desc,
                      color: color,
                      start: todo.startTime,
                      end: todo.endTime,
                      delete: (){
                        ref.read(todoStateProvider.notifier)
                        .deleteTodo(todo.id?? 0);},
                        editWidget: GestureDetector(
                              onTap: (){
                                titles =todo.title.toString();
                                descs  = todo.desc.toString();
                                
                                Navigator.push(context,
                                 MaterialPageRoute(builder:
                                  (context)=> UpdateTask(id: todo.id??0,)));
                            },
                            child: const Icon(
                              MaterialCommunityIcons.circle_edit_outline),
                            ),
                            switcher: const SizedBox.shrink()
                          ),
            
            ]
            );
  }
}