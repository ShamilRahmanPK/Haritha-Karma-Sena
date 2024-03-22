import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAllAgents extends StatefulWidget {
  const ViewAllAgents({Key? key}) : super(key: key);

  @override
  State<ViewAllAgents> createState() => _ViewAllAgentsState();
}

class _ViewAllAgentsState extends State<ViewAllAgents> {
  var carterlist=['Nadha','Nandhana','Salman','Shalbin'];
  var id=['100','101','102','103'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff006937),

        title: Text("Users"),
      ),
      body:SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
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
                            subtitle: Text(snapshot.data!.docs[index]['uid']),
                            // trailing: IconButton(
                            //   onPressed: () {
                            //
                            //
                            //   },
                            //   icon: snapshot.data!.docs[index]['status'] == 1
                            //       ? Icon(
                            //     Icons.delete,
                            //     color: Colors.red,
                            //   )
                            //       : Text("D"),
                            // ),
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
}
