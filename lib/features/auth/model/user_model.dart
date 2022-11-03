const b = {
  "user": {
    "id": 23,
    "name": "Alycia Altenwerth",
    "email": "brad.stokes@example.com",
    "email_verified_at": "2022-11-01T07:19:58.000000Z",
    "created_at": "2022-11-01T07:19:58.000000Z",
    "updated_at": "2022-11-01T07:19:58.000000Z"
  },
  "token":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYTAxMjkyZmUzMDJjNGViNGJlZDVkMDk4MzM5YWY0NzZhMTZmNzljMzkzZjU0NzcwZDRjYjFkY2NhMjk3NWQ3MGUyYTFhNWM2MWNmYjM4NDgiLCJpYXQiOjE2NjczMTg4MDQuNTUxMjgsIm5iZiI6MTY2NzMxODgwNC41NTEyODcsImV4cCI6MTY5ODg1NDgwNC41NDQ1NzMsInN1YiI6IjIzIiwic2NvcGVzIjpbXX0.M8t2czZIfCybbsq2WIk8D4km5FECJI5bU8H1uam3bTuVAjuc6PWVo5rRbvC_GDBTix7CRB8kFu0UYfTu-QMvHRBXx5QBo4p9HbgFNWEvuajYh1DHhfQ1zLCjHVTF1WOk8ByTIiZWSrLkmcFDfLYTBYBEEKGL96kxHoa8--8aI-B15lLtWHBm6b7hKfoMiRqqKNbvcxzw87maFQJy1t64Bh2gq1s1AoxeqLSuAHcLn87a2_rtsqjKelCIWBwOxv2hc98OtCkMPrO1Atv6pCqcTlnoyIkqeccJ6L3EUw2pgsRVuFJYqkYuenQxwkFT9EKy-e2tVdyltStM_2875Ttg2A6UQ4Gi-cWsoLFdz-oAYJHFNfQ88kUNJGYaE3pfe6c1fgsyjRfwT0F1lddAdIaUtsLCHLF4DKCu-S3y1_ZLgiTJYTecGlGjlI13pTU6typoTDhOBX4mW0Mq7ZB-HZH69nVGd0S9oDt4f4T0gI2WfuYcQCWcOq8oIrv0ajT6kzIOOqXMOMBa5woFsvZXfUhV_jgroRNkQUISgnCK2KZ37r4f2rxerrtKVbc-OWlSLjk0_ue-5lqUX3RJRTSGVEjglLnMTLViL794FdmTGbHr2Pi2EwinAxqxKYCQyx37fga8rj59SUhIOn9skqKYg58lj_Y3tvX7AcBhV88g-azooeg"
};

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? uploadedAt;

  UserModel({
     this.id,
     this.name,
     this.email,
     this.emailVerifiedAt,
     this.createdAt,
     this.uploadedAt,
  });


 factory UserModel.fromJson({required Map <String,dynamic>map}){
   return UserModel(
     id: map['id'],
     name: map['name'],
     email: map['email'],
     emailVerifiedAt: map['email_verified_at'],
     createdAt: map['created_at'],
     uploadedAt: map['updated_at'],
   );

 }



}
