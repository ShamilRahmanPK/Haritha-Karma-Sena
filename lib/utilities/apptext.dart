import 'package:flutter/material.dart';


class AppText extends StatelessWidget {

  String?text;
  double? size;
  Color? color;
  FontWeight?fw;

 AppText({Key? key,this.text,this.size,this.color,this.fw}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(text!,style: TextStyle(fontSize: size,color: color,fontWeight: fw),);
  }
}
