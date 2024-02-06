import 'package:visaboard_agent/Agent/App%20Helper/Api%20Repository/api_urls.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Api%20Service/api_service_post_get.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Api%20Service/api_service_type_post_get.dart';

class UserAuthentication {
  ApiServicesTypePostGet apiServicesTypePostGet = ApiServicePostGet();

  Future<dynamic> loginApi(dynamic data)async{
    try{
      dynamic response = await apiServicesTypePostGet.postApiResponse(ApiConstants.login, data);
      return response;
    }catch(e){
      throw e;
    }
  }
}