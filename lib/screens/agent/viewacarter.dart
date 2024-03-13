import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hk_sena/constants/colors.dart';
class CarterView extends StatefulWidget {
  var ward;
   CarterView({Key? key,this.ward}) : super(key: key);

  @override
  State<CarterView> createState() => _CarterViewState();
}

class _CarterViewState extends State<CarterView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Carters"),
      ),
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('carter').where('ward',isEqualTo: widget.ward).snapshots(),
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
                            subtitle: Text(snapshot.data!.docs[index]['id']),
                            trailing: IconButton(
                              onPressed: () {
                                _showMyDialog(snapshot.data!.docs[index]['uid']);
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



  _deleteCarter( String id){


    FirebaseFirestore.instance
        .collection('login')
        .doc(id)
        .update({'status': 0}).then((value) =>  FirebaseFirestore.instance
        .collection('carter')
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
                _deleteCarter(id);

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
