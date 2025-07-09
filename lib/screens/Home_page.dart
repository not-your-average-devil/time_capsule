import 'package:flutter/material.dart';
import 'package:time_capsule/screens/Capsule_page.dart';
import 'package:time_capsule/utils/colors.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Time Capsule'), backgroundColor: AppColors.secondary,),
      body: Center(
       
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => CapsulePage()));
      }, 
      backgroundColor: Colors.white,
       child: Image.asset('assets/images/quil.png', height: 24)),
    );
  }
} 