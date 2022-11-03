
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery0/features/gallery/repositories/gallery_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/api_keys.dart';

class GalleryProvider with ChangeNotifier{

  List? images;

  ImagePicker picker=ImagePicker();
  String? _imageUrl;
  String? get imageUrl=> _imageUrl;
  File? imageFile;
  XFile? picked;
  String? photoLoc;
bool uploading=false;




  Future<void>pickImageFromGallery()async{
    try{
      picked=await picker.pickImage(source: ImageSource.gallery);
      imageFile=File(picked!.path);

      debugPrint('image got');
      notifyListeners();
    }on Exception catch(e){debugPrint(e.toString());}


  }
  Future<void>pickImageFromCamera()async{
    try{
      picked=await picker.pickImage(source: ImageSource.camera);
      imageFile=File(picked!.path);

      debugPrint('image got');
      notifyListeners();
    }on Exception catch(e){debugPrint(e.toString());}


  }

  final _dio = Dio();


  Future<bool>uploadImage({required String token,required bool isGallery})async{

   // photoLoc=Uri.file(picked!.path).pathSegments.last;

    if(isGallery){await pickImageFromGallery();}
    else{await pickImageFromCamera();}
    uploading=true;
    if(imageFile==null){ uploading=false; return false;}

    String fileName = imageFile!.path.split('/').last;
    _dio.options.headers["Authorization"] = "Bearer $token";
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(imageFile!.path, filename:fileName)
    });


    try{
      Response response = await _dio.post(ApiData.uploadImage, data: formData);
    debugPrint('image has been uploaded');
    imageFile=null;
      uploading=false;
      await getImages(token: token);
    notifyListeners();
    return true;
    }on Exception catch(e){
      debugPrint('image upload error ');
      debugPrint(e.toString());

      notifyListeners();
      imageFile=null;
      uploading=false;
      return false;
    }


  }

getImages({required String token})async{

  images=await GalleryRepository().getGalleryImages(token: token);

  notifyListeners();
}





}

