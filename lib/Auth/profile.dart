import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Your Profile",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              //fontStyle: FontStyle.italic
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 173, 151, 151),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 40, left: MediaQuery.of(context).size.width * 0.05),
            child: Icon(
              Icons.person,
              size: 56,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(Icons.email),
            tileColor: Colors.grey[300],
            title: Text("EMAIL ID"),
            subtitle: Text(
              '' + user.email!,
            ),
          ),
          Divider(
            height: 0.2,
          ),
          ListTile(
            leading: Icon(Icons.login_outlined),
            tileColor: Colors.grey[300],
            title: InkWell(
              onTap: () async {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: Text(
                "Log Out",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//  body: Column(
//         children: [
//           Text(
//             'login with ' + user.email!,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           MaterialButton(
//             onPressed: () async {
//               FirebaseAuth.instance.signOut();
//               Navigator.pop(context);
//               // Navigator.pushReplacement(
//               //     context,
//               //     MaterialPageRoute(
//               //         builder: (context) => MyLogin(
//               //               showMySignup: () {},
//               //             )));
//             },
//             color: Colors.purple[200],
//             child: Text("Sign Out"),
//           )
