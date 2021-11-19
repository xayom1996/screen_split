import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screen_split/theme/text_theme.dart';

class ChooseScreenPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.25),
      body: SafeArea(
        child: Column(
          children: [
            Text('AAA', style: font28,)
          ]
        ),
      ),
    );
  }

}