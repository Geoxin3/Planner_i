import 'package:hive/hive.dart';

class Storage{

  //main list in home
  List tasklist=[];

  //box reference
  final storage=Hive.box('storage');

  //dispay data
  void displaydata(){
  final storedData=storage.get("0");
  tasklist=storedData !=null ? List.from(storedData) : [];
  }
  //update data
  void updatedata(){
    storage.put("0", tasklist);
  }
  //delete task
  void removetask(String id){
    tasklist.removeWhere((task)=>task[1]==id);
    updatedata();
  }
  //constructor for data dispaly
  Storage(){
    displaydata();
  }

}