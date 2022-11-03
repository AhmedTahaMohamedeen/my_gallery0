import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_gallery0/features/auth/providers/auth_provider.dart';
import 'package:my_gallery0/features/gallery/providers/gallery_provider.dart';
import 'package:my_gallery0/features/gallery/ui/gallery_screen.dart';
import 'package:provider/provider.dart';

class UploadImageDialog extends StatefulWidget {
  const UploadImageDialog({Key? key}) : super(key: key);

  @override
  State<UploadImageDialog> createState() => _UploadImageDialogState();
}

class _UploadImageDialogState extends State<UploadImageDialog> {

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
   var galleryProvider= Provider.of<GalleryProvider>(context,listen: false);
   var authProvider= Provider.of<AuthProvider>(context,listen: false);
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,

      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX:2.0, sigmaY: 2.0,tileMode: TileMode.clamp),
          child: Container(
            width: width*.8,
            height: height*.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white,width: 1),
                color: Colors.white.withOpacity(.3)
            ),

            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                dialogButton(context: context,onTap: ()async{
                //  Navigator.pop(context);

                  if( await galleryProvider.uploadImage(token:authProvider.token!,isGallery: true)){

                   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const GalleryScreen(),), (route) => false);
                  }

                  },text: 'Gallery',image: 'gallery',color: const Color(0xffFAE3FF)),
                dialogButton(context: context,onTap: ()async{

                  if( await galleryProvider.uploadImage(token: authProvider.token!,isGallery: false)){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const GalleryScreen(),), (route) => false);
                  }




                },text: 'Camera',image: 'camera',color: const Color(0xffC7A4FF)),







              ],
            ),


          )
      ),
    );
  }

  dialogButton({required BuildContext context,required VoidCallback onTap,required String text,required String image,required Color color}){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return UnconstrainedBox(
      child: InkWell(
        onTap: onTap,
        child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            color:  color ,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.04,vertical:height*.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/images/$image.png'),height: height*.03,width: height*.03,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(text,style:  TextStyle(fontSize: height*.025,fontWeight: FontWeight.w700),),
                  ),

                ],
              ),
            )),
      ),
    );
  }
}