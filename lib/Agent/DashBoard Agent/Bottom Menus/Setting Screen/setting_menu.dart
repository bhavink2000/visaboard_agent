//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:visaboard_agent/Agent/App%20Helper/Get%20Access%20Token/get_access_token.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Routes/App%20Routes/app_routes_name.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/snackbar_msg_show.dart';
import '../../../App Helper/Api Future/api_future.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Models/DashBoard Model/profile_model.dart';
import '../../../App Helper/Providers/Dashboard Data Provider/dashboard_data_provider.dart';
import '../../../App Helper/Ui Helper/loading.dart';
import '../../../App Helper/Ui Helper/loading_always.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  GetAccessToken getAccessToken = GetAccessToken();
  //DashboardDataProvider dashboardDataProvider = DashboardDataProvider();

  bool isLoading = true;
  var id;
  TextEditingController firstnm = TextEditingController();
  TextEditingController middlenm = TextEditingController();
  TextEditingController lastnm = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController alternateemail = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController landlinemobile = TextEditingController();

  TextEditingController companyname = TextEditingController();
  TextEditingController companyaddress = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postcode = TextEditingController();

  TextEditingController bankname = TextEditingController();
  TextEditingController accountname = TextEditingController();
  TextEditingController accountno = TextEditingController();
  TextEditingController ifscno = TextEditingController();
  TextEditingController bankaddress = TextEditingController();

  TextEditingController gstno = TextEditingController();

  TextEditingController linkedinurl = TextEditingController();
  TextEditingController facebookurl = TextEditingController();
  TextEditingController instagramurl = TextEditingController();
  TextEditingController twitterurl = TextEditingController();
  TextEditingController youtubenurl = TextEditingController();
  TextEditingController websitenurl = TextEditingController();

  bool yesNo = true;
  File profileFile;
  File businessFile;
  String statusPPD = "";


  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getProfile();
      });
    });
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        _getCountryList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: isLoading == false ? SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                "Give a refer and earn money. Your referral code is visa0002",
                style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold),textAlign: TextAlign.center,
              ),
            ),
            formShowData('First Name', firstnm),
            formShowData('Middle Name', middlenm),
            formShowData('Last Name', lastnm),
            formShowData('Email', email),
            formShowData('Alternate Email', alternateemail),
            formShowData('Mobile', mobile),
            formShowData('Land Line No', landlinemobile),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Business Registration Proof (if applicable)",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                  ),
                  Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: PrimaryColorOne
                              ),
                              onPressed: ()async {
                                try{
                                  FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
                                  if(pickedfile != null){
                                    setState((){
                                      businessFile = File(pickedfile.files.single.path);
                                    });
                                  }
                                }
                                on PlatformException catch (e) {
                                  print(" File not Picked ");
                                }
                              },
                              child: businessFile == null
                                  ? const Text("Choose File",style: TextStyle(color: Colors.white))
                                  : const Text("File Picked",style: TextStyle(color: Colors.white))
                          ),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: businessFile == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Text(businessFile.path.split('/').last,style: const TextStyle(fontSize: 9),)
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            formShowData('Address', address),
            formShowData('Post Code', postcode),
            formShowData('Company Name', companyname),
            formShowData('Company Address', companyaddress),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: yesNo,
                    onChanged: (bool value) {
                      setState(() {
                        yesNo = value;
                      });
                    },
                  ),
                  Expanded(child: Text("Send Email Notification to your alternate email",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.red.withOpacity(0.8)),))
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Profile photo (optional) (only JPG or PNG)",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),)
                  ),
                  Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: PrimaryColorOne
                              ),
                              onPressed: ()async {
                                try{
                                  FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
                                  if(pickedfile != null){
                                    setState((){
                                      profileFile = File(pickedfile.files.single.path);
                                    });
                                  }
                                }
                                on PlatformException catch (e) {
                                  print(" File not Picked ");
                                }
                              },
                              child: profileFile == null
                                  ? const Text("Choose File",style: TextStyle(color: Colors.white))
                                  : const Text("File Picked",style: TextStyle(color: Colors.white))
                          ),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: profileFile == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Text(profileFile.path.split('/').last,style: const TextStyle(fontSize: 9),)
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("Proprietor / Partner / Director",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1),)
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: MediaQuery.of(context).size.height / 20,
                            child: RadioListTile(
                              title: Text("Proprietor",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                              value: "Proprietor",
                              groupValue: statusPPD,
                              onChanged: (value){
                                setState(() {
                                  statusPPD = value.toString();
                                });
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            height: MediaQuery.of(context).size.height / 20,
                            child: RadioListTile(
                              title: Text("Partner",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                              value: "Partner",
                              groupValue: statusPPD,
                              onChanged: (value){
                                setState(() {
                                  statusPPD = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 20,
                    child: RadioListTile(
                      title: Text("Director",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),),
                      value: "Director",
                      groupValue: statusPPD,
                      onChanged: (value){
                        setState(() {
                          statusPPD = value.toString();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            formShowData('Bank Name', bankname),
            formShowData('Account No', accountno),
            formShowData('Account Name', accountname),
            formShowData('IFSC No', ifscno),
            formShowData('Bank Address', bankaddress),
            formShowData('GST No', gstno),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                padding: const EdgeInsets.fromLTRB(10, 2, 0, 2),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Country',
                      hintStyle: TextStyle(fontSize: 12)
                  ),
                  value: _selectedCountry,
                  isExpanded: true,
                  onTap: (){
                    if(_selectedState == null && _selectedCity == null){
                      setState(() {
                        _getStateList(_selectedCountry);
                      });
                    }
                    else{
                      setState(() {
                        _selectedCity = null;
                        _selectedState = null;
                        _getCountryList();
                      });
                    }
                  },
                  onChanged: (country) {
                    if(_selectedState == null && _selectedCity == null){
                      setState(() {
                        _selectedCountry = country;
                        _getStateList(_selectedCountry);
                      });
                    }
                    else{
                      setState(() {
                        _selectedCity = null;
                        _selectedState = null;
                        _getCountryList();
                      });
                    }
                  },
                  items: countryList?.map((item) {
                    return DropdownMenuItem(
                      value: item['id'].toString(),
                      child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                    );
                  })?.toList() ?? [],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                padding: const EdgeInsets.fromLTRB(10, 2, 0, 2),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'State',
                      hintStyle: TextStyle(fontSize: 12)
                  ),
                  value: _selectedState,
                  isExpanded: true,
                  onTap: (){
                    if(_selectedCity == null){
                      setState(() {
                        _getCityList(_selectedCountry,_selectedState);
                      });
                    }
                    else{
                      setState(() {
                        _selectedCity = null;
                        _getStateList(_selectedCountry);
                      });
                    }
                  },
                  onChanged: (state) {
                    if(_selectedCity == null){
                      setState(() {
                        _selectedState = state;
                        _getCityList(_selectedCountry,_selectedState);
                      });
                    }
                    else{
                      setState(() {
                        _selectedCity = null;
                        _getStateList(_selectedCountry);
                      });
                    }
                  },
                  items: stateList?.map((item) {
                    return DropdownMenuItem(
                      value: item['id'].toString(),
                      child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                    );
                  })?.toList() ?? [],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                padding: const EdgeInsets.fromLTRB(20, 2, 0, 2),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'City',
                      hintStyle: TextStyle(fontSize: 12)
                  ),
                  value: _selectedCity,
                  isExpanded: true,
                  onChanged: (city) {
                    setState(() {
                      _selectedCity = city;
                    });
                  },
                  items: cityList?.map((item) {
                    return DropdownMenuItem(
                      value: item['id'].toString(),
                      child: Text(item['name'],style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                    );
                  })?.toList() ?? [],
                ),
              ),
            ),

            formShowData('Linked-In URL', linkedinurl),
            formShowData('Facebook URL', facebookurl),
            formShowData('Instagram URL', instagramurl),
            formShowData('Twitter URL', twitterurl),
            formShowData('YouTube URL', youtubenurl),
            formShowData('WebSite URL', websitenurl),

            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Container(
                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(30)),color: PrimaryColorOne),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: (){
                            businessFile = null;
                            firstnm.text = null;
                            middlenm.text = null;
                            lastnm.text = null;
                            email.text = null;
                            mobile.text = null;
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const VerticalDivider(thickness: 1.5,color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: (){
                            if(firstnm.text.isEmpty || middlenm.text.isEmpty || lastnm.text.isEmpty || email.text.isEmpty || mobile.text.isEmpty){
                              SnackBarMessageShow.warningMSG('Fill All Field', context);
                            }else{
                              if(businessFile == null || profileFile == null){
                                SnackBarMessageShow.warningMSG('Please Select File ', context);
                              }
                              else{
                                updateProfile();
                              }
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ) : const CenterLoading()
    );
  }

  Widget formShowData(var label , TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 7,
        child: TextField(
          controller: controller,
          style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 15),
          decoration: InputDecoration(
              helperText: '$label',
              helperStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10)
          ),
        ),
      ),
    );
  }
  Future<ProfileModel> profileOBJ;
  List<ProfileData> profileData = [];
  getProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      profileOBJ = ApiFuture().getMe(ApiConstants.getProfile,getAccessToken.id,getAccessToken.access_token);
      await profileOBJ.then((value) async {
        profileData.add(value.data);
      });
      id = profileData[0].id;
      firstnm.text = profileData[0].firstName;
      middlenm.text = profileData[0].middleName;
      lastnm.text = profileData[0].lastName;
      mobile.text = profileData[0].mobileNo;
      landlinemobile.text = profileData[0].altMobileNo;
      email.text = profileData[0].emailId;
      alternateemail.text = profileData[0].altEmailId;

      companyname.text = profileData[0].companyName;
      companyaddress.text = profileData[0].companyAddress;
      postcode.text = profileData[0].postCode;
      address.text = profileData[0].address;

      bankname.text = profileData[0].bankName;
      accountname.text = profileData[0].accountName;
      accountno.text = profileData[0].accountNo;
      ifscno.text = profileData[0].ifscNo;
      bankaddress.text = profileData[0].bankAddress;
      gstno.text = profileData[0].gstNo;

      linkedinurl.text = profileData[0].linkedinLink;
      facebookurl.text = profileData[0].facebookLink;
      twitterurl.text = profileData[0].twitterLink;
      instagramurl.text = profileData[0].instagramLink;
      youtubenurl.text = profileData[0].youtubeLink;
      websitenurl.text = profileData[0].websiteLink;

      setState(() {
        isLoading = false;
      });
    } on SocketException {
      setState(() {
        isLoading = false;
      });
      SnackBarMessageShow.warningMSG('Internet Connection Problem', context);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      SnackBarMessageShow.errorMSG('Data Fetching Error', context);
      print(e);
    }
  }

  Future updateProfile()async{
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'id': '${getAccessToken.id}',
      'first_name': firstnm.text,
      'middle_name' : middlenm.text,
      'last_name': lastnm.text,
      'opd_status': '0',
      'company_name': companyname.text,
      'company_address': companyaddress.text,
      'alt_email_id' : alternateemail.text,
      'post_code' : postcode.text,
      'address' : address.text,
      'both_send_email_status': '0',
      'country_id' : _selectedCountry,
      'state_id' : _selectedState,
      'city_id' : _selectedCity,
      'mobile_no' : mobile.text,
      'alt_mobile_no' : landlinemobile.text,

      'bank_name' : bankname.text,
      'account_name' : accountname.text,
      'account_no' : accountno.text,
      'ifsc_no' : ifscno.text,
      'bank_address' : bankaddress.text,
      'gst_no' : gstno.text,

      'linkedin_link' : linkedinurl.text,
      'facebook_link' : facebookurl.text,
      'instagram_link' : instagramurl.text,
      'twitter_link' : twitterurl.text,
      'youtube_link' : youtubenurl.text,
      'website_link' : websitenurl.text,
      'image': await MultipartFile.fromFile(profileFile.path).then((value){
        print("File Uploads");
      }).onError((error, stackTrace){
        print("error $error");
      }),
      'business_registration_proof': await MultipartFile.fromFile(businessFile.path).then((value){
        print("File Uploads");
      }).onError((error, stackTrace){
        print("error $error");
      }),
    });

    await dio.post(
        ApiConstants.getProfile,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    ).then((response) {
      if(response.statusCode == 200){
        businessFile = null;
        profileFile = null;
        var jsonResponse = response.data;
        var bodyStatus = jsonResponse['status'];
        var bodyMSG = jsonResponse['message'];

        print("Status -> $bodyStatus");
        print("Message -> $bodyMSG");

        if (bodyStatus == 200) {
          SnackBarMessageShow.successsMSG('$bodyMSG', context);
          Navigator.pushNamed(context, AppRoutesName.dashboard);
          LoadingIndicater().onLoadExit(false, context);
        } else {
          Navigator.pop(context);
          SnackBarMessageShow.errorMSG('$bodyMSG', context);
        }
      }
      else if(response.statusCode == 400){
        businessFile = null;
        profileFile = null;
        SnackBarMessageShow.errorMSG('Email Id Has Already Been Taken', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
      else if(response.statusCode == 401){
        businessFile = null;
        profileFile = null;
        SnackBarMessageShow.errorMSG('Unauthorised Expired', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
      else{
        businessFile = null;
        profileFile = null;
        print("error code${response.statusCode}");
        SnackBarMessageShow.errorMSG('Something Get Wrong', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
    }).onError((error, stackTrace){
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
      Navigator.pop(context);
    });
  }

  String _selectedCountry;
  List countryList;
  Future<String> _getCountryList() async {
    await http.get(
        Uri.parse(ApiUrls.getCountry),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        countryList = data['data'];
      });
    });
  }

  String _selectedState;
  List stateList;
  Future<String> _getStateList(var selectCountry) async {
    await http.post(
        Uri.parse(ApiUrls.getState),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'country_id': selectCountry})
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        stateList = data['data'];
      });
    });
  }

  String _selectedCity;
  List cityList;
  Future<String> _getCityList(var selectCountry,var selectState) async {
    await http.post(
        Uri.parse(ApiUrls.getCity),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'country_id': selectCountry,
          'state_id': selectState})
    ).then((response) {
      print(response.body);
      var data = json.decode(response.body);
      setState(() {
        cityList = data['data'];
      });
    });
  }
}
