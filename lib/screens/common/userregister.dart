import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/utilities/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController housenoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String?_ward;
  List<String> ward=[
    "Ward1",
    "Ward2",
    "Ward3",
    "Ward4",
    "Ward5",
    "Ward6",
    "Ward7",
    "Ward8",
    "Ward9",
    "Ward10",
    "Ward11",
    "Ward12",
    "Ward13",
    "Ward14",
    "Ward15",
    "Ward16",
    "Ward17",
    "Ward18",
    "Ward19",
    "Ward20",
  ];

  bool _showPass = true;
  bool _showpass2 = true;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    phoneController.dispose();
    wardController.dispose();
    housenoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff006937),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              width: MediaQuery.of(context).size.width,
              // top: MediaQuery.of(context).size.width,
                bottom: 150,
              // right: 70,
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  "assets/images/reg.png",
                  height: 400,
                  fit: BoxFit.cover,
                ),
              )),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "User Registration",
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
                          hintText: "Phone No",
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
                      DropdownButtonFormField(
                        items: ward.map((String ward) {
                          return new DropdownMenuItem<String>(
                              value: ward,
                              child: Row(
                                children: <Widget>[
                                  Text(ward),
                                ],
                              ));
                        }).toList(),
                        onChanged: (String?newValue) {
                          // do other stuff with _category
                          setState(() => _ward = newValue);
                        },
                        value: _ward,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.pink, width: 3)),
                            hintText: 'Ward'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter house no";
                          }
                        },
                        controller: housenoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "House No",
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
                          hintText: "Re-type Password",
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
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim())
                                  .then((user) => FirebaseFirestore.instance
                                  .collection('login')
                                  .doc(user.user!.uid)
                                  .set({
                                'uid': user.user!.uid,
                                // 'name': nameController.text,
                                'email': user.user!.email,
                                // 'phone': phoneController.text,
                                'password': passwordController.text,
                                // 'houseno':housenoController.text,
                                // 'wardno':wardController.text,

                                'status': 1,
                                'createdat': DateTime.now(),
                                'usertype': "user"
                              }).then((value) {
                                FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(user.user!.uid)
                                    .set({
                                  'uid': user.user!.uid,
                                  'name': nameController.text,
                                  'email': user.user!.email,
                                  'phone': phoneController.text,
                                  'imgurl': "",
                                  'houseno': housenoController.text,
                                  'wardno': _ward,
                                  'status': 1,
                                }).then((value) {
                                  FirebaseFirestore.instance
                                      .collection('wallet')
                                      .doc(user.user!.uid)
                                      .set({
                                    'walletid': user.user!.uid,
                                    'amount': 0.0,
                                    'createdAt': DateTime.now(),
                                  }).then((value) {
                                    showsnackbar("Account Created");
                                    Navigator.pop(context);
                                  });
                                });
                              }));
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
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  showsnackbar(var msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 4),
    ));
  }
}
