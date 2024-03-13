import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/constants/colors.dart';
import 'package:hk_sena/utilities/apptext.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/colors.dart';
class AssignCarter extends StatefulWidget {
  var ward;
   AssignCarter({Key? key,this.ward}) : super(key: key);

  @override
  State<AssignCarter> createState() => _AssignCarterState();
}

 String? _carter;



class _AssignCarterState extends State<AssignCarter> {
  var wardcontroller=new TextEditingController();
  @override
  void initState() {
    wardcontroller.text=widget.ward;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
        title: Text("Assign carters"),
      ),
      body:Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Assign Carter'),
            // DropdownButtonFormField(
            //   items: ward.map((String ward) {
            //     return new DropdownMenuItem<String>(
            //         value: ward,
            //         child: Row(
            //           children: <Widget>[
            //             Text(ward),
            //           ],
            //         ));
            //   }).toList(),
            //   onChanged: (String?newValue) {
            //     // do other stuff with _category
            //     setState(() => _ward = newValue);
            //   },
            //   value: _ward,
            //   decoration: const InputDecoration(
            //       enabledBorder: OutlineInputBorder(),
            //       focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.teal, width: 3)),
            //       hintText: 'Ward'),
            // ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10),
              child: TextFormField(
               readOnly: true,
                controller: wardcontroller,


                decoration: InputDecoration(
                  hintText: "ward",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.green.shade800)),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Container(

              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('carter').where('ward',isEqualTo: "")

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
                  height: 45,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:primaryColor

                  ),
                  child: Center(
                    child: AppText(
                      color: Colors.white,
                      text: 'Assign',
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
