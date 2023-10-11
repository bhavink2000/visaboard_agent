import 'package:flutter/cupertino.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Api%20Repository/Drawer%20Data%20Repository/drawer_menu_repository.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Enums/api_response_type.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/lead_followup_model.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/lead_management_model.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/order_visa_file_model.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Models/Drawer%20Menus%20Model/template_model.dart';
import '../../Models/App Model/service_requested_model.dart';
import '../../Models/Drawer Menus Model/agent_qr_code_model.dart';
import '../../Models/Drawer Menus Model/client_model.dart';
import '../../Models/Drawer Menus Model/order_visafile_edit_model.dart';
import '../../Models/Drawer Menus Model/ovf_chat_model.dart';
import '../../Models/Drawer Menus Model/transaction_model.dart';
import '../../Models/Drawer Menus Model/upload_docs_model.dart';
import '../../Models/Drawer Menus Model/wallet_transaction_model.dart';


class AgentDrawerMenuProvider with ChangeNotifier{
  final drawerRepo = DrawerMenuRepository();

  ApiResponseType<TemplateModel> templateDataList = ApiResponseType.loading();
  setTemplateResponse(ApiResponseType<TemplateModel> response){
    templateDataList = response;
    notifyListeners();
  }
  Future<void> fetchTemplate(var index,var access_token)async{
    setTemplateResponse(ApiResponseType.loading());
    drawerRepo.template(index,access_token).then((value){
      setTemplateResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setTemplateResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<ClientModel> clientDataList = ApiResponseType.loading();
  setClientResponse(ApiResponseType<ClientModel> clientResponse){
    clientDataList = clientResponse;
    notifyListeners();
  }
  Future<void> fetchClient(var index,var access_token, var cData)async{
    setClientResponse(ApiResponseType.loading());
    drawerRepo.clients(index,access_token, cData).then((value){
      setClientResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setClientResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<TransactionModel> transactionDataList = ApiResponseType.loading();
  setTransactionResponse(ApiResponseType<TransactionModel> transactionResponse){
    transactionDataList = transactionResponse;
    notifyListeners();
  }
  Future<void> fetchTransaction(var index,var access_token, var data)async{
    print("in fetchTransaction");
    setTransactionResponse(ApiResponseType.loading());
    drawerRepo.transaction(index,access_token, data).then((value){
      setTransactionResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setTransactionResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<OrderVisaFileModel> orderVisaFileDataList = ApiResponseType.loading();
  setOrderVisaFileResponse(ApiResponseType<OrderVisaFileModel> orderVisaFileResponse){
    orderVisaFileDataList = orderVisaFileResponse;
    notifyListeners();
  }
  Future<void> fetchOrderVisaFile(var index,var access_token, var data)async{
    setOrderVisaFileResponse(ApiResponseType.loading());
    drawerRepo.orderVisaFile(index,access_token, data).then((value){
      setOrderVisaFileResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setOrderVisaFileResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<OrderVisaFileEditM> oVFEditData = ApiResponseType.loading();
  setOVFEditResponse(ApiResponseType<OrderVisaFileEditM> oVFEditResponse){
    oVFEditData = oVFEditResponse;
    notifyListeners();
  }
  Future<void> fetchOVFEdit(var index,var access_token, var data)async{
    setOVFEditResponse(ApiResponseType.loading());
    drawerRepo.oVFEdit(index,access_token, data).then((value){
      setOVFEditResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setOVFEditResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<OVFChatModel> oVFChatData = ApiResponseType.loading();
  setOVFChatResponse(ApiResponseType<OVFChatModel> oVFChatResponse){
    oVFChatData = oVFChatResponse;
    notifyListeners();
  }
  Future<void> fetchOVFChat(var index,var access_token, var uSOPId)async{
    setOVFChatResponse(ApiResponseType.loading());
    drawerRepo.oVFChat(index,access_token,uSOPId).then((value){
      setOVFChatResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setOVFChatResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<WalletTransactionModel> walletTDataList = ApiResponseType.loading();
  setWalletTResponse(ApiResponseType<WalletTransactionModel> walletTResponse){
    walletTDataList = walletTResponse;
    notifyListeners();
  }
  Future<void> fetchWalletTransaction(var index,var access_token, var data)async{
    setWalletTResponse(ApiResponseType.loading());
    drawerRepo.walletTransaction(index,access_token, data).then((value){
      setWalletTResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setWalletTResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<AgentQRCodeModel> agentQRDataList = ApiResponseType.loading();
  setAgentQRResponse(ApiResponseType<AgentQRCodeModel> agentQRResponse){
    agentQRDataList = agentQRResponse;
    notifyListeners();
  }
  Future<void> fetchAgentQRCode(var index,var access_token)async{
    setAgentQRResponse(ApiResponseType.loading());
    drawerRepo.agentQRCode(index,access_token).then((value){
      setAgentQRResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setAgentQRResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<UploadDocsModel> uploadDOcsData = ApiResponseType.loading();
  setUDocsResponse(ApiResponseType<UploadDocsModel> uDocsResponse){
    uploadDOcsData = uDocsResponse;
    notifyListeners();
  }
  Future<void> fetchUploadDocs(var user_s_id,var access_token)async{
    setUDocsResponse(ApiResponseType.loading());
    drawerRepo.uploadDocs(user_s_id,access_token).then((value){
      setUDocsResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setUDocsResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<ServiceRequestedModel> serviceRData = ApiResponseType.loading();
  setServiceRResponse(ApiResponseType<ServiceRequestedModel> serviceRResponse){
    serviceRData = serviceRResponse;
    notifyListeners();
  }
  Future<void> fetchServiceR(var user_s_id,var access_token)async{
    setServiceRResponse(ApiResponseType.loading());
    drawerRepo.serviceRequested(user_s_id,access_token).then((value){
      setServiceRResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setServiceRResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<LeadManagementModel> leadManageDataList = ApiResponseType.loading();
  setLeadMResponse(ApiResponseType<LeadManagementModel> LeadMResponse){
    leadManageDataList = LeadMResponse;
    notifyListeners();
  }
  Future<void> fetchLeadManagement(var index,var access_token, var data)async{
    setLeadMResponse(ApiResponseType.loading());
    drawerRepo.leadManagementData(index,access_token, data).then((value){
      setLeadMResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setLeadMResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

  ApiResponseType<LeadFollowUpModel> leadFollowUpList = ApiResponseType.loading();
  setLeadFResponse(ApiResponseType<LeadFollowUpModel> LeadFResponse){
    leadFollowUpList = LeadFResponse;
    notifyListeners();
  }
  Future<void> fetchLeadFollowUp(var index,var access_token, var data)async{
    setLeadFResponse(ApiResponseType.loading());
    drawerRepo.leadFollowUpData(index,access_token, data).then((value){
      setLeadFResponse(ApiResponseType.complate(value));
    }).onError((error, stackTrace){
      setLeadFResponse(ApiResponseType.error(error.toString()));
      print(error.toString());
    });
  }

}