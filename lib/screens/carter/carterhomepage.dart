
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/screens/agent/viewacarter.dart';
import 'package:hk_sena/screens/agent/viewallrequests.dart';
import 'package:hk_sena/screens/carter/viewallrequests.dart';
import 'package:hk_sena/utilities/apptext.dart';
import 'package:flutter/material.dart';



class CarterHome extends StatefulWidget {
  var email;
  var id;
  var name;
  var phone;
  var status;
  var ward;

   CarterHome({Key? key,this.status,this.phone,this.ward,this.email,this.name,this.id}) : super(key: key);

  @override
  State<CarterHome> createState() => _CarterHomeState();
}

class _CarterHomeState extends State<CarterHome> {
  TextEditingController msgConroller = TextEditingController();
  TextEditingController amntConroller = TextEditingController();
  var id;
  @override
  void initState() {
    id=DateTime.now().toString();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Color(0xff557153),
      leading: IconButton(onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
            context, "/login", (Route<dynamic> route) => false);
      }, icon: Icon(Icons.logout)),
    ),

        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Text("You are assigned to  "+widget.ward),
                  SizedBox(height: 30,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        InkWell(onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllRequests_carter(
                           ward: widget.ward,
                           id: widget.id,

                           name: widget.name,
                         )));
                        },
                          child: Container(
                            height: 100,
                            width: 130,
                              color: Color(0xff557153),
                            child: Center(
                              child: AppText(

                                text: "View All Requests", color: Colors.white,),
                            ),
                          ),
                        ),

                      ]
                  )
                ]
            )
        )
    );
  }
}