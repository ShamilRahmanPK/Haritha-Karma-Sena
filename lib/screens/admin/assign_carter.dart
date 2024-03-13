import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:hk_sena/constants/colors.dart';
import 'package:hk_sena/utilities/apptext.dart';
class AssignCarterAdmin extends StatefulWidget {
  var ward;
  AssignCarterAdmin({Key? key,this.ward}) : super(key: key);

  @override
  State<AssignCarterAdmin> createState() => _AssignCarterAdminState();
}

String? _carter;



class _AssignCarterAdminState extends State<AssignCarterAdmin> {
  var wardcontroller=new TextEditingController();



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
  @override
  void initState() {
   // wardcontroller.text=widget.ward;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff006937),
        ),
        body:Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "Assign Carter",
                size: 24,
                color: Colors.black,
                fw: FontWeight.w700,
              ),
              SizedBox(height: 15,),
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
                        borderSide: BorderSide(color: Colors.teal, width: 3)),
                    hintText: 'Ward'),
              ),
              SizedBox(
                height: 20,
              ),



              Container(

                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('carter')

                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox.shrink();
                    }

                    if (snapshot.hasData &&
                        snapshot.data!.docs.length == 0) {
                      return SizedBox.shrink();
                    }
                    if(snapshot.hasData && snapshot.data!.docs.length!=0){
                      return Column(
                        children: [
                          DropdownButtonFormField<String>(
                              value: _carter,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              decoration:InputDecoration(
                                  enabledBorder: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.teal, width: 3)),
                                  hintText: 'Select Carter'),
                              onChanged: (value) => setState(() {
                                _carter = value;
                                print(_carter.toString());
                              }),
                              validator: (value) => value == null
                                  ? 'field required'
                                  : null,
                              items: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                return DropdownMenuItem<String>(
                                    value: document['uid'],
                                    child: Text(
                                        '${document['name']}'));
                              }).toList()),
                        ],
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: (){
                    print(_carter);
                    FirebaseFirestore.instance.collection('carter').doc(_carter.toString()).update(
                        {
                          'ward':wardcontroller.text
                        }).then((value) => Navigator.pop(context));
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff006937)

                    ),
                    child: Center(
                      child : Text(
                        "Assign",
                        style: TextStyle(fontSize: 18,color: Colors.white),
                      ),
                    ),

                  ),
                ),
              )

            ],
          ),
        )

    );
  }
}
