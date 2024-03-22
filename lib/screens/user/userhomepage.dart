import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hk_sena/constants/colors.dart';
import 'package:hk_sena/screens/user/ViewallComplaints.dart';
import 'package:hk_sena/screens/user/checkout_page.dart';
import 'package:hk_sena/screens/user/complainthome.dart';
import 'package:hk_sena/screens/user/userprofile.dart';
import 'package:hk_sena/screens/user/viewdisposalhisory.dart';
import 'package:hk_sena/utilities/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserHomepage extends StatefulWidget {
  var name;
  var email;
  var hno;
  var phone;
  var status;
  var uid;
  var wardno;
  String? imgurl;
  UserHomepage(
      {Key? key,
      this.name,
      this.imgurl,
      this.email,
      this.uid,
      this.phone,
      this.hno,
      this.status,
      this.wardno})
      : super(key: key);

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  var name;
  var walletbalance;
  TextEditingController blanceConroller = TextEditingController();
  @override
  void initState() {
    getWalletBalance();
    name = widget.name;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xff006937)),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: widget.imgurl == ""
                              ? Image.asset('assets/images/profile.png')
                              : Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              widget.imgurl.toString()),
                                          fit: BoxFit.cover)),
                                ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(widget.name.toString().toUpperCase()),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfile(
                              uid: widget.uid,
                              name: widget.name,
                              email: widget.email,
                              hno: widget.hno,
                              phone: widget.phone,
                              wardno: widget.wardno,
                            )));
              },
              title: Text("Profile"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAllDisposals(
                              id: widget.uid,
                            )));
              },
              title: Text("Disposal History"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAllComplaints(
                              uid: widget.uid,
                            )));
              },
              title: Text("View Complaints"),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/login", (Route<dynamic> route) => false));
              },
              title: Text("Logout"),
            )
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color(0xff006937),
        actions: [
          Image.asset(
            "assets/images/logo1.png",
            height: 50,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/wastemanagment.png"),
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Welcome: ',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: widget.name.toString().split(' ')[1].toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22
                                  )
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile(
                                          imgurl: widget.imgurl,
                                          uid: widget.uid,
                                          name: widget.name,
                                          email: widget.email,
                                          hno: widget.hno,
                                          phone: widget.phone,
                                          wardno: widget.wardno,
                                        )));
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: widget.imgurl == ""
                                ? Image.asset('assets/images/prof.png')
                                : Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                widget.imgurl.toString()),
                                            fit: BoxFit.cover)),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your Wallet",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 5.0,
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 20),
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xff006937),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Balance:",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Center(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('wallet')
                                            .where('walletid',
                                                isEqualTo: widget.uid)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data!.docs.length == 0) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (snapshot.hasData) {
                                            walletbalance = snapshot
                                                .data!.docs[0]['amount'];
                                            return Row(
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!.docs[0]['amount']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlueAccent,
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                walletbalance <= 50
                                                    ? Expanded(
                                                        child: IconButton(
                                                        onPressed: () {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              title: const Text(
                                                                  'Enter amount'),
                                                              content:
                                                                  Container(
                                                                height: 50,
                                                                child: Column(
                                                                  children: [
                                                                    TextFormField(
                                                                      decoration:
                                                                          InputDecoration(
                                                                              hintText: "Enter Amount"),
                                                                      controller:
                                                                          blanceConroller,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Cancel'),
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => CheckoutPage(
                                                                                  totalPrice: double.parse(blanceConroller.text),
                                                                                  bakance: snapshot.data!.docs[0]['amount'].toString(),
                                                                                  walletid: snapshot.data!.docs[0]['walletid'].toString(),
                                                                                )));
                                                                  },
                                                                  child: const Text(
                                                                      'Submit'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(Icons
                                                            .add_circle_outlined),
                                                        color: Colors.white,
                                                      ))
                                                    : SizedBox.shrink(),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 2,
                                                  color: Colors.white54,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                walletbalance <= 50
                                                    ? Text(
                                                        "Recharge \nWallet",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Container(
                                                        //color: Colors.yellow,

                                                        child: Column(
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    height: 60,
                                                                    width: 60,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .lightGreen,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child: IconButton(
                                                                        onPressed: () {
                                                                          // getWalletBalance();
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return AlertDialog(
                                                                                    content: Container(
                                                                                  height: 100,
                                                                                  width: 300,
                                                                                  child: Column(children: [
                                                                                    Text("Do you want to pick your waste"),
                                                                                    SizedBox(
                                                                                      height: 30,
                                                                                    ),
                                                                                    ElevatedButton(
                                                                                        onPressed: () {
                                                                                          if (walletbalance >= 50) {
                                                                                            FirebaseFirestore.instance.collection("wallet").doc(snapshot.data!.docs[0]['walletid']).update({
                                                                                              'amount': walletbalance - 50,
                                                                                              'updatedat': DateTime.now()
                                                                                            }).then((value) {
                                                                                              blanceConroller.text = "";
                                                                                              Navigator.pop(context);
                                                                                            }).then((value) => FirebaseFirestore.instance.collection('Request').doc(snapshot.data!.docs[0]['walletid'].toString()).set({
                                                                                                  'req_id': snapshot.data!.docs[0]['walletid'].toString(),
                                                                                                  'uid': widget.uid,
                                                                                                  'name': widget.name,
                                                                                                  'phoneno': widget.phone,
                                                                                                  'wardno': widget.wardno,
                                                                                                  'houseno': widget.hno,
                                                                                                  'amount': 50,
                                                                                                  'status': 0,
                                                                                                  'pickupstatus': 0,
                                                                                                  'bookingdate': DateTime.now()
                                                                                                }).then((value) {
                                                                                                  showsnackbar("Request submitted successfully");
                                                                                                  Navigator.pop(context);
                                                                                                }));
                                                                                          } else {
                                                                                            showsnackbar("insufficient balance");
                                                                                          }
                                                                                        },
                                                                                        style: ElevatedButton.styleFrom(
                                                                                          backgroundColor: Colors.lightGreen.shade900,
                                                                                        ),
                                                                                        child: Text(
                                                                                          "Send Request",
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        )),
                                                                                  ]),
                                                                                ));
                                                                              });
                                                                        },
                                                                        icon: Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              32,
                                                                        )),
                                                                  )
                                                                ]),
                                                          ],
                                                        ),
                                                      ),
                                              ],
                                            );
                                          }

                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text("Some Error Occured"),
                                            );
                                          }

                                          if (!snapshot.hasData) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }

                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your Recent Disposals",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 120,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Request')
                            .where('uid', isEqualTo: widget.uid)
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.hasData) {
                                    var format = new DateFormat('y-M-d');
                                    var date = format.format(snapshot
                                        .data!.docs[index]['bookingdate']
                                        .toDate());

                                    return Card(
                                      elevation: 5.0,
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        height: 80,
                                        width: 250,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                    text: "Request Send on:"),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                AppText(text: date.toString())
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(text: "Status"),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                snapshot.data!.docs[index]
                                                            ['pickupstatus'] ==
                                                        0
                                                    ? AppText(
                                                        text: "Pending",
                                                        color: Colors.red,
                                                        fw: FontWeight.w700,
                                                      )
                                                    : AppText(
                                                        text: "Picked",
                                                        color: Colors.green,
                                                        fw: FontWeight.w700,
                                                      )
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
                          if (snapshot.hasData &&
                              snapshot.data!.docs.length == 0) {
                            return Center(
                              child: Text("No Disposals"),
                            );
                          }

                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffd4af37),
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.all(20),
                    height: 80,
                    child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Register Complaints",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Container(
                              //color: Colors.red,
                              height: 80,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ComplaintHome(
                                                  name: widget.name,
                                                  email: widget.email,
                                                  phone: widget.phone,
                                                  hno: widget.hno,
                                                  wardno: widget.wardno,
                                                  status: widget.status,
                                                  uid: widget.uid,
                                                )));
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: 32,
                                  )),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "News and Events",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 130,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('events')
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            List<QueryDocumentSnapshot> stores =
                                snapshot.data!.docs;

                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    onTap: () {
                                    },
                                    child: Card(
                                      color: primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: 5.0,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 120,
                                          width: 290,
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 120,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10)),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            stores[index]
                                                                    ['imgurl']
                                                                .toString()))),
                                              ),
                                              Expanded(
                                                child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    //color: Colors.grey,

                                                    height: 150,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          stores[index]
                                                              ['title'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          stores[index]
                                                              ['description'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          )),
                                    ),
                                  );
                                });
                          }

                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ))
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future getWalletBalance() async {
    var snap = await FirebaseFirestore.instance
        .collection('wallet')
        .doc(widget.uid)
        .get();
    print(snap['amount']);
    setState(() {
      walletbalance = snap['amount'];
    });
  }

  showsnackbar(var msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.grey,
      duration: Duration(seconds: 4),
    ));
  }
}
