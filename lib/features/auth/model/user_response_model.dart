import 'package:my_gallery0/features/auth/model/user_model.dart';

class LoginResponse {
  final UserModel? user;
  final String? token;

  LoginResponse({
    this.user,
    this.token,
  });

  factory LoginResponse.fromJson({required Map<String,dynamic>map}){
    return LoginResponse(
      user: UserModel.fromJson(map: map['user']),
      token: map['token']
    );

  }
}
