import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hk_sena/screens/common/login_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    
    Future.delayed(Duration(seconds: 3), (){

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    });
    
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              width: MediaQuery.of(context).size.width,
              // right: 70,
              child: Image.asset(
                "assets/images/loginbg.png",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/logo1.png"))
                ),
              ),
              SizedBox(height: 40,),
              CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
