import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class DatabaseMethods {
  // write operation
  Future addTaskDetails(Map<String, dynamic> taskInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("ToDos")
        .doc(id)
        .set(taskInfoMap);
  }

  // read operation  for a particular day

  Future<Stream<QuerySnapshot>> getTaskDetails() async {
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return await FirebaseFirestore.instance
        .collection("ToDos")
        .where('Date', isEqualTo: date) // filtering for todays data only
        .snapshots();
  }

  // whole data read according to date on calendar
  Future<Stream<QuerySnapshot>> getParticularDateTaskDetails(
      String date) async {
    return await FirebaseFirestore.instance
        .collection("ToDos")
        .where('Date', isEqualTo: date)
        .snapshots();
  }

  //delete opearation
  Future deleteTaskDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("ToDos")
        .doc(id)
        .delete();
  }

  // update operation for checkbox
  Future updateTaskDetails(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("ToDos")
        .doc(id)
        .update(updateInfo);
  }
}
