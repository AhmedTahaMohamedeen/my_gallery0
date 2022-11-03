import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_gallery0/features/auth/ui/components/text_fields.dart';
import 'package:my_gallery0/features/common/snack_bar.dart';
import 'package:my_gallery0/features/gallery/ui/gallery_screen.dart';
import 'package:my_gallery0/features/auth/providers/auth_provider.dart';
import 'package:my_gallery0/features/auth/model/login_model.dart';
import 'package:my_gallery0/global/global_images.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  String email='';
  String password='';
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  bool loading=false;
  emailListener(){
    setState(() {
      email=emailController.text;
    });
  }
  passwordListener(){
    setState(() {
      password=passwordController.text;
    });
  }
  @override
  void initState() {
    emailController.addListener(emailListener);
    passwordController.addListener(passwordListener);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    var authProvider=Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(logInBackground),fit: BoxFit.fill
            ),

          ),
          child: SingleChildScrollView(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: MediaQuery.of(context).size.height*.2,),

                Column(
                  children: [
                    Text('My',style: TextStyle(fontSize: height*.06,fontWeight: FontWeight.w600),),
                    Text('Gallery',style: TextStyle(fontSize: height*.06,fontWeight: FontWeight.w600),),              ],
                ),

                Padding(
                  padding:  EdgeInsets.only(top: height*.03),
                  child: Center(
                      child: ClipRect(

                        child: BackdropFilter(
                             filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                          child: Container(
                              height: height*.45,
                              width: width*.8,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.3),
                                borderRadius: BorderRadius.circular(35),



                              ),

                              child:Form(
                                key: formKey,

                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Center(child: Text('LOG IN',style: TextStyle(fontSize: height*.04,fontWeight: FontWeight.w600,color: Colors.black))),
                                      SizedBox(
                                        height: height*.06,
                                        width: width*.7,
                                        child: MyTextFormField(
                                          input: TextInputType.text,
                                          label: 'User Name',
                                          myController: emailController,
                                          ),
                                      ),
                                      SizedBox(
                                        height: height*.06,
                                        width: width*.7,
                                        child: MyTextFormField(
                                          input: TextInputType.text,
                                          label: 'Password',
                                          myController: passwordController,
                                            obsecure: true

                                          ,),
                                      ),
                                      loading?const CircularProgressIndicator():const SizedBox(),
                                      SizedBox(
                                          height: height*.06,
                                          width: width*.7,
                                          child: InkWell(
                                            overlayColor:MaterialStateProperty.all(Colors.white.withOpacity(.4)) ,
                                            borderRadius: BorderRadius.circular(10),
                                            onTap: ()async{
                                              if(email.isEmpty||password.isEmpty){
                                                showSnackBar( message:'enter userName & password' ,context:context);
                                                FocusManager.instance.primaryFocus?.unfocus();return;}

                                              else{

                                                FocusManager.instance.primaryFocus?.unfocus();
                                                setState(() {loading=true;});
                                                if( await authProvider.login(loginDataModel: LoginDataModel(email: email, password: password), context: context))
                                                              {
                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                setState(() {loading=false;});
                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const GalleryScreen(),));


                                                              }
                                                else{
                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                              setState(() {loading=false;});
                                                              showSnackBar( message:'userName or password wrong ' ,context:context);
                                                            }


                                              }
                                            },
                                            child: Material(
                                              color: Colors.blue.withOpacity(.7),
                                              borderRadius: BorderRadius.circular(10),
                                              child: Center(child: Text('SUBMIT',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: height*.018),)),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ) //

                          ),
                        ),
                      )

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
