




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar({required String message,required BuildContext context}){


  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:  Text(message,style: const TextStyle(color: Colors.blue),textAlign: TextAlign.center),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,




      ));
}