
import 'package:hk_sena/constants/colors.dart';
import 'package:hk_sena/screens/agent/addevents.dart';
import 'package:hk_sena/screens/agent/assigncarter.dart';
import 'package:hk_sena/screens/agent/viewacarter.dart';
import 'package:hk_sena/screens/agent/viewalladds.dart';
import 'package:hk_sena/screens/agent/viewallrequests.dart';
import 'package:hk_sena/screens/agent/viewmessages.dart';
import 'package:flutter/material.dart';
import 'package:hk_sena/screens/agent/viewprofile.dart';

import '../../utilities/apptext.dart';



class AgentHome extends StatefulWidget {

  var name;
  var email;
  var id;
  var phone;
  var status;
  var uid;
  var ward;
AgentHome({Key? key,this.name,this.id,this.ward,this.email,this.uid,this.phone,this.status}) : super(key: key);

  @override
  State<AgentHome> createState() => _AgentHomeState();
}

class _AgentHomeState extends State<AgentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        appBar: AppBar(
          title: AppText(text: "Agent Home",color: Colors.white,),
          backgroundColor: primaryColor,
     actions: [
       IconButton(onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfileAgent()));
       }, icon: Icon(Icons.person)),

       IconButton(onPressed: (){

         Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false);
       }, icon: Icon(Icons.logout))
     ],
    ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Row(
              children: [
                Text("You are assigned to"),SizedBox(width: 15,),
               AppText(text:widget.ward,color: Colors.black,size: 18,),
              ],
            ),
            SizedBox(height: 30,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CarterView(
                    ward: widget.ward,
                  )));
                },
                  child: Container(
                    height: 100,
                    width: 130,
                    color: secondaryColor,
                    child: Center(
                      child: AppText(text:"View Carters",color: Colors.white,),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                InkWell(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignCarter(
                        ward: widget.ward,

                      )));
                },
                  child: Container(
                    height: 100,
                    width: 130,
                    color: secondaryColor,
                    child: Center(
                      child: AppText(text:"Assign Carters",color: Colors.white,),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateEvent(
                   id: widget.uid,
                    name: widget.name,
                  )));
                },
                  child: Container(
                    height: 100,
                    width: 130,
                    color: secondaryColor,
                    child: Center(
                      child: AppText(text:"Add Events",color: Colors.white,),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                InkWell(onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllEvents(
                    id: widget.uid,

                  )));

                },
                  child: Container(
                    height: 100,
                    width: 130,
                    color: secondaryColor,
                    child: Center(
                      child: AppText(text:"View Events",color: Colors.white,),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MessageView(
                      ward: widget.ward,

                    )));
                  },
                    child: Container(
                      height: 90,
                      width: 130,
                      color: secondaryColor,
                      child: Center(
                        child: AppText(text:"View Messages",color: Colors.white,),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllRequests_agent(
                      ward: widget.ward,

                    )));
                  },
                    child: Container(
                      height: 90,
                      width: 130,
                      color: secondaryColor,
                      child: Center(
                        child: AppText(text:"View All Request",color: Colors.white,),
                      ),
                    ),
                  ),
                ),


              ],
            ),

          ],
        ),
      )
    );
  }
}
