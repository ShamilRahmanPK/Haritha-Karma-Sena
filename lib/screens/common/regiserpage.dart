import 'package:hk_sena/screens/admin/garbagecarterRegister.dart';
import 'package:hk_sena/screens/common/userregister.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _groupValue = "user";

  @override
  void initState() {
    _groupValue = "user";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: "user",
                            groupValue: _groupValue,
                            onChanged: (String? value) {
                              setState(() {
                                _groupValue = value!;
                              });
                            }),
                        Text("User"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: "garbageCarters",
                            groupValue: _groupValue,
                            onChanged: (String? value) {
                              setState(() {
                                _groupValue = value!;

                                print(_groupValue);
                              });
                            }),
                        Text("Carters"),
                      ],
                    ),
                  ],
                ),
                _groupValue == "user"
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.95,
                        width: MediaQuery.of(context).size.width,
                        child: UserRegistration(),
                      )
                    :  Container(
                            height: MediaQuery.of(context).size.height * 0.85,
                            width: MediaQuery.of(context).size.width,
                            child: CarterRegistration(),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
