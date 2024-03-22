import 'package:hk_sena/screens/admin/adminComplaintsHome.dart';
import 'package:hk_sena/screens/admin/assign_carter.dart';
import 'package:hk_sena/screens/admin/assignagent.dart';
import 'package:hk_sena/screens/admin/viewagents.dart';
import 'package:hk_sena/screens/admin/viewcarter.dart';
import 'package:hk_sena/screens/admin/viewgcomplaint.dart';
import 'package:hk_sena/screens/admin/viewscomplaint.dart';
import 'package:hk_sena/screens/admin/viewusers.dart';
import 'package:hk_sena/screens/admin/agentregistration.dart';
import 'package:hk_sena/screens/admin/garbagecarterRegister.dart';
import 'package:hk_sena/utilities/apptext.dart';
import 'package:flutter/material.dart';
import 'package:hk_sena/screens/admin/agentregistration.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: "Admin Home",),
        centerTitle: true,
        backgroundColor: Color(0xff006937),
        leading: IconButton(onPressed: (){

          Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false);
        }, icon: Icon(Icons.logout)),
      ),
      body: SafeArea(
        child:SingleChildScrollView(
          padding: EdgeInsets.only(left: 25,right: 25,top: 8),
          child: Column(
            children: [
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CarterRegistration()));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width,

                    child: Center(child: AppText(color: Colors.white,text: 'Register Carter',size: 20,)),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentRegistrationPage()));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width,

                    child: Center(child: AppText(color: Colors.white,text: 'Register Agent',size: 20,)),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewCarter()));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width,

                    child: Center(child: AppText(color: Colors.white,text: 'View Carter',size: 20,)),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAgent()));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width,

                    child: Center(child: AppText(color: Colors.white,text: 'View Agent',size: 20,)),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllAgents()));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width,

                    child: Center(child: AppText(color: Colors.white,text: 'View Users',size: 20,)),
                  ),
                ),
              ),
              //   SizedBox(height: 15,),
              //   InkWell(
              //    onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewscomplaint()));
              //
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       decoration: BoxDecoration(
              //           color: Colors.teal,
              //           borderRadius: BorderRadius.circular(12)
              //       ),
              //       height: 75,
              //       width: MediaQuery.of(context).size.width,
              //
              //       child: Center(child: AppText(color: Colors.white,text: 'Service Complaints',size: 20,)),
              //     ),
              //   ),
              // ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminComplaintHome()));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width,

                    child: Center(child: AppText(color: Colors.white,text: 'Complaints',size: 20,)),
                  ),
                ),
              ),


              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignAgent()));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width,

                    child: Center(child: AppText(color: Colors.white,text: 'Assign Agent',size: 20,)),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignCarterAdmin()));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    height: 75,
                    width: MediaQuery.of(context).size.width,

                    child: Center(child: AppText(color: Colors.white,text: 'Assign Carter',size: 20,)),
                  ),
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
