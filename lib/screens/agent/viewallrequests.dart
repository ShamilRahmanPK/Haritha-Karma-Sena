import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/constants/colors.dart';
import 'package:flutter/material.dart';

class ViewAllRequests_agent extends StatefulWidget {

  String?ward;
  ViewAllRequests_agent({Key? key,this.ward}) : super(key: key);

  @override
  State<ViewAllRequests_agent> createState() => _ViewAllRequests_agentState();
}

class _ViewAllRequests_agentState extends State<ViewAllRequests_agent> {
String? _carter;
var id;
@override
  void initState() {
  id=DateTime.now().toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
        backgroundColor: secondaryColor,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child:




        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Request').where('wardno',isEqualTo: widget.ward.toString()).snapshots(),
          builder: (context, snapshot) {
            print(snapshot);

            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length, //2
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Center(
                            child: Text((index + 1).toString()),
                          ),
                          backgroundColor: Colors.green.shade600,
                        ),
                        title: Text(snapshot.data!.docs[index]['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.docs[index]['houseno']),
                            snapshot.data!.docs[index]['status']==0?              IconButton(
                                                    onPressed: () {
                                                      // getWalletBalance();
                                                      showDialog(context: context,
                                                          builder:(context){
                                                        return AlertDialog(
                                                          content: Container(
                                                            height: 200,
                                                            width: 300,
                                                            child: Column(
                                                              children: [
                                                                Text("Assign Pickup"),
                                                                SizedBox(height: 30,),

                                                                Container(

                                                                  child: StreamBuilder<QuerySnapshot>(
                                                                    stream: FirebaseFirestore.instance
                                                                        .collection('carter').where('ward',isEqualTo: widget.ward)

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
                                                                ElevatedButton(onPressed: (){
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                      "collectionassignment")
                                                                      .doc(snapshot
                                                                      .data!
                                                                      .docs[index]
                                                                  [
                                                                  'req_id'])
                                                                      .set({

                                                                    'id':snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    [
                                                                    'req_id'],
                                                                    'ward':widget.ward,
                                                                    'carter':_carter,
                                                                    'houseno':snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    [
                                                                    'houseno'],
                                                                    'phone':snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    [
                                                                    'phoneno'],
                                                                    'status':0,

                                                                    'updatedat':
                                                                    DateTime.now()
                                                                  }).then((value) {

                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                }, child:Text("Assign")),




                          ]
                                                          ),
                                                        ));

                                                          });
                                                    },
                                                    icon: Icon(
                                                      Icons.add,
                                                      size: 32,
                                                    )):SizedBox(),
                            // snapshot.data!.docs[index]['status']==0?Text(snapshot.data!.docs[index]['reply'],style: TextStyle(color: Colors.green),):SizedBox.shrink()
                          ],
                        ),
                        trailing: snapshot.data!.docs[index]['pickupstatus']==0?Text("Not Picked"):Text("Pending",style: TextStyle(color: Colors.red)),

                      ),
                    );
                  });
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text("No data Found"),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }



  _deleteAgent( String id){


    FirebaseFirestore.instance
        .collection('login')
        .doc(id)
        .update({'status': 0}).then((value) =>  FirebaseFirestore.instance
        .collection('agent')
        .doc(id)
        .update({'status': 0}));
  }




  Future<void> _showMyDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you really want to delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                _deleteAgent(id);

                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {


                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
