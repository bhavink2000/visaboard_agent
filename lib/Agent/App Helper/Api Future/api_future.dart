import 'dart:convert';
import '../Models/DashBoard Model/profile_model.dart';
import 'package:http/http.dart' as http;

class ApiFuture{
  Future<ProfileModel?> getMe(String url,var id,String accesstoken)async
  {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      },
      body: {
        'id': '$id'
      }
    ).timeout(Duration(seconds: 30));
    print(response.body);
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProfileModel.fromJson(data);
    }
    else{
      return ProfileModel.fromJson(data);
    }
  }
}