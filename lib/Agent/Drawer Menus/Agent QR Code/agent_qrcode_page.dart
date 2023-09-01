//@dart=2.9
// ignore_for_file: non_constant_identifier_names, missing_return, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Providers/Drawer%20Data%20Provider/drawer_menu_provider.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/error_helper.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/loading_always.dart';
import 'package:visaboard_agent/Agent/Authentication%20Pages/OnBoarding/constants/constants.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../drawer_menus.dart';

class AgentQRCodePage extends StatefulWidget{
  const AgentQRCodePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AgentQRCodePage();
  }
}

class _AgentQRCodePage extends State<AgentQRCodePage>{

  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        agentDrawerMenuProvider.fetchAgentQRCode(1, getAccessToken.access_token);
      });
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();

  var imageURL = "https://www.visaboard.in/assets/uploads/agent/";
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      key: key,
      drawer: CustomDrawer(controller: _advancedDrawerController,),
      backdropColor: const Color(0xff0052D4),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),),
      child: Scaffold(
        backgroundColor: const Color(0xff0052D4),
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("AGENT QR",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.sort_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: MainWhiteContainerDecoration,
                padding: MainWhiteContinerTopPadding,
                child: ChangeNotifierProvider<AgentDrawerMenuProvider>(
                  create: (BuildContext context)=>agentDrawerMenuProvider,
                  child: Consumer<AgentDrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.agentQRDataList.status){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    //height: MediaQuery.of(context).size.height / 1.5,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: PrimaryColorOne,width: 10),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                                          child: Text("Enquiry Form",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 20,fontWeight: FontWeight.bold)),
                                        ),
                                        const Divider(color: Colors.black87,thickness: 0.5,endIndent: 20,indent: 20,),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 3,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: PrimaryColorOne,width: 2),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Image(
                                              image: NetworkImage("$imageURL${value.agentQRDataList.data.data.qrCode.split('/').last}"),
                                            ),
                                          ),
                                        ),
                                        const Divider(color: Colors.black87,thickness: 0.5,endIndent: 20,indent: 20,),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image(image: NetworkImage(SocialMedia.getIndeed),width: 20),
                                              Image(image: NetworkImage(SocialMedia.getFacebook),width: 20),
                                              Image(image: NetworkImage(SocialMedia.getInstagram),width: 20),
                                              Image(image: NetworkImage(SocialMedia.getTwitter),width: 20),
                                              Image(image: NetworkImage(SocialMedia.getYoutube),width: 20),
                                              Image(image: NetworkImage(SocialMedia.getWebSite),width: 20),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  getQRCode('Sticker');
                                                  //_downloadImage("$imageURL${value.agentQRDataList.data.data.qrCode.split('/').last}", 'First');
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: PrimaryColorOne),
                                                  child: Text("Download",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(_downloadFMessage),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    //height: MediaQuery.of(context).size.height / 1.5,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: PrimaryColorOne,width: 10),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                          child: Text(value.agentQRDataList.data.data.firstName,style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 20,fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                                          child: Text("Enquiry Form",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 16)),
                                        ),
                                        const Divider(color: Colors.black87,thickness: 0.5,endIndent: 20,indent: 20,),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 3,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: PrimaryColorOne,width: 2),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Image(
                                              image: NetworkImage("$imageURL${value.agentQRDataList.data.data.qrCode.split('/').last}"),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image(image: NetworkImage(SocialMedia.getIndeed),width: 20),
                                              Image(image: NetworkImage(SocialMedia.getFacebook),width: 20),
                                              Image(image: NetworkImage(SocialMedia.getInstagram),width: 20),
                                              Image(image: NetworkImage(SocialMedia.getTwitter),width: 20),
                                              Image(image: NetworkImage(SocialMedia.getYoutube),width: 20),
                                              Image(image: NetworkImage(SocialMedia.getWebSite),width: 20),
                                            ],
                                          ),
                                        ),
                                        const Divider(color: Colors.black87,thickness: 0.5,endIndent: 20,indent: 20,),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                                          child: Text("Thank You For Visiting Us",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 16)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      getQRCode('Download');
                                                      //_downloadImage("$imageURL${value.agentQRDataList.data.data.qrCode.split('/').last}", 'Second');
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: PrimaryColorOne),
                                                      child: Text("Download",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      applyForStandee();
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: PrimaryColorOne),
                                                      child: Text("Apply For Standee",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Text(_downloadSMessage)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Card(
                                          elevation: 10,
                                          child: Image(
                                            image: NetworkImage("$imageURL${value.agentQRDataList.data.data.qrCode.split('/').last}"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                                          child: InkWell(
                                            onTap: (){
                                              _downloadImage("$imageURL${value.agentQRDataList.data.data.qrCode.split('/').last}", 'Third');
                                              //launch("$imageURL${value.agentQRDataList.data.data.qrCode.split('/').last}");
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: PrimaryColorOne),
                                              child: Text("Download",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),),
                                            ),
                                          ),
                                        ),
                                        Text(_downloadTMessage),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                      }
                    },
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
  bool _downloading = false;
  String _downloadFMessage = '';
  String _downloadSMessage = '';
  String _downloadTMessage = '';

  Future<void> _downloadImage(var imageUrl, var type) async {
    setState(() {
      _downloading = true;
      type == 'First' ? _downloadFMessage = 'Downloading First Code...' : type == 'Second' ? _downloadSMessage = 'Downloading Second Code...' : _downloadTMessage = 'Downloading...';
    });
    var response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getExternalStorageDirectory();
    final file = File("${documentDirectory.path}/qr_code.png");
    file.writeAsBytesSync(response.bodyBytes);
    setState(() {
      _downloading = false;
      type == 'First' ? _downloadFMessage = 'Downloaded First Code Successfully!' : type == 'Second' ? _downloadSMessage = 'Downloaded Second Code Successfully!' : _downloadTMessage = 'Downloaded Successfully!';
    });
  }

  Future<Uint8List> getQRCode(type) async {
    final response = await http.get(
        Uri.parse(type == 'Sticker' ? ApiConstants.getQRSticker : ApiConstants.getQRDownload),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${getAccessToken.access_token}',
        }
    );
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final externalDir = await getExternalStorageDirectory();
      final downloadsDir = Directory('${externalDir.path}/Download');
      await downloadsDir.create(recursive: true);
      final file = File('${downloadsDir.path}/visaboard.pdf');
      await file.writeAsBytes(bytes);
      Fluttertoast.showToast(msg: "$file");
      setState(() {});
    } else {
      throw Exception('Failed to download image');
    }
  }
  void applyForStandee() async {
    var url = ApiConstants.getQRApplyStandee;
    try {
      final response = await http.get(
          Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${getAccessToken.access_token}',
      });
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        var bodyStatus = jsonData['status'];
        var bodyMSG = jsonData['message'];
        if (bodyStatus == 200) {
          SnackBarMessageShow.successsMSG('$bodyMSG', context);
          Navigator.pushNamed(context, AppRoutesName.dashboard);
        } else {
          SnackBarMessageShow.errorMSG('$bodyMSG', context);
        }
      } else {
        SnackBarMessageShow.errorMSG('Failed to load data', context);
      }
    } catch (e) {
      print(e.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }

}