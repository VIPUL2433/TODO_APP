import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:share_plus/share_plus.dart';
import 'package:task_app/Auth/profile.dart';
import 'package:task_app/calendar_page.dart';
import 'package:task_app/location.dart';
import 'package:task_app/service/database.dart';
import 'package:task_app/signup.dart';
import 'package:task_app/task_history.dart';
import 'package:task_app/util/dialog_box.dart';
import 'package:task_app/util/todo_tile.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  //text controlller
  final _controller = TextEditingController();
  //lsit of todo task
/*  List toDoList = [
    ["make video", false],
    ["dancing on the floor", false],
  ];
  */

  //checkbox tapped (onchanged function when we tap on checkbox) for firabse console
  void checkBoxChanged(String id, bool isCompleted) async {
    setState(() {
      isCompleted = !isCompleted;
    });
    Map<String, dynamic> updateInfo = {"IsCompleted": isCompleted};
    await DatabaseMethods().updateTaskDetails(id, updateInfo);
  }

  bool IsCompleted = false;

//save a new task
  void saveNewTask(bool IsCompleted) async {
    /* setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });*/
  }

  //create new task on tapping floating action button firebae
  void CreateNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          //create method on saving on firebase console
          onSave: () async {
            // await saveNewTask;
            String Id = randomAlphaNumeric(10);
            Map<String, dynamic> taskInfoMap = {
              "Task": _controller.text,
              "IsCompleted": IsCompleted,
              "Date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
              //String formattedDate = DateFormat('yyyy/MM/dd').format(now);
              "Id": Id,
            };
            await DatabaseMethods()
                .addTaskDetails(taskInfoMap, Id)
                .then((value) {
              Fluttertoast.showToast(
                  msg: "Task has been added succesfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  /* void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }
  */

  // for read operarion return todo tile syntax here

  Stream? TaskStream;

  getTodos() async {
    TaskStream = await DatabaseMethods().getTaskDetails();
    setState(() {});
  }

  @override
  void initState() {
    getTodos();
    super.initState();
  }

  Widget allTaskDetails() {
    return StreamBuilder(
        stream: TaskStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    //  bool? change = ds['IsCompleted'];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 30),
                        padding: EdgeInsets.only(
                            top: 8, left: 13, right: 25, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //checkbox
                            Checkbox(
                              value: ds['IsCompleted'],
                              onChanged: (value) =>
                                  checkBoxChanged(ds['Id'], ds['IsCompleted']),
                              activeColor: const Color.fromARGB(255, 1, 19, 34),
                            ),

                            //task name
                            //Text(" make video"),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                alignment: Alignment.center,
                                child: Text(
                                  ds['Task'],
                                  style: TextStyle(
                                      decoration: ds['IsCompleted']
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                ),
                              ),
                            ),

                            ds['IsCompleted']
                                ? Icon(
                                    Icons.done,
                                    size: 32,
                                    fill: 1.0,
                                    color: Colors.green,
                                  )
                                : IconButton(
                                    onPressed: () async {
                                      await DatabaseMethods()
                                          .deleteTaskDetails(ds['Id']);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade300,
                                    ))
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Make Your Day',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        width: 270,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: ClipOval(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage('assets/signup.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
            // Divider(),
            ListTile(
              title: Text('Profile'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  icon: Icon(Icons.person)),
              tileColor: Colors.grey.shade400,
            ),
            Divider(
              thickness: 5,
              height: 4,
              //color: Colors.grey.shade100,
            ),
            ListTile(
              title: Text('Task History'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalendarPage()));
                  },
                  icon: Icon(Icons.calendar_month)),
              tileColor: Colors.grey.shade400,
            ),

            Divider(
              thickness: 5,
              height: 4,
            ),
            ListTile(
              title: Text('Dark Mode'),
              leading: Icon(
                Icons.dark_mode,
                color: Colors.black,
              ),
              tileColor: Colors.grey.shade400,
            ),
            Divider(
              thickness: 5,
              height: 4,
            ),

            ListTile(
              title: Text('Share App'),
              leading: IconButton(
                  onPressed: () async {
                    final result = await Share.share('check my app');
                    print(result);
                  },
                  icon: Icon(Icons.share)),
              tileColor: Colors.grey.shade400,
            ),
            Divider(
              thickness: 5,
              height: 4,
            ),
            ListTile(
              title: Text('About App'),
              leading: Icon(
                Icons.app_registration_rounded,
                color: Colors.purpleAccent,
              ),
              tileColor: Colors.grey.shade400,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyLocation()));
            },
            child: Text(
              "Know Your location",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 70),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/clockapp.png'),
              )),
            ),
          ),
          Expanded(
            // child: ListView.builder(
            //   itemCount: toDoList.length,
            //   itemBuilder: (context, index) {
            //     return ToDoTile(
            //       taskname: toDoList[index][0],
            //       taskCompleted: toDoList[index][1],
            //       onChanged: (value) => checkBoxChanged(value, index),
            //       deleteFunction: (Context) => deleteTask(index),
            //     );
            //   },
            // ),
            child: allTaskDetails()
            //  onChanged: (value) => checkBoxChanged(IsCompleted),
            //  deleteFunction: deleteFunction
            ,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 175, 15, 203),
        onPressed: CreateNewTask,
        child: Icon(
          Icons.add,
          color: const Color.fromARGB(255, 51, 3, 59),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
