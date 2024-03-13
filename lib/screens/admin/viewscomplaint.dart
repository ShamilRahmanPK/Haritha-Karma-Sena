import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Viewscomplaint extends StatefulWidget {
  const Viewscomplaint({Key? key}) : super(key: key);

  @override
  State<Viewscomplaint> createState() => _ViewscomplaintState();
}

class _ViewscomplaintState extends State<Viewscomplaint> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("service complaints"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
          child: Container(
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
                            subtitle: Text(snapshot.data!.docs[index]['complaint']),
                            trailing: IconButton(
                              onPressed: () {
                                _showMyDialog(snapshot.data!.docs[index]['cid']);
                              },
                              icon: snapshot.data!.docs[index]['status'] == 1
                                  ? Icon(
                                Icons.delete,
                                color: Colors.red,
                              )
                                  : Text("D"),
                            ),
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
          )),
    );
  }



  _deleteAgent( String id){


    FirebaseFirestore.instance
        .collection('servicecomplaints')
        .doc(id).delete();
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
              child: const Text('Delete'),
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
