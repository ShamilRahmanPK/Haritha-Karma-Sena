import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utilities/apptext.dart';


class ViewAllDisposals extends StatefulWidget {
  String?id;
  ViewAllDisposals({Key? key,this.id}) : super(key: key);

  @override
  State<ViewAllDisposals> createState() => _ViewAllDisposalsState();
}

class _ViewAllDisposalsState extends State<ViewAllDisposals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disposals"),
        backgroundColor: Color(0xff557153),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            AppText(
              text: "Disposal History",
            ),
            SizedBox(height: 20,),

            Container(
              height: MediaQuery.of(context).size.height*0.75,

              child:StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Request').where('uid',isEqualTo: widget.id).snapshots(),
                builder: (_,snapshot){

                  if(snapshot.hasData){

                    return ListView.builder(

                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          if(snapshot.hasData){
                            var format = new DateFormat('y-M-d');
                            var date= format.format(snapshot.data!.docs[index]['bookingdate'].toDate());

                            return Card(
                              elevation: 5.0,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                height: 120,
                                width: 250,
                                decoration: BoxDecoration(

                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        AppText(text: "Request Send on:"),
                                        SizedBox(width: 20,),
                                        AppText(text: date.toString())
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        AppText(text: "Status"),
                                        SizedBox(width: 20,),
                                        snapshot.data!.docs[index] ['status']==0?AppText(text: "Pending",color: Colors.red,fw: FontWeight.w700,):AppText(text: "Picked",color: Colors.green,fw: FontWeight.w700,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }

                          return Center(
                            child: CircularProgressIndicator(),
                          );

                        });
                  }
                  if(snapshot.hasData && snapshot.data!.docs.length==0){

                    return Center(
                      child: Text(
                          "No Disposals"
                      ),
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            )


          ],
        ),
      ),
    );
  }
}
