// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:project_i/pages/about.dart';
import 'package:project_i/pages/display_task.dart';
import 'package:project_i/pages/privacypolicy.dart';
import 'package:project_i/pages/settings.dart';
import 'package:project_i/pages/taskadd.dart';
import 'package:provider/provider.dart';
import '../themes/provider_theme.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_i/model/storage.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {

 const HomeScreen({super.key}); 

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //box reference
  final box=Hive.box('storage');
  //storage class instance
  Storage db=Storage();
  //checkbox on off
  void checkboxchange(bool? value,int index){
    setState(() {
      db.tasklist[index][0]=!db.tasklist[index][0];
      //updaing db
      db.updatedata();
    });
    //sncakbar according to iscomplete 
    if(db.tasklist[index][0]==true){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Row(
        children: [
          Icon(Icons.hourglass_bottom,color: Colors.green,),
          SizedBox(width: 15,),
          Text("Task completed !"),
        ],
      ),duration: Duration(seconds: 2),
      ));
  }else{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Row(
        children: [
          Icon(Icons.hourglass_top,color: Colors.red,),
          SizedBox(width: 15,),
          Text("Task notcompleted !"),
        ],
      ),duration: Duration(seconds: 2),
      ));
  }
  }
  //save task from taskadd to list
  void savetotask()async {
    //navigate to the Taskadd page and wait for the result
      await Navigator.push(context,MaterialPageRoute(builder: (context)=>
      Taskadd(
          onSave: (taskData) {
            //checking the retrived task if it is not null for snackbar 
            if(taskData!=null){
            //updating the task list with the new task data
            setState(() {
              db.tasklist.add([
                false,
                taskData['id'],
                taskData['title'],
                taskData['note'],
                taskData['date'],
                taskData['priority']
              ]);
              db.updatedata();
            });
            //snackbar
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Row(
              children: [
                Icon(Icons.check_circle,color: Colors.green,),
                SizedBox(width: 15,),
                Text("Task added !"),
              ],
            ),
            )
            );
          };
       }),
      ),
    );
  }
  //filtering tasks
  String selectedfilter="All";
  List<String> filteroptions=["All","Completed","Pending"];
  //filtering
  List<dynamic> get filteredtasks {
    if(selectedfilter=="All"){
      return db.tasklist;
    }else if(selectedfilter=="Completed"){
      return db.tasklist.where((task)=> task[0]==true).toList();
    }else if (selectedfilter=="Pending"){
      return db.tasklist.where((task)=> task[0]==false).toList();
    }else{
      return db.tasklist;
    }
  }
  @override
  Widget build(BuildContext context) {
    
    //appbar color change
    final uiProvider=Provider.of<UiProvider>(context);
    return Scaffold(
      //appbar
      appBar: AppBar(
        shadowColor: uiProvider.dark ? Colors.indigo : Colors.grey[900],
        elevation: 5,
        backgroundColor: uiProvider.dark ? Colors.grey[900] : Colors.indigo,
        //menu button
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            },
             icon:Icon(Icons.menu),color: Colors.white,
             tooltip: "Menu",
             );
          }
        ),
         //text
         title: Text("Planner i",style:TextStyle(
          color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600,letterSpacing: 2)),
      ),
      //body
      body: SafeArea(child: 
      Stack(
        children:[
          //animation
          (db.tasklist.isEmpty)
        ? Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 230),
                  child: Lottie.asset("assets/animhome.json",
                  width: 400,height: 350),
                ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text("No task added yet !",style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,wordSpacing: 1.5,
                      color: uiProvider.dark ? Colors.indigo : Colors.black
                    ),),
                  ),
                )
            ],
          )         
          //heading in home 
        : Column(
          children: [
              Center(
                child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("YOUR TASKS",style: TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold,
                letterSpacing: 3,wordSpacing: 6
                ),),
                ),
              ),
              Divider(thickness: 2,endIndent: 30,indent: 30,height: 30,),
              //choice chip
              (filteredtasks.isEmpty)?
              //if filtered task is empty
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30,top: 10),
                        child: BackButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> HomeScreen()));
                        },),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Lottie.asset("assets/anim_task.json",
                    width: 400,height: 250),
                ),
                ),
                  Text("No tasks !",style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,wordSpacing: 1.5,
                      color: uiProvider.dark ? Colors.indigo : Colors.black)  )
                ],
              ):
              //showing filter choicechip
              Wrap(
                spacing: 10,
                children: filteroptions.map((filter){
                  return ChoiceChip(label: Text(filter),
                   selected: selectedfilter==filter,
                   onSelected: (bool isselected){
                    setState(() {
                      selectedfilter=filter;
                    });
                   },selectedColor: Colors.blue,
                  );
                }
              ).toList()
              ),   
          //gridview task using cards
          Expanded(
            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            padding: EdgeInsets.only(top: 10),
            itemCount: filteredtasks.length,
             itemBuilder: (context,index){
              //for showing the lastly added task first
              /* this works like the data adding into the tasklist
              when first one adds its index will be 0 then if 
              nextone adds the first ones index will be 1 and
              newones will be 0 */
             final reversedIndex=filteredtasks.length-1-index;
             return Tasks(
              istaskcompleted: filteredtasks[reversedIndex][0],
              id: filteredtasks[reversedIndex][1],
              taskname: filteredtasks[reversedIndex][2],
              tasknote: filteredtasks[reversedIndex][3],
              taskdate: filteredtasks[reversedIndex][4],
              taskpriority: filteredtasks[reversedIndex][5],
              onchange: (value){
                checkboxchange(value, reversedIndex);
               },
             );
             }),
          )  ])
        ]
      ),
     ),
     //floating action button
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
     floatingActionButton:  
     FloatingActionButton(onPressed: (){
        savetotask(); 
      },backgroundColor: Colors.indigo,tooltip: "New Task",
        child: Icon(Icons.add,color: Colors.white,),),
      //drawer 
      drawer: Drawer(
        child: ListView(
          children:[
            Row(
              children: [
                BackButton(),
          //theme change icon change
          Padding(
            padding: const EdgeInsets.only(left: 200,top: 10),
             child: IconButton(
              onPressed: (){
              Provider.of<UiProvider>(context,listen: false).changeTheme();
              },
              icon: Icon(uiProvider.dark ? Icons.light_mode : Icons.dark_mode,
              color: uiProvider.dark ?Colors.indigoAccent : Colors.grey[700]),
              tooltip: uiProvider.dark ? "Light Mode" : "Dark Mode",
             ),
            ),
           ],
          ),
          //circleAvatar
          Container(
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: uiProvider.dark ? Colors.indigo : Colors.grey,
                spreadRadius: 1,blurRadius: 20
              )
            ]
            ),
              child: CircleAvatar(
                radius: 95,child: CircleAvatar(
                  radius: 94,
                  backgroundImage: AssetImage("assets/profile.jpg"),
              )),
             ),
             //line
             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
               child: Divider(thickness: 2,color: Colors.indigoAccent,),
             ),
            SizedBox(height: 20,),
            //settings
            ListTile(
              title: Text("Settings",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.indigoAccent),),
              subtitle: Text("Click for setings."),
              contentPadding: EdgeInsets.only(top: 10,bottom: 5,left: 40,right: 50),
              trailing: Icon(Icons.settings),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> Settings()));
              },
            ),
             //privacy policy
             ListTile(
              title: Text("Privacy Policy",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.indigoAccent),),
              subtitle: Text("View policies."),
              contentPadding: EdgeInsets.only(top: 10,bottom: 5,left: 40,right: 50),
              trailing: Icon(Icons.privacy_tip_rounded),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> Privacypolicy()));
              },
            ),
             //about
             ListTile(
              title: Text("About",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.indigoAccent),),
              subtitle: Text("About Dev."),
              contentPadding: EdgeInsets.only(top: 10,bottom: 5,left: 40,right: 50),
              trailing: Icon(Icons.info),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> About()));
              },
            ),
            //version
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Text("v 1.0.0",style: TextStyle(fontSize: 10),),
                ),
              ],
            )
        ] 
      ),   
    )
   );
  }
}