import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_app/service/database.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatefulWidget {
  // final String taskname;
  //final bool taskCompleted;
//  Function(bool?)? onChanged;
  // Function(BuildContext)? deleteFunction;

  // ToDoTile({
  //   super.key,
  //   // required this.taskname,
  //   // required this.taskCompleted,
  //   // required this.onChanged,
  //   //  required this.deleteFunction,
  // });

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  bool IsCompleted = false;
  void checkBoxChanged(bool IsCompleted) {
    IsCompleted = true;
  }

  getTodos() async {
    TaskStream = await DatabaseMethods().getTaskDetails();
    setState(() {});
  }

  @override
  void initState() {
    getTodos();
    super.initState();
  }

  Stream? TaskStream;

  Widget allTaskDetails() {
    return StreamBuilder(
        stream: TaskStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 30),
                        padding: EdgeInsets.only(
                            top: 10, left: 13, right: 25, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //checkbox
                            Checkbox(
                              value: IsCompleted,
                              onChanged: (value) => checkBoxChanged,
                              activeColor: const Color.fromARGB(255, 1, 19, 34),
                            ),

                            //task name
                            //Text(" make video"),
                            Text(
                              ds['Task'],
                              style: TextStyle(
                                  decoration: false
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),

                            IconButton(
                                onPressed: () {
                                  //deleteFunction;
                                  //deleteFunction!(context);
                                  // if () {
                                  //   deleteFunction!(context);
                                  // } else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //       content:
                                  //           Text('already completed task '),
                                  //     ),
                                  //   );
                                  // }

/*So, deleteFunction!(context); means "call the 
deleteFunction with the context argument, 
and I am sure deleteFunction is not null at this point."*/
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red.shade300,
                                ))
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return allTaskDetails();
  }
}
