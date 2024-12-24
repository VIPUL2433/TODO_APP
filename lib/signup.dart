import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/home.dart';
import 'package:task_app/login.dart';

class MySignup extends StatefulWidget {
  final VoidCallback showMyLogin;
  const MySignup({Key? key, required this.showMyLogin}) : super(key: key);

  @override
  _MySignupState createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
  //text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  //creating sign up method on tapping circular awatar if only if when passwordConfirmed function get satisfy means when password and confirm password mtch
  Future signUp() async {
    if( passwordConfirmed()){
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      
    );
    }
  }

  

  //confirm password and password ko  match kar rha hai ye function
  bool  passwordConfirmed()
  {
    if(_passwordController.text.trim() == _confirmpasswordController.text.trim())
    {
      return true;
    }
    else
    {
     
      return false;
    }


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/signup.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 73, left: 13),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(
                    fontSize: 47,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 0.996),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.40,
                    right: 35,
                    left: 25),
                child: Column(
                  children: [
                    TextField(
                      
                      controller:_emailController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade300,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(19))),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    TextField(
                      controller:_passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(19))),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                        TextField(
                      controller:_confirmpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Confirm password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(19))),
                    ),
                    SizedBox(
                      height: 53,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: widget.showMyLogin,
                          child: Text(
                            'back to login',
                            style: TextStyle(fontSize: 24, color: Colors.green),
                          ),
                        ),
                        GestureDetector(
                          onTap: signUp,
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
