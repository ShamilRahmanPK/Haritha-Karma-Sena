import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:uuid/uuid.dart';

class CheckoutPage extends StatefulWidget {
 var walletid;
 var bakance;
  final double totalPrice; // You need to calculate the total price based on your logic

  CheckoutPage({ required this.totalPrice,this.bakance,this.walletid});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  double estimatedTax = 0.0;
  double subtotal = 0.0;
  double total = 0.0;
  late Razorpay _razorpay = Razorpay();


  String? _uid;

  List<String>? courses;


  void handlePaymentErrorResponse(PaymentFailureResponse response){

    /** PaymentFailureResponse contains three values:
     * 1. Error Code
     * 2. Error Description
     * 3. Metadata
     **/
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {

    /** Payment Success Response contains three values:
     * 1. Order ID
     * 2. Payment ID
     * 3. Signature
     **/

    if(response.paymentId!=null){
var id=Uuid().v1();






{
  FirebaseFirestore
      .instance
      .collection(
      "wallet")
      .doc(widget.walletid)
      .update({
    'amount':  double.parse(widget.bakance) +
        double.parse(widget.totalPrice.toString()),
    'updatedat':
    DateTime
        .now()
  }).then((value) {

    Navigator.pop(
        context);
  });
  //fiirebasecode
}

    }



    //showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }
  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Map<String, dynamic> generateRazorpayOptions() {
    return {
      'key': 'rzp_test_7ERJiy5eonusNC',
      'amount': (total * 100).toInt(), // Convert total to integer (paise)
      'name': 'Mentor U',
      'description': 'Wallet Recahrge',
      'prefill': {
        'contact': '7994203373',
        'email': 'support@HK_sena.com'
      }
    };
  }
  @override
  void initState() {

    calculateTotalValues();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    super.initState();
  }

  void calculateTotalValues() {
    // Adjust the tax rate based on your requirements
    double taxRate = 0.18;

    // Calculate the subtotal, estimated tax, and total
    subtotal = widget.totalPrice;
    estimatedTax = subtotal * taxRate;
    total = subtotal + estimatedTax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xff006937),
        title: Text('Checkout',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Text(
              'Cost Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
            ),
            SizedBox(height: 8),

            // Text(
            //   '${widget.course!['title']} - ${widget.course!['description']}',
            //   style: TextStyle(fontSize: 16,color: Colors.white),
            // ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Subtotal: \$${widget.totalPrice.toStringAsFixed(2)}',
                   textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                ),
              ],
            ),
            Divider(
              thickness: 1.5, color: Colors.teal,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Estimated Tax (18%): \$${estimatedTax.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amount including GST:",style: TextStyle(fontSize: 18),),
                Text(
                  'Total: \$${total.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                ),
              ],
            ),
            Divider(
              thickness: 1.5, color: Colors.teal,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                try{
                  _razorpay.open(generateRazorpayOptions());
                }catch(e){
                  print(e);
                }
                // Implement your payment logic here
                // You may want to use a payment gateway or navigate to a payment screen
                // For simplicity, let's print a message for now
                print('Payment successful. Course joined!');
                // You can also call the joinCourse method here if payment is successful
                // courseService.joinCourse(course.id, userId, booking);
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
