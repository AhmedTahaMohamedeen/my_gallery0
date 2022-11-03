

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_gallery0/features/auth/model/user_model.dart';
import 'package:my_gallery0/features/auth/providers/auth_provider.dart';
import 'package:my_gallery0/features/auth/ui/login_screen.dart';
import 'package:my_gallery0/features/gallery/repositories/gallery_repository.dart';
import 'package:my_gallery0/features/gallery/ui/components/gallery_header.dart';
import 'package:my_gallery0/features/gallery/ui/components/gallery_helper.dart';
import 'package:my_gallery0/features/gallery/ui/components/upload_dialog.dart';
import 'package:my_gallery0/global/device_info.dart';
import 'package:my_gallery0/features/gallery/providers/gallery_provider.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
List? images;
  UserModel? user;


  getImages()async{
     await Provider.of<GalleryProvider>(context,listen: false).getImages(token:  Provider.of<AuthProvider>(context,listen: false).token!);

  // var images0=await  GalleryRepository().getGalleryImages(token: Provider.of<AuthProvider>(context,listen: false).token!);
     setState(() {
       images=Provider.of<GalleryProvider>(context,listen: false).images;
      // images=images0;
     });


  }

  getUserData(){
    setState(() {
      user= Provider.of<AuthProvider>(context,listen: false).user;
    });
  }
  @override
  void initState() {super.initState();
   // getImages();
    getUserData();

  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

   var deviceType= getDeviceType(mediaQueryData:MediaQuery.of(context) );
    return SafeArea(
      child:


      Consumer<GalleryProvider>(

        builder: (context,value,child) {
          images=value.images;
          return Scaffold(

            backgroundColor: const Color(0xffEDD4FE),
            body: Stack(
              children: [

                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(gradient: backgroundGradient),),
                CustomScrollView(

                  slivers: [

                    SliverList(delegate:  SliverChildListDelegate.fixed(
                        [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  const GalleryHeaderAvatar(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      user==null||user!.name==null?const SizedBox():GalleryHeaderText(user: user!),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(vertical: height*.02),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buttonItem(
                                      onTap: ()async{
                                        if( await  Provider.of<AuthProvider>(context,listen: false).logOut()){
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);

                                        }
                                      },
                                        text:'log out',
                                      width: width,
                                      height: height,
                                       gradient: redGradient,
                                      shadowColor: Colors.red,
                                      icon: Icons.logout_rounded,
                                      isUploading:false
                                    ),


                                    _buttonItem(
                                        onTap:(){
                                          showDialog(context: context, builder: (context) => const UploadImageDialog(),);
                                        },
                                        text:'upload',
                                        width: width,
                                        height: height,
                                        gradient: orangeGradient,
                                        shadowColor: Colors.orange,
                                        icon: Icons.cloud_upload_rounded,
                                        isUploading:value.uploading
                                    ),

                                  ],
                                ),
                              )
                            ],
                          )
                        ]
                    )),
                    images==null
                        ? const SliverList(delegate:  SliverChildListDelegate.fixed([Center(child: CircularProgressIndicator(),)]))


                        : SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: width*.025,vertical: height*.02),

                          sliver:   SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context,index){


                            return


                             // _image(imageUrl: images![index])
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'sorry i have a problem in display image , i tried to solve it, it maybe in my device memory but every thing works well '),
                                ),
                              ),

                            )








                           ; },
                          childCount: images!.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).orientation==Orientation.landscape ||deviceType==DeviceType.tablet ?4: 3,
                          childAspectRatio:MediaQuery.of(context).orientation==Orientation.landscape ||deviceType==DeviceType.tablet ?1:1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 30,

                        ),

                      ),


                    )


                  ],
                ),
              ],
            ),




          );
        }
      )
    );
  }

  bool isLoading=false;
 Widget _image({required String imageUrl}){
    return  Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),


      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Transform.scale(scale: 0.4, child: const CircularProgressIndicator(color: Colors.blue)),
        errorWidget:  (context, url, error) => const Icon(Icons.error, color: Colors.blue),
        fit: BoxFit.cover,




      ),
    );
  }



Widget _buttonItem({required double width,
  required double height,
  required VoidCallback onTap,
  required LinearGradient gradient,
  required Color shadowColor,
  required String text,
  required IconData icon,
required bool isUploading ,
}){

    return InkWell(
      onTap: onTap,
      child: Container(
        // height: height*.04,
        width: width*.35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white

        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*.025,vertical: 4),
          child:

          isUploading?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('uploading...',style: TextStyle(fontSize:  height*.018,fontWeight: FontWeight.w500),),
                  const CircularProgressIndicator()
                ],
              )

              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [



              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: gradient,
                    boxShadow: [BoxShadow(color: shadowColor.withOpacity(.2),spreadRadius:.1 ,blurRadius: 10)]
                ),

                alignment: Alignment.center,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal:width*.016 ,vertical: height*.008),
                  child: Icon(icon,color: Colors.white,size: height*.02,),
                ),
              ),
               Text(text,style: TextStyle(fontSize:  height*.018,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
    );
  }


}





