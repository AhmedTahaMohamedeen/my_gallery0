import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_gallery0/features/gallery/models/gallery_response.dart';
import 'package:my_gallery0/global/api_keys.dart';

class GalleryRepository{


  final _dio = Dio();

  Future<List>getGalleryImages({required String token})async{

    _dio.options.headers["Authorization"] = "Bearer $token";

    List images=[];

    try {
      Response response = await _dio.get(ApiData.myGallery, );
      debugPrint(response.toString());
      if(response.statusCode==200){
        GalleryResponse galleryResponse = GalleryResponse.fromJson(map:response.data);

        images=galleryResponse.data!['images']!;






        return images;
      }
      else{return images;}



    } catch (error) {
      debugPrint(error.toString());
      debugPrint('error in login');
      return images;
    }

  }
}