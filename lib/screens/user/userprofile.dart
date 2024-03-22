import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/utilities/apptext.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  var name;
  var email;
  var hno;
  var phone;
  var status;
  var uid;
  var wardno;
  var imgurl;
  UserProfile(
      {Key? key,
      this.name,
      this.imgurl,
      this.email,
      this.uid,
      this.phone,
      this.hno,
      this.status,
      this.wardno})
      : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff006937),
        title: _status == false ? Text("Profile Page") : Text("Edit Profile"),
      ),
      body: _status == false
          ? Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .where('uid', isEqualTo: widget.uid)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data!.docs[0]['name']);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          text: "User Profile",
                          size: 25,
                          fw: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.6),
                                shape: BoxShape.circle),
                            child: Container(
                                height: 90,
                                width: 90,
                                child: Center(
                                  child: snapshot.data!.docs[0]['imgurl'] == ""
                                      ? Image.asset(
                                          'assets/images/prof.png',
                                          scale: 3,
                                        )
                                      : Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot
                                                      .data!
                                                      .docs[0]['imgurl'])))),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                            elevation: 5.0,
                            color: Color(0xffEEF3E0),
                            child: Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    text: snapshot.data!.docs[0]['name'].toString().toUpperCase(),
                                    size: 20,
                                    fw: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AppText(
                                    text: snapshot.data!.docs[0]['email'],
                                    size: 18,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AppText(
                                    text: snapshot.data!.docs[0]['phone'],
                                    size: 18,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText(
                                        text: widget.wardno,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText(
                                        text: "House No:",
                                        size: 18,
                                      ),
                                      AppText(
                                        text: widget.hno,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (_status == false) {
                              setState(() {
                                _status = true;
                              });
                            }
                          },
                          child: Container(
                            height: 45,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff006937),
                            ),
                            child: Center(
                              child: AppText(
                                text: "Edit Profile",
                                color: Colors.white,
                                size: 16,
                                fw: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ))
          : EdiProfile(
              email: widget.email,
              phone: widget.phone,
              name: widget.name,
              id: widget.uid,
            ),
    );
  }
}

class EdiProfile extends StatefulWidget {
  String? name;
  String? phone;
  String? email;
  String? id;

  EdiProfile({Key? key, this.phone, this.email, this.name, this.id})
      : super(key: key);

  @override
  State<EdiProfile> createState() => _EdiProfileState();
}

class _EdiProfileState extends State<EdiProfile> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final key = GlobalKey<FormState>();
  //image uplaod
  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?

  var imageurl;
  var complaintid;
  //end of image upload variables
  @override
  void initState() {
    nameController.text = widget.name.toString();
    emailController.text = widget.email.toString();
    phoneController.text = widget.phone.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: "Edit Profile",
              size: 30,
              fw: FontWeight.bold,
            ),
            SizedBox(height: 20,),
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
            Row(
              children: [
                Text("Uplaod Image",style: TextStyle(fontSize: 18),),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      showimage();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.transparent,
                      child: _image != null
                          ? ClipRRect(
                              child: Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                            ))
                          : Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_file,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (key.currentState!.validate()) {
                  String fileName = DateTime.now().toString();
                  var ref =
                      FirebaseStorage.instance.ref().child("profile/$fileName");
                  UploadTask uploadTask = ref.putFile(File(_image!.path));

                  uploadTask.then((res) async {
                    imageurl = (await ref.getDownloadURL()).toString();
                  }).then((value) {
                    FirebaseFirestore.instance
                        .collection("user")
                        .doc(widget.id)
                        .update({
                      'phone': phoneController.text,
                      'email': emailController.text,
                      'name': nameController.text,
                      'imgurl': imageurl
                    }).then((value) {
                      showsnackbar("Sucessfully Updated");
                      Navigator.pop(context);
                    });
                  });
                } else
                  showsnackbar("Choose a Complaint");
              },
              child: Container(
                height: 45,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green,
                ),
                child: Center(
                  child: AppText(
                    text: "Edit Profile",
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showsnackbar(var msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 4),
    ));
  }

  // add these function at the bottom of the extended class
  _imagefromgallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  _imagefromcamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
  }

  showimage() {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.pink,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromcamera();
                          },
                          icon: Icon(Icons.camera_alt_rounded,
                              color: Colors.white),
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Camera"),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.purple,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromgallery();
                          },
                          icon: Icon(Icons.photo),
                          color: Colors.white,
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
