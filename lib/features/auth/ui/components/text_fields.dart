
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {

  TextEditingController? myController ;
  final String label;

  final bool obsecure;
  final TextInputType input;
  // final String? Function(String?) vFuntion;
  // final  String? Function(String?) sFuntion;
  //Function ontapFunction;

  MyTextFormField({Key? key,
    required this.label,
    this.obsecure = false,

    // required this.vFuntion,
    // required this.sFuntion,
    this.myController,
    required this.input


  }) : super(key: key);

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  double borderWidth = 0;

  Color borderColor = Colors.white;

  double borderRadus = 30;

  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return TextFormField(
      style:  TextStyle(
          color: Colors.blue,
          fontSize: height*.016
      ),
      decoration: InputDecoration(
          fillColor: Colors.white,



          filled: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.all(20),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: widget.label,

          labelStyle: TextStyle(
            color: Colors.black45, fontSize: height*.015, fontWeight: FontWeight.bold,),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadus),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          )),
      obscureText: widget.obsecure,
      textInputAction: TextInputAction.done,
      keyboardType: widget.input,
      enabled: true,

      // validator:widget.vFuntion ,
      //  onSaved:widget.sFuntion ,
      // onTap: ontapFunction,
      controller: widget.myController,
    );
  }
}