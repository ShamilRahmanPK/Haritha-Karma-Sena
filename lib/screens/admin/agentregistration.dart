import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/utilities/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AgentRegistrationPage extends StatefulWidget {
  const AgentRegistrationPage({Key? key}) : super(key: key);

  @override
  State<AgentRegistrationPage> createState() => _AgentRegistrationPageState();
}

class _AgentRegistrationPageState extends State<AgentRegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  bool _showPass = true;
  bool _showpass2 = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    phoneController.dispose();
    idController.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff006937),
      ),
      body: Container(
        padding: const EdgeInsets.only(
            left: 20, right: 20, bottom: 10, top: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Agent Registration",
                  size: 24,
                  color: Colors.black,
                  fw: FontWeight.w700,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a valid Name";
                    }
                  },
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Name",
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a valid  email id";
                    }
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(

                    hintText: "Email",
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
                SizedBox(
                  height: 10,
                ),

                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length != 10) {
                      return "Enter phone no";
                    }
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Phone no",
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
                SizedBox(
                  height: 20,
                ),


                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return "Enter a valid password ";
                    }
                  },
                  controller: passwordController,
                  obscureText: _showPass,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_showPass == true) {
                          setState(() {
                            _showPass = false;
                          });
                        } else {
                          setState(() {
                            _showPass = true;
                          });
                        }
                      },
                      icon: _showPass == true
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


                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return "Retype the  password ";
                    }
                  },
                  controller: confirmpasswordController,
                  obscureText: _showpass2,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_showpass2 == true) {
                          setState(() {
                            _showpass2 = false;
                          });
                        } else {
                          setState(() {
                            _showpass2 = true;
                          });
                        }
                      },
                      icon: _showpass2 == true
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    hintText: "Confirmpassword",
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
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _registeragent();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff006937),
                          borderRadius: BorderRadius.circular(10)),
                      height: 45,
                      width: 250,
                      child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 18,color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _registeragent(){


    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim())
        .then((user) {
      FirebaseFirestore.instance
          .collection('login')
          .doc(user.user!.uid)
          .set({
        'uid': user.user!.uid,
       // 'name': nameController.text,
        'email': user.user!.email,
        //'phone': phoneController.text,
        'password': passwordController.text,
        //'id': 'AGTR${idController.text}',

        'status':1,
        'createdat':DateTime.now(),
        'usertype':"agent"

      }).then((value) {
        FirebaseFirestore.instance.collection('agent').doc(user.user!.uid).set(
            {
              'uid': user.user!.uid,
              'name': nameController.text,
              'email': user.user!.email,
              'phone': phoneController.text,
              'id': 'AGTR${idController.text}',
              'ward':"Not Assigned",



              'status':1,



            }
        ).then((value) {
          showsnackbar("Registered Successfully");
          Navigator.pop(context);
        });
      });
    });
  }
  showsnackbar(var msg)
  {
    ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text(msg),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        )

    );

  }
}