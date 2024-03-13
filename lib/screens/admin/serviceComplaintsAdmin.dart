import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceComplaintsAdmin extends StatefulWidget {

  String?uid;
  ServiceComplaintsAdmin({Key? key,this.uid}) : super(key: key);

  @override
  State<ServiceComplaintsAdmin> createState() => _ServiceComplaintsAdminState();
}

class _ServiceComplaintsAdminState extends State<ServiceComplaintsAdmin> {
  TextEditingController replyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('servicecomplaints').snapshots(),
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
                        children: [
                          Text(snapshot.data!.docs[index]['complaint']),
                          snapshot.data!.docs[index]['status']==0?Text(snapshot.data!.docs[index]['reply'],style: TextStyle(color: Colors.green),):SizedBox.shrink()
                         , snapshot.data!.docs[index]['status'] == 1?  Center(
                            child: InkWell(
                                onTap: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('AlertDialog Title'),
                                          content: Container(
                                            height: 150,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller: replyController,
                                                )
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection("servicecomplaints")
                                                    .doc(snapshot.data!.docs[index]
                                                ['cid'])
                                                    .update({
                                                  'reply': replyController.text,
                                                  'status': 0
                                                }).then((value) =>
                                                    Navigator.pop(context));
                                                //fiirebasecode
                                              },
                                              child: const Text('Submit'),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                child: Icon(Icons.add)),
                          ):SizedBox.shrink(),

                        ],
                      ),
                      trailing: snapshot.data!.docs[index]['status']==0?Text("Replied"):Text("Pending",style: TextStyle(color: Colors.red)),

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
