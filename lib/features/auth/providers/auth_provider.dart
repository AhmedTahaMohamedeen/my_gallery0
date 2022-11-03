

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_gallery0/global/api_keys.dart';
import 'package:my_gallery0/features/auth/model/login_model.dart';
import 'package:my_gallery0/features/auth/model/user_model.dart';
import 'package:my_gallery0/features/auth/model/user_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier{

  UserModel? user;
  String? email;
  String? password;
  String? token;
  final _dio = Dio();










  Future<bool>login({required LoginDataModel loginDataModel,required BuildContext context})async{



    FormData formData =  FormData.fromMap({
      "email": loginDataModel.email,
      "password": loginDataModel.password,
    });


    try {
      Response response = await _dio.post(ApiData.login, data: formData,);
      debugPrint(response.toString());
      if(response.statusCode==200){
        LoginResponse loginResponse = LoginResponse.fromJson(map:response.data);


        await setDataToCaches(loginDataModel:loginDataModel,loginResponse: loginResponse );
        updateProvider(loginResponse: loginResponse);



        return true;
      }
      else{return false;}



    } catch (error) {
      debugPrint(error.toString());
      debugPrint('error in login');
      return false;
    }



  }

  Future<bool> loginWithCached({required BuildContext context})async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var loggedIn=pref.getBool('loggedIn');
    if(loggedIn==null||!loggedIn){return false;}
    else{
      var email=pref.getString('email');
      var password=pref.getString('password');
      if(email==null||password==null){return false;}
      if( await  login(loginDataModel: LoginDataModel(email: email, password: password), context: context)){return true;}
      else{return false;}

    }
  }
  Future<bool>logOut()async{
    SharedPreferences pref=await SharedPreferences.getInstance();

    await pref.remove('email');
    await pref.remove('password');
    await pref.remove('loggedIn');
    await pref.remove('token');
return true;
  }





  getCachedData()async{
    SharedPreferences pref=await SharedPreferences.getInstance();

    email=pref.getString('email');
    password=pref.getString('password');
    token=pref.getString('token');

  }
  setDataToCaches({required LoginResponse loginResponse,required LoginDataModel loginDataModel})async{
    SharedPreferences pref=await SharedPreferences.getInstance();


    await pref.setString('token', loginResponse.token!);
    await pref.setBool('loggedIn',true);
    await pref.setString('email',loginDataModel.email!);
    await pref.setString('password',loginDataModel.password!);



  }


  updateProvider({required LoginResponse loginResponse}){
    user=loginResponse.user;
    token=loginResponse.token;
  }




}