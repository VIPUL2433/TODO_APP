import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/service/database.dart';

class TaskHistory extends StatefulWidget {
  String date;
  TaskHistory({super.key, required this.date});

  @override
  _TaskHistoryState createState() => _TaskHistoryState(date: date);
}

class _TaskHistoryState extends State<TaskHistory> {
  String date;
  _TaskHistoryState({required this.date});
  Stream? TaskStream;

  @override
  void initState() {
    getTodos();
    super.initState();
  }

  getTodos() async {
    TaskStream = await DatabaseMethods().getParticularDateTaskDetails(date);
    setState(() {});
  }

  Map<String, List<Map<String, dynamic>>> groupByDate(
      List<Map<String, dynamic>> tasks) {
    //var formatter = DateFormat('yyyy/MM//dd');
    var groupedTasks = <String, List<Map<String, dynamic>>>{};

    for (var task in tasks) {
      var date = task['Date'];
      if (groupedTasks.containsKey(date)) {
        groupedTasks[date]!.add(task);
      } else {
        groupedTasks[date] = [task];
      }
    }
    return groupedTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text("Task History"),
        backgroundColor: Colors.purple[200],
      ),
      body: allTaskDetails(),
    );
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
                      padding: const EdgeInsets.only(
                          right: 1.0, left: 0, top: 8, bottom: 1),
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 15, top: 20),
                        padding: EdgeInsets.only(
                            top: 10, left: 13, right: 5, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //task name
                            //Text(" make video"),
                            Text(
                              ds['Date'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

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

                            /* ds['IsCompleted']
                                ? Icon(Icons.done)
                                : Icon(Icons.clear),
*/
                            // ds['IsCompleted']
                            //     ? Icon(
                            //         Icons.done,
                            //         size: 32,
                            //         fill: 1.0,
                            //         color: Colors.green,
                            //       )
                            //     : IconButton(
                            //         onPressed: () async {
                            //           await DatabaseMethods()
                            //               .deleteTaskDetails(ds['Id']);
                            //         },
                            //         icon: Icon(
                            //           Icons.delete,
                            //           color: Colors.red.shade300,
                            //         ))
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.purple[200],
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  })
              : Container();
        });
  }
}
