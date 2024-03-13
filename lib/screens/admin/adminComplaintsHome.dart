import 'package:hk_sena/screens/admin/admin_viewallcomplaints.dart';
import 'package:hk_sena/screens/admin/serviceComplaintsAdmin.dart';
import 'package:hk_sena/screens/user/generalcomplaint.dart';
import 'package:hk_sena/screens/user/usercomplaints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminComplaintHome extends StatefulWidget {

  AdminComplaintHome(
      {Key? key,
        })
      : super(key: key);

  @override
  State<AdminComplaintHome> createState() => _AdminComplaintHomeState();
}

class _AdminComplaintHomeState extends State<AdminComplaintHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Complaints"),
            backgroundColor: Colors.teal,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [ Text("General Complaints"),Text("Service Complaints"),],
            ),
          ),
          body: TabBarView(

            children: [
              Tab(
                child: ViewAllComplaintsAdmin(),
              ),
              Tab(
                child:ServiceComplaintsAdmin()
              )
            ],
          ),
        ));

    //   Scaffold(
    //   appBar: AppBar(
    //     bottom: TabBar(
    //       tabs: [
    //
    //         Text("Service Complaints"),
    //         Text("General Complaints")
    //       ],
    //     ),
    //   ),
    //   body: DefaultTabController(
    //     length: 2,
    //     child: TabBarView
    //       (
    //       children: [
    //
    //         Tab(
    //           child: Text("hello"),
    //         ),
    //         Tab(
    //           child: Text("Helo 1"),
    //         )
    //       ],
    //     ),
    //   )
    // );
  }
}
