import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/App Model/login_model.dart';

class UserDataSession with ChangeNotifier{

  Future<bool> saveUserData(UserLogin user)async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('access_token', user.accessToken.toString());
    sp.setString('token_type', user.tokenType.toString());
    sp.setString('enc_agent_id', user.encAgentId.toString());
    await sp.setInt('id', user.id!);
    await sp.setInt('country_id', user.countryId!);
    notifyListeners();
    return true;
  }

  Future<UserLogin> getUserData()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? accessToken = sp.getString('access_token');
    final String? tokenType = sp.getString('token_type');
    final String? encAgentId = sp.getString('enc_agent_id');
    final int? id = sp.getInt('id');
    final int? countryId = sp.getInt('country_id');

    return UserLogin(
      accessToken: accessToken.toString(),
      tokenType: tokenType.toString(),
      encAgentId: encAgentId.toString(),
      id: id,
      countryId: countryId
    );
  }

  Future<bool> removeUserData()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}