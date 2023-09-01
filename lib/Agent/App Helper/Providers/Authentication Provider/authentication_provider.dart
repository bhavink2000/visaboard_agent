// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../Api Repository/User Authentication/user_authentication.dart';
import '../../Models/App Model/login_model.dart';
import '../../Routes/App Routes/app_routes_name.dart';
import '../../Ui Helper/loading.dart';
import '../../Ui Helper/snackbar_msg_show.dart';
import 'user_data_auth_session.dart';

class AuthProvider with ChangeNotifier{

  final _myUser = UserAuthentication();

  bool _loading = false;
  bool get loading => _loading;
  setLoginLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context)async {
    LoadingIndicater().onLoad(true, context);
    setLoginLoading(true);
    _myUser.loginApi(data).then((value){
      setLoginLoading(false);
      final userDataSession = Provider.of<UserDataSession>(context, listen: false);
      userDataSession.saveUserData(
        UserLogin(
          accessToken: value['access_token'].toString(),
          encAgentId: value['enc_agent_id'],
          id: value['data']['id'],
          countryId: value['data']['country_id'],
        )
      );
      SnackBarMessageShow.successsMSG('Login Successfully', context);
      Navigator.pushNamed(context, AppRoutesName.dashboard);
      LoadingIndicater().onLoadExit(false, context);
      if (kDebugMode) {
        print(value);
      }
    }).onError((error, stackTrace){
      setLoginLoading(false);
      Navigator.pop(context);
      try {
        var errorString = error.toString();
        print("errorString -> $errorString");

        var jsonStartIndex = errorString.indexOf('{');
        print("jsonStartIndex -> $jsonStartIndex");

        var jsonEndIndex = errorString.lastIndexOf('}');
        print("jsonEndIndex -> $jsonEndIndex");

        var jsonString = errorString.substring(jsonStartIndex, jsonEndIndex + 1);
        print("jsonString -> $jsonString");

        var errorData = json.decode(jsonString) as Map<String, dynamic>;
        print("errorData -> $errorData");

        var errorObject = errorData['error'];
        print("errorObj->$errorObject");
        if(errorData['error'] == 'Unauthorized'){
          SnackBarMessageShow.warningMSG('${errorData['error']}', context);
        }
        if (errorObject != null) {
          var errorMessage = errorObject['email_id'] != null ? errorObject['email_id'][0] : null;
          var passwordError = errorObject['password'] != null ? errorObject['password'][0] : null;

          if (errorMessage != null) {
            print("in errorMessage if");
            SnackBarMessageShow.warningMSG('$errorMessage', context);
          } else if (passwordError != null) {
            print("in passwordError if");
            SnackBarMessageShow.warningMSG('$passwordError', context);
          } else {
            print("in else");
          }
        } else {
          print("No 'error' key found in the response.");
        }

        //Navigator.pop(context);
      } catch (e) {
        print('Error decoding response: $e');
        //Navigator.pop(context);
      }
      //SnackBarMessageShow.warningMSG(error.toString(), context);
    });
  }
}