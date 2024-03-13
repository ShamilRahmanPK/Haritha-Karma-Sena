import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:hk_sena/constants/colors.dart';


class Generalcomplaint extends StatefulWidget {
  var name;
  var email;
  var hno;
  var phone;
  var status;
  var uid;
  var wardno;
  Generalcomplaint(
      {Key? key,
      this.name,
      this.status,
      this.phone,
      this.uid,
      this.email,
      this.wardno,
      this.hno})
      : super(key: key);

  @override
  State<Generalcomplaint> createState() => _generalcomplaint();
}

class _generalcomplaint extends State<Generalcomplaint> {
  var com;
  var cid;
  var uuid=Uuid();
  TextEditingController complaintController = TextEditingController();
//image uplaod
  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?

  var imageurl;
var complaintid;
  //end of image upload variables
  @override
  void initState() {
    complaintid=uuid.v1();
    // TODO: implement initState
    cid = widget.uid + DateTime.now().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 20,left: 20),
      child: Column(
        children: [
          Container(
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter a valid message";
                }
              },
              controller: complaintController,
              maxLines: 5,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Complaint",
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
          // SizedBox(
          //   height: 20,
          // ),
          Row(
            children: [
              Text("Uplaod Image",style: TextStyle(fontSize: 18),),
              GestureDetector(
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
                              // CircleAvatar(
                              //   radius: 45.0,
                              //   backgroundImage: NetworkImage(widget.imgurl),
                              //   backgroundColor: Colors.transparent,
                              // ),

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
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(



              onPressed: () {
                if (complaintController.text != null) {
                  String fileName = DateTime.now().toString();
                  var ref =
                      FirebaseStorage.instance.ref().child("complaints/$fileName");
                  UploadTask uploadTask = ref.putFile(File(_image!.path));






                  uploadTask.then((res) async {
                    imageurl = (await ref.getDownloadURL()).toString();
                  }).then((value) {


                    FirebaseFirestore.instance
                        .collection("generalcomplaint")
                        .doc(complaintid)
                        .set({

                      'customerid':widget.uid,
                      'complaintid':complaintid,
                      'name': widget.name,
                      'phone': widget.phone,
                      'complaint': complaintController.text,
                      'date': DateTime.now(),
                      'compimage':imageurl,
                      'status': 1,
                      'reply':""
                    }).then((value) {
                      showsnackbar("Sucessfully Registerd");
                      Navigator.pop(context);
                    });
                  });
                } else
                  showsnackbar("Choose a Complaint");
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                primary: Colors.black
              ),
              child: Text("Post",style: TextStyle(fontSize: 18),))
        ],
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
