// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:project_i/pages/each_task_viewer.dart';
import 'package:project_i/themes/provider_theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Tasks extends StatelessWidget {
  final String id;
  final String taskname;
  final String tasknote;
  final String taskdate;
        String taskpriority;
  final bool istaskcompleted;
  Function(bool?)? onchange;

  Tasks({super.key,
  required this.id,
  required this.taskname,
  required this.tasknote,
  required this.taskdate,
  required this.taskpriority,
  required this.istaskcompleted,
  required this.onchange
  });

  @override
  Widget build(BuildContext context) {
    
    //priority number to text
    switch(taskpriority){
      case '1' :
        taskpriority="Low";
        break;
      case '2':
        taskpriority="Medium";
        break;
      case '3':
        taskpriority="High";
        break;
      case '4':
        taskpriority="Urgent";
        break;
      case '0':
        taskpriority="No priority";
      break;
    }
    //each task viewer
    void eachtask(){
      showDialog(
        context: context,
         builder: (context){
          return EachTask(
            id: id,
            tsktitle: taskname,
            tsknote: tasknote,
            tskdate: taskdate,
            tskprio: taskpriority,
            iscomplete: istaskcompleted,
          );
         }
      );
    }

    final uiProvider=Provider.of<UiProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 5,top: 3),
      child: GestureDetector(
        onTap: (){
          eachtask();
        },          
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
              elevation: 10,
              shadowColor: uiProvider.dark ? Colors.indigo : Colors.black,
              color: uiProvider.dark ? Colors.grey[900] : Colors.white70,
              child: Column(
                children: [
                  Row(
                    children: [
                    //checkbox
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Tooltip(
                        message: istaskcompleted ? "Not Completed" : "Completed",
                        child: Checkbox(value: istaskcompleted, onChanged: onchange,
                        activeColor: uiProvider.dark ? Colors.blue : Colors.indigo,
                        ),
                      ),
                    ),
                    //spacer widget to give space between a row 
                    Spacer(),
                    //priority tag
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        padding: EdgeInsets.only(left: 9,right: 9,top: 5,bottom: 5),
                        child: Text(taskpriority,style: TextStyle(
                          fontSize: 13,fontWeight: FontWeight.bold,
                          decoration: istaskcompleted ? TextDecoration.lineThrough : TextDecoration.none
                        ),),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (taskpriority=="No priority") ? Colors.transparent
                                :istaskcompleted ? Colors.green
                                :(taskpriority=="Low")
                                ? Colors.red
                                :(taskpriority=="Medium")
                                ? Colors.amber
                                :(taskpriority=="High")
                                ? Colors.blue
                                :(taskpriority=="Urgent")
                                ? Colors.cyan
                                : Colors.transparent
                        ),
                        ),
                    )
                  ],),
                  //taskname / tasktitle
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: Text(taskname,style: TextStyle(
                        fontSize: 16,fontWeight: FontWeight.w600,
                        decoration: istaskcompleted ? TextDecoration.lineThrough : TextDecoration.none
                      ),maxLines: 1,overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],),
                  //line
                  Divider(indent: 20,endIndent: 20,thickness: 3,),
                  SizedBox(height: 5,),
                  //task note / description
                  Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: Text(tasknote,style: TextStyle(
                          fontSize: 13,fontWeight: FontWeight.w500,
                          decoration: istaskcompleted ? TextDecoration.lineThrough : TextDecoration.none
                        ),maxLines: 2,overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],),
                  Spacer(),
                  //task date
                  Align(
                    alignment: Alignment.bottomRight,
                    child: 
                    Padding(
                      padding: const EdgeInsets.only(right: 16,bottom: 15),
                      child: Text(taskdate,style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w600,color: istaskcompleted ? Colors.green : Colors.red,
                        decoration: istaskcompleted ? TextDecoration.lineThrough : TextDecoration.none
                      ),
                      ),
                    )
                  ,)
                ],
              ),
          ),
      ),
    );
  }
}