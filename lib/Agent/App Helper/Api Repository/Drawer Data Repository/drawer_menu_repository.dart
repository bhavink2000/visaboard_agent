import 'package:visaboard_agent/Agent/App%20Helper/Api%20Repository/api_urls.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Api%20Service/api_service_post_get.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Api%20Service/api_service_type_post_get.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/lead_followup_model.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/lead_management_model.dart';

import '../../Models/App Model/service_requested_model.dart';
import '../../Models/Drawer Menus Model/agent_qr_code_model.dart';
import '../../Models/Drawer Menus Model/client_model.dart';
import '../../Models/Drawer Menus Model/order_visa_file_model.dart';
import '../../Models/Drawer Menus Model/order_visafile_edit_model.dart';
import '../../Models/Drawer Menus Model/ovf_chat_model.dart';
import '../../Models/Drawer Menus Model/template_model.dart';
import '../../Models/Drawer Menus Model/transaction_model.dart';
import '../../Models/Drawer Menus Model/upload_docs_model.dart';
import '../../Models/Drawer Menus Model/wallet_transaction_model.dart';

class DrawerMenuRepository{
  ApiServicesTypePostGet apiServicesTypePostGet = ApiServicePostGet();

  Future<TemplateModel> template(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getTemplate}?page=$index", access_token, '');
    try{return response = TemplateModel.fromJson(response);}catch(e){throw e;}
  }

  Future<ClientModel> clients(var index,var access_token, var cData)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getClient}?page=$index", access_token, cData);
    try{return response = ClientModel.fromJson(response);}catch(e){throw e;}
  }

  Future<TransactionModel> transaction(var index,var access_token, var data)async{
    print("in transaction url ->${"${ApiConstants.getTransaction}?page=$index"}");
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getTransaction}?page=$index", access_token, data);
    print("transaction response->$response");
    try{return response = TransactionModel.fromJson(response);}catch(e){throw e;}
  }

  Future<OrderVisaFileModel> orderVisaFile(var index,var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getOrderVisaFile}?page=$index", access_token, data);
    try{return response = OrderVisaFileModel.fromJson(response);}catch(e){throw e;}
  }

  Future<OrderVisaFileEditM> oVFEdit(var index,var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse(ApiConstants.getOVFEdit, access_token, data);
    try{return response = OrderVisaFileEditM.fromJson(response);}catch(e){throw e;}
  }

  Future<OVFChatModel> oVFChat(var index,var access_token, var uSId)async{
    print("user SOP Id ->$uSId");
    var url = "${ApiConstants.getOVFChat}$uSId/inbox";
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse(url, access_token);
    try{return response = OVFChatModel.fromJson(response);}catch(e){throw e;}
  }

  Future<WalletTransactionModel> walletTransaction(var index,var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getWalletTransaction}?page=$index", access_token, data);
    try{return response = WalletTransactionModel.fromJson(response);}catch(e){throw e;}
  }

  Future<AgentQRCodeModel> agentQRCode(var index,var access_token)async{
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse(ApiConstants.getQRCode, access_token);
    try{return response = AgentQRCodeModel.fromJson(response);}catch(e){throw e;}
  }

  Future<UploadDocsModel> uploadDocs(var uSopId,var access_token)async{
    var url = "https://visaboard.in/api/vb-agent/user/$uSopId/upload-document";
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse(url, access_token);
    try{return response = UploadDocsModel.fromJson(response);}catch(e){throw e;}
  }

  Future<ServiceRequestedModel> serviceRequested(var id,var access_token)async{
    var url = "${ApiConstants.getServiceRequested}$id/apply-sop";
    dynamic response = await apiServicesTypePostGet.aftergetApiResponse(url, access_token);
    try{return response = ServiceRequestedModel.fromJson(response);}catch(e){throw e;}
  }

  Future<LeadManagementModel> leadManagementData(var index,var access_token, var data)async{
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getLeadManagement}?page=$index", access_token, data);
    try{return response = LeadManagementModel.fromJson(response);}catch(e){throw e;}
  }

  Future<LeadFollowUpModel> leadFollowUpData(var index,var access_token, var data)async{
    print('accessToken ->$access_token');
    dynamic response = await apiServicesTypePostGet.afterpostApiResponse("${ApiConstants.getLeadFollowUp}?page=$index", access_token, data);
    try{return response = LeadFollowUpModel.fromJson(response);}catch(e){throw e;}
  }
}