class GalleryResponse{


  final String? status;
  final Map<String,dynamic>? data;

  final String? message;

  GalleryResponse({this.status, this.data, this.message});

  factory GalleryResponse.fromJson({required Map <String, dynamic>map}){
    return
      GalleryResponse(
        status: map['status'],
        message: map['message'],
        data: map['data']

      );
  }
}