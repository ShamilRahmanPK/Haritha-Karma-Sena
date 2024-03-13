import 'package:hk_sena/constants/colors.dart';
import 'package:hk_sena/screens/user/generalcomplaint.dart';
import 'package:hk_sena/screens/user/usercomplaints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComplaintHome extends StatefulWidget {
  var name;
  var email;
  var hno;
  var phone;
  var status;
  var uid;
  var wardno;
  ComplaintHome(
      {Key? key,
      this.name,
      this.status,
      this.phone,
      this.uid,
      this.email,
      this.wardno,
      this.hno})
      : super(key: key);

  @override
  State<ComplaintHome> createState() => _ComplaintHomeState();
}

class _ComplaintHomeState extends State<ComplaintHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
        backgroundColor: Color(0xff006937),
            title: Text("Complaints"),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [Text("Service Complaints"), Text("General Complaints")],

            ),

          ),
          body: TabBarView(

            children: [
              Tab(
                child: UserComplaints(


                  name: widget.name,
                  email: widget.email,
                  phone: widget.phone,
                  hno: widget.hno,
                  wardno: widget.wardno,
                  status: widget.status,
                  uid: widget.uid,

                ),
              ),
              Tab(
                child:Generalcomplaint(

                  name: widget.name,
                  email: widget.email,
                  phone: widget.phone,
                  hno: widget.hno,
                  wardno: widget.wardno,
                  status: widget.status,
                  uid: widget.uid,

                ),
              )
            ],
          ),
        ));

  }
}
