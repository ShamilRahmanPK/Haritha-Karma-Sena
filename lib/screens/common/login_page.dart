import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/screens/agent/agenthome.dart';
import 'package:hk_sena/screens/carter/carterhomepage.dart';
import 'package:hk_sena/screens/common/regiserpage.dart';
import 'package:hk_sena/screens/common/userregister.dart';
import 'package:hk_sena/screens/user/userhomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../admin/admin_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  var lname;
  var fname;
  bool? _show = true;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
          children: [
            Positioned(
                width: MediaQuery.of(context).size.width,
                top: MediaQuery.of(context).size.width,
                // right: 70,
                child: Opacity(
                  opacity: 0.6,
                  child: Image.asset(
                    "assets/images/login.png",
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                )),
            Container(
                child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: MediaQuery.of(context).size.height * 0.80,
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 150,
                              width: 150,
                            ),
                          ),
                          Container(
                            child: Text(
                              "Log in to Account",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10, top: 20),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter a valid address";
                                }
                              },
                              controller: usernameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Username",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffC1F2B0), width: 1.5),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value.length < 8) {
                                  return "Enter a valid password ";
                                }
                              },
                              controller: passwordController,
                              obscureText: _show!,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (_show == true) {
                                      setState(() {
                                        _show = false;
                                      });
                                    } else {
                                      setState(() {
                                        _show = true;
                                      });
                                    }
                                  },
                                  icon: _show == true
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                                hintText: "Password",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffC1F2B0), width: 1.5),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                if (_formkey.currentState!.validate()) {
                                  _login();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 45,
                                width: 250,
                                child: Container(
                                  width: 120,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Color(0xff006937),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    "LOGIN",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserRegistration()));
                          },
                          child: Text(
                            "Regiser",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )),
                )
              ],
            )),
          ],
        )));
  }

  _login() {
    try {
      if (usernameController.text == "admin@gmail.com" &&
          passwordController.text == '12345678') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminHome()));
      } else {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: usernameController.text.trim(),
            password: passwordController.text.trim())
            .then((user) {
          FirebaseFirestore.instance
              .collection('login')
              .doc(user.user!.uid)
              .get()
              .then((value) {
            if (value.data()!['usertype'] == "carter" &&
                value.data()!['status'] == 1) {
              FirebaseFirestore.instance
                  .collection('carter')
                  .doc(user.user!.uid)
                  .get()
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CarterHome(
                              name: value.data()!['name'],
                              email: value.data()!['email'],
                              phone: value.data()!['phone'],
                              id: value.data()!['uid'],
                              status: value.data()!['status'],
                              ward: value.data()!['ward'],
                            )),
                        (route) => false);
              });
            } else if (value.data()!['usertype'] == "agent") {
              FirebaseFirestore.instance
                  .collection('agent')
                  .doc(user.user!.uid)
                  .get()
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AgentHome(
                              name: value.data()!['name'],
                              email: value.data()!['email'],
                              phone: value.data()!['phone'],
                              id: value.data()!['id'],
                              status: value.data()!['status'],
                              uid: value.data()!['uid'],
                              ward: value.data()!['ward'],
                            )),
                        (route) => false);
              });
            } else if (value.data()!['usertype'] == "user" &&
                value.data()!['status'] == 1) {
              FirebaseFirestore.instance
                  .collection('user')
                  .doc(user.user!.uid)
                  .get()
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserHomepage(
                              imgurl: value.data()!['imgurl'],
                              name: value.data()!['name'],
                              email: value.data()!['email'],
                              phone: value.data()!['phone'],
                              hno: value.data()!['houseno'],
                              status: value.data()!['status'],
                              uid: value.data()!['uid'],
                              wardno: value.data()!['wardno'],
                            )),
                        (route) => false);
              });
            }
          });
        });
      }
    }on FirebaseAuthException catch(error){

      errorMessage = error.message!;

      ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(content: Text(errorMessage.toString()),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ));

    }
  }
}
var errorMessage;