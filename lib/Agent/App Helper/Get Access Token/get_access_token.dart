// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../Models/App Model/login_model.dart';
import '../Providers/Authentication Provider/user_data_auth_session.dart';
import '../Ui Helper/snackbar_msg_show.dart';

class GetAccessToken{
  String access_token = "",token_type = "";
  var id, enc_agent_id, countryId;
  Future<UserLogin> getUserData() => UserDataSession().getUserData();

  void checkAuthentication(BuildContext context, StateSetter setState)async{
    getUserData().then((value)async{
      if(value.accessToken == "null" || value.accessToken == ""){
        SnackBarMessageShow.warningMSG('Authentication Invalid', context);
      }
      else{
        setState((){
          access_token = value.accessToken.toString();
          token_type = value.tokenType.toString();
          id = value.id;
          enc_agent_id = value.encAgentId.toString();
          countryId = value.countryId.toString();
        });
      }
    }).onError((error, stackTrace){
      print(error);
    });
  }
}