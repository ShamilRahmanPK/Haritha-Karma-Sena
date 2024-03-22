import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/utilities/apptext.dart';
import 'package:flutter/material.dart';

class UserComplaints extends StatefulWidget {
  var name;
  var email;
  var hno;
  var phone;
  var status;
  var uid;
  var wardno;
   UserComplaints({Key? key,this.name,this.status,this.phone,this.uid,this.email,this.wardno,this.hno}) : super(key: key);

  @override
  State<UserComplaints> createState() => _UserComplaintsState();
}

class _UserComplaintsState extends State<UserComplaints> {
  var com;
  var cid;
  @override
  void initState() {
    // TODO: implement initState
    cid=widget.uid+DateTime.now().toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(top: 20,left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          AppText(text: "Service Complaints",),

          RadioListTile(

            title: Text("Wast not collected"),
            value: "compl1",
            groupValue: com,
            onChanged: (value){
              setState(() {
                com = value.toString();
              });
            },
          ),


          RadioListTile(
            title: Text("Delay in Wast collection"),
            value: "compl2",
            groupValue: com,
            onChanged: (value){
              setState(() {
                com = value.toString();
              });
            },
          ),

          RadioListTile(
            title: Text("Behaviour problem"),
            value: "compl3",
            groupValue: com,
            onChanged: (value){
              setState(() {
                com = value.toString();
              });
            },
          ),
          RadioListTile(
            title: Text("inaccurate shedule"),
            value: "compl5",
            groupValue: com,
            onChanged: (value){
              setState(() {
                com = value.toString();
              });
            },
          ),
          RadioListTile(
            title: Text("Issue not resolved on first call"),
            value: "compl6",
            groupValue: com,
            onChanged: (value){
              setState(() {
                com = value.toString();
              });
            },
          ),
          RadioListTile(
            title: Text("Other"),
            value: "compl7",
            groupValue: com,
            onChanged: (value){
              setState(() {
                com = value.toString();
              });
            },
          ),
          SizedBox(height: 20,),
          Center(
            child: ElevatedButton(onPressed: (){
              if(com!=null) {
                FirebaseFirestore.instance.collection("servicecomplaints").doc(cid).
                set({
                  'cid':cid,
                  'customerid':widget.uid,
                  'name':widget.name,
                  'phone':widget.phone,
                  'complaint':com,
                  'date':DateTime.now(),
                  'status':1

                }).then((value) {
                  showsnackbar("sucessfully registerd");
                  Navigator.pop(context);

                });
              }
              else
                showsnackbar("choose a complaint");


            },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50), backgroundColor: Colors.black
                ),
                child: Text("Post",style: TextStyle(fontSize: 18),)),
          )
        ],
      ),
    );

  }
  showsnackbar(var msg)
  {
    ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text(msg),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        )

    );

  }
}
