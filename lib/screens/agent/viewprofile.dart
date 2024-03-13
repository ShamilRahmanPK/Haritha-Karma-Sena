import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/utilities/apptext.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileAgent extends StatefulWidget {
  var name;
  var email;
  var hno;
  var phone;
  var status;
  var uid;
  var wardno;
  var imgurl;
  UserProfileAgent(
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
  State<UserProfileAgent> createState() => _UserProfileAgentState();
}

class _UserProfileAgentState extends State<UserProfileAgent> {
  bool _status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff557153),
        title: _status == false ? Text("Profile Page") : Text("Edit Profile"),
      ),
      body:
          Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('agent')
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
                      size: 22,
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
                        child: Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              AppText(
                                text: snapshot.data!.docs[0]['name'],
                                size: 18,
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
                                    text: "Ward No:",
                                    size: 18,
                                  ),
                                  AppText(
                                    text: widget.wardno,
                                    size: 18,
                                  ),
                                ],
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
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xffA9AF7E),
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
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ))

    );
  }
}

