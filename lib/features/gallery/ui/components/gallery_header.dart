





import 'package:flutter/material.dart';
import 'package:my_gallery0/features/auth/model/user_model.dart';
import 'package:my_gallery0/global/global_images.dart';

class GalleryHeaderAvatar extends StatelessWidget {
  const GalleryHeaderAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return SizedBox(
      height:height*.22,
      width:MediaQuery.of(context).size. width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: CustomPaint(

              size:  Size(height*.3,height*.15),
              painter: CurvedPainter(),

            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding:  EdgeInsets.all(height*.025),
                child: CircleAvatar(backgroundColor: Colors.white,radius: height*.03,backgroundImage: const AssetImage(profileImage)),
              ))
        ],
      ),
    ) ;
  }
}


class GalleryHeaderText extends StatelessWidget {
  final UserModel user;
  const GalleryHeaderText({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome',style: TextStyle(fontSize: height*.035)),
          Text(user.name!,style: TextStyle(fontSize: height*.035,fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}


class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {


    Paint paint0 = Paint()
      ..color = Color(0xffB28DFF)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;





    Path path0 = Path();
    path0.moveTo(size.width,0);
    path0.lineTo(size.width*0.9991667,size.height*0.9300000);
    path0.quadraticBezierTo(size.width*0.9997917,size.height*0.7167857,size.width*0.8750000,size.height*0.7157143);
    path0.cubicTo(size.width*0.6664583,size.height*0.7160714,size.width*0.6252083,size.height*0.5696429,size.width*0.6258333,size.height*0.2157143);
    path0.quadraticBezierTo(size.width*0.6247917,size.height*0.0021429,size.width*0.5016667,0);
    path0.lineTo(size.width,0);
    path0.close();


    canvas.drawPath(path0, paint0);








  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



