import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ViewAllRequests_carter extends StatefulWidget {
  String? ward;
  String?id;String?name;
  ViewAllRequests_carter({Key? key, this.ward,this.id,this.name}) : super(key: key);

  @override
  State<ViewAllRequests_carter> createState() => _ViewAllRequests_carterState();
}

class _ViewAllRequests_carterState extends State<ViewAllRequests_carter> {

  TextEditingController msgConroller = TextEditingController();
  TextEditingController amntConroller = TextEditingController();
  var id;
  String? _carter;


  var uuid=Uuid();
  @override
  void initState() {
    id=uuid.v1();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
        backgroundColor: Color(0xff006937),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Request')
              .where('wardno', isEqualTo: widget.ward.toString()).where('pickupstatus',isEqualTo:0)
              .snapshots(),
          builder: (context, snapshot) {
            print(snapshot);
            if(snapshot.hasData && snapshot.data!.docs.length==0){
              return Center(
                child: Text("No Open Requests",style: TextStyle(
                    fontSize: 15,
                ),),
              );
            }
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
                            snapshot.data!.docs[index]['status'] == 0
                                ? IconButton(
                                    onPressed: () {

                                      showDialog<String>(

                                        context: context,
                                          builder: (
                                              BuildContext
                                          context) =>
                                          AlertDialog(
                                            actions: [

                                              TextButton(onPressed: (){

                                                FirebaseFirestore
                                                    .instance
                                                    .collection(
                                                    "agentmessage")
                                                    .doc(id)
                                                    .set({
                                                  'id':snapshot.data!.docs[index]['uid'],
                                                  'uid':widget.id,
                                                  'name':widget.name,
                                                  'amount': amntConroller.text,
                                                  'msg':msgConroller.text,
                                                  'ward':widget.ward,
                                                  'updatedat':DateTime.now()
                                                }).then((value) {

                                                 FirebaseFirestore.instance.collection('collectionassignment').doc(snapshot.data!.docs[index]['uid']).update(
                                                     {

                                                       'status':1

                                                     }).then((value) {



                                                   FirebaseFirestore.instance.collection('Request').doc(snapshot.data!.docs[index]['uid']).update(
                                                       {

                                                         'pickupstatus':1,
                                                         'status':1

                                                       });
                                                 });
                                                }).then((value) => Navigator.pop(context));
                                              }, child: Text("Update"))
                                            ],
                                            content: Container(
                                              height: 100,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    decoration:
                                                    InputDecoration(
                                                        hintText:
                                                        "Status"),
                                                    controller:
                                                    msgConroller,
                                                    keyboardType:
                                                    TextInputType
                                                        .text,
                                                  ),
                                                  TextFormField(
                                                    decoration:
                                                    InputDecoration(
                                                        hintText:
                                                        "Colleted Amount "),
                                                    controller:
                                                    amntConroller,
                                                    keyboardType:
                                                    TextInputType
                                                        .number,
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                      );

                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 32,
                                    ))
                                : SizedBox(),
                          ],
                        ),
                        trailing: snapshot.data!.docs[index]['pickupstatus'] != 0
                            ? Text("Picked")
                            : Text("Pending",
                                style: TextStyle(color: Colors.red)),
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

  _deleteAgent(String id) {
    FirebaseFirestore.instance
        .collection('login')
        .doc(id)
        .update({'status': 0}).then((value) => FirebaseFirestore.instance
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
