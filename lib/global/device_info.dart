



import 'package:flutter/cupertino.dart';






enum DeviceType{mobile,tablet}



class DeviceInfo {


  final DeviceType? deviceType;
  final Orientation? orientation;
  final double? screenWidth ;
  final double? screenHeight ;
  final double? localWidth ;
  final double? localHeight ;

  DeviceInfo( {this.orientation,this.deviceType, this.screenWidth, this.screenHeight, this.localWidth, this.localHeight});

}
class InfoWidget extends StatelessWidget {
  final Widget Function(BuildContext context,DeviceInfo deviceInfo) builder;
  const InfoWidget({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      LayoutBuilder(builder:(context, constraints)
      {
        var mediaQueryData=MediaQuery.of(context);
        var deviceInfo=DeviceInfo(
            deviceType: getDeviceType(mediaQueryData:mediaQueryData ),
            orientation: mediaQueryData.orientation,
            screenHeight: mediaQueryData.size.height,
            screenWidth: mediaQueryData.size.width,
            localHeight: constraints.maxHeight,
            localWidth: constraints.maxWidth
        );


        return builder(context,deviceInfo);
      }



      )
    ;
  }
}












DeviceType getDeviceType({required MediaQueryData mediaQueryData}){
  Orientation orientation=mediaQueryData.orientation;
  double width=mediaQueryData.size.width;
  if(orientation==Orientation.landscape){width=mediaQueryData.size.height;}
  else{width=mediaQueryData.size.width;}

  if(width>=600){return DeviceType.tablet;}
  else{return DeviceType.mobile;}

}










