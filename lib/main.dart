import 'package:flutter/material.dart';
import '/screens/Login_page.dart';
void main(){
  runApp(const app());
}

class app extends StatelessWidget{
  const app({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(title: 'Time Capsule',
    debugShowCheckedModeBanner: false,
          theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
