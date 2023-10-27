// ignore_for_file: constant_identifier_names, non_constant_identifier_names
class ApiConstants {
/*
Demo
Username :- noreply@visaboard.in
Password :- supreme@123
 */

  static String URL = "https://demo.visaboard.in/api/vb-agent/"; // demo
  //static String URL = "https://www.visaboard.in/api/vb-agent/"; // live

  static String Login = "${URL}login";
  static String deactiveUser = "${URL}user/in-active";

  static String SignUp = "${URL}signup";

  static String ForgotPassowrd = "${URL}post-forgot-password";
  static String ChangePassword = "${URL}change-password";

  static String getProfile = "${URL}edit-profile";

  static String getDashBoardCounter = "${URL}user/dashboard/counter";
  static String getWalletDashBoard = "${URL}user/sop/wallet-transaction/list";
  static String getNotification = "${URL}user/sop/list/unread";

  static String getTemplate = "${URL}get-templates-list";

  static String getQuickApply = "${URL}quick-apply";
  static String getClientList = "${URL}user/list/full-list";
  static String getCheckShowData = "${URL}letter-type/get";

  static String getClient = "${URL}user/list";
  static String getClientAdd = "${URL}user/add";
  static String getSopCalculation = "${URL}sop-calculation";
  static String CheckPaymentMethod = "${URL}user/check-available-payment-method";
  static String CheckRozarPayPayment = "${URL}user/sop/payment/razorpay-pay";
  static String CheckStripePayment = "${URL}user/sop/payment/stripe-pay";

  static String getQRCode = "${URL}user/download-qr-code";
  static String getQRSticker = "${URL}user/download-qr-code/download/sticker";
  static String getQRDownload = "${URL}user/download-qr-code/download";
  static String getQRApplyStandee = "${URL}user/download-qr-code/apply-for-standee";


  static String getWalletTransaction = "${URL}user/wallet/list";
  static String getWalletAdd = "${URL}user/wallet/add";
  static String getWalletWithdraw = "${URL}user/wallet/withdraw/add";

  static String getTransaction = "${URL}user/transaction/list";

  static String getOrderVisaFile = "${URL}user/sop/list";
  static String SendMessage = "${URL}send/message";
  static String getOVFEdit = "${URL}user/edit";
  static String getOVFUpdate = "${URL}user/update";
  static String getOVFChat = "${URL}user/sop/";

  static String getUploadDocs = "${URL}user/upload-document";

  static String getServiceRequestedAdd = "${URL}user/apply-sop";
  static String getServiceRequested = URL;

  static String getLeadManagement = "${URL}get-lead-management-list";
  static String getLeadFollowUp = "${URL}get-lead-followup-list";
}

class ApiUrls{

  static String URL = "https://www.visaboard.in/api/vbx/";

  static String getCountry = "${URL}get-country";
  static String getState = "${URL}get-state-by-country";
  static String getCity = "${URL}get-city-state-and-country";

  static String getServiceType = "${URL}get-service-type";
  static String getLetterType = "${URL}get-letter-type";
}

class SocialMedia{
  static String getIndeed = "https://www.visaboard.in/assets/images/linkedin.png";
  static String getFacebook = "https://www.visaboard.in/assets/images/facebook.png";
  static String getInstagram = "https://www.visaboard.in/assets/images/instagram.png";
  static String getTwitter = "https://www.visaboard.in/assets/images/twitter.png";
  static String getYoutube = "https://www.visaboard.in/assets/images/youtube.png";
  static String getWebSite = "https://www.visaboard.in/assets/images/website.png";
}