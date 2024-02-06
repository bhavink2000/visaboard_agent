// ignore_for_file: use_build_context_synchronously, missing_return

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Providers/Drawer%20Data%20Provider/drawer_menu_provider.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Routes/App%20Routes/drawer_menus_routes_names.dart';
import '../../../App Helper/Api Repository/api_urls.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../../App Helper/Ui Helper/error_helper.dart';
import '../../../App Helper/Ui Helper/loading.dart';
import '../../../App Helper/Ui Helper/loading_always.dart';
import '../../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class ChatScreenOrderVisaFile extends StatefulWidget {
  var client_id, c_id,client_fnm, client_lnm,service_nm, letter_nm, country_nm, order_p,user_sop_id;
  ChatScreenOrderVisaFile({Key? key,this.client_id,this.c_id,this.client_fnm,this.client_lnm,this.service_nm,this.letter_nm,this.country_nm,this.order_p,this.user_sop_id}) : super(key: key);

  @override
  State<ChatScreenOrderVisaFile> createState() => _ChatScreenOrderVisaFile();
}

class _ChatScreenOrderVisaFile extends State<ChatScreenOrderVisaFile> {

  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        agentDrawerMenuProvider.fetchOVFChat(1, getAccessToken.access_token,widget.user_sop_id);
      });
    });
  }

  File? file;
  @override
  Widget build(BuildContext context) {
    var clientName = "${widget.client_fnm} ${widget.client_lnm}";
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 5),
                  child: Text("Inbox & Messages",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: ExpansionTile(
                title: Text("Client Details",style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                children: [
                  showData('Client Id', widget.c_id),
                  showData('Client Name', clientName),
                  showData('Service Name', widget.service_nm),
                  showData('Letter Name', widget.letter_nm),
                  showData('Country', widget.country_nm),
                  showData('Order Price', widget.order_p),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
              child: InkWell(
                onTap: (){
                  openNewMessage();
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                  width: MediaQuery.of(context).size.width / 2.4,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: PrimaryColorOne),
                  child: Row(
                    children: [
                      const Icon(Icons.edit_rounded,color: Colors.white),
                      const SizedBox(width: 5,),
                      Text("New Message",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                ),
                child: ChangeNotifierProvider<AgentDrawerMenuProvider>(
                  create: (BuildContext context)=>agentDrawerMenuProvider,
                  child: Consumer<AgentDrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.oVFChatData.status!){
                        case Status.loading:
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return value.oVFChatData.data!.chatData!.userInboxes!.isNotEmpty
                            ? ListView.builder(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                            itemCount: value.oVFChatData.data!.chatData!.userInboxes!.length,
                            itemBuilder: (context, index){
                              var chatData = value.oVFChatData.data!.chatData!.userInboxes;
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey,width: 0.5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          chatData![index].sendByAdmin == 0 ?
                                          Column(
                                            children: [
                                              CircleAvatar(child: Icon(Icons.person,color: Colors.white70,),backgroundColor: Colors.black54,radius: 20,),
                                              Text("Client",style: TextStyle(fontFamily: Constants.OPEN_SANS),textAlign: TextAlign.center)
                                            ],
                                          ) : Container(),
                                          SizedBox(width: 5),
                                          Column(
                                            children: [
                                              Container(
                                                width: chatData[index].sendByAdmin == 1 ? MediaQuery.of(context).size.width / 1.4 : MediaQuery.of(context).size.width / 1.25,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: chatData[index].sendByAdmin == 1 ? Color(0xff0a6fb8) : Colors.green
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${chatData[index].firstName} ${chatData[index].middleName} ${chatData[index].lastName}",
                                                            style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                                                      child: Text(chatData[index].createAt!,style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white70,fontSize: 10),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: chatData[index].sendByAdmin == 1 ? MediaQuery.of(context).size.width / 1.4 : MediaQuery.of(context).size.width / 1.25,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      chatData[index].subject != null ? Text(
                                                          chatData[index].subject.toString(),
                                                          style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)
                                                      ) : Container(),
                                                      chatData[index].subject != null ? const SizedBox(height: 10) : Container(),
                                                      HtmlWidget(
                                                        chatData[index].message ?? "",
                                                        textStyle: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black87,fontSize: 12),
                                                        onErrorBuilder: (context, element, error) => Text('$element error: $error'),
                                                        onLoadingBuilder: (context, element, loadingProgress) => const Center(child: CircularProgressIndicator(color: Colors.red,)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: 5),
                                          chatData[index].sendByAdmin == 1 ? Column(
                                            children: const [
                                              Image(image: AssetImage("assets/image/icon.png"),width: 20,),
                                              Text("Visaboard \nTeam",textAlign: TextAlign.center,)
                                            ],
                                          ) : Container()
                                        ],
                                      ),
                                      //const Divider(color: Colors.grey),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                            : Center(child: Text(
                                  "No Chat",
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white)
                              ));
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showData(var label, var data){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
        ),
        child: Row(
          children: [
            Container(
              width: 110,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$label:",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 13,fontWeight: FontWeight.bold),),
              ),
            ),
            Container(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Text("$data",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),textAlign: TextAlign.right,),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextEditingController subject = TextEditingController();
  TextEditingController descrption = TextEditingController();

  openNewMessage() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("New Message",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: PrimaryColorOne),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(Icons.close,color: Colors.white)
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5,color: PrimaryColorOne,),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: subject,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                                hintText: 'Subject',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: descrption,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            //maxLines: 7,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                                hintText: 'Description',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: Card(
                        elevation: 10,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.8,
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
                                        FilePickerResult? pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
                                        if(pickedfile != null){
                                          setState((){
                                            file = File(pickedfile.files.single.path!);
                                          });
                                        }
                                      }
                                      on PlatformException catch (e) {
                                        print(" File not Picked ");
                                      }
                                    },
                                    child: file == null
                                        ? const Text("Choose File",style: TextStyle(color: Colors.white))
                                        : const Text("File Picked",style: TextStyle(color: Colors.white))
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: file == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(file!.path.split('/').last,style: const TextStyle(fontSize: 9),))
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(32),
                            bottomLeft: Radius.circular(30),
                          ),color: PrimaryColorOne
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                  file = null;
                                  subject.text = "";
                                  descrption.text = "";
                                },
                                child: Text(
                                  "Discard",
                                  style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const VerticalDivider(thickness: 1.5,color: Colors.white,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                              child: InkWell(
                                onTap: (){
                                  if(subject.text.isEmpty){
                                    Navigator.pop(context);
                                    SnackBarMessageShow.warningMSG('subject field is required.', context);
                                  }
                                  else if(descrption.text.isEmpty){
                                    Navigator.pop(context);
                                    SnackBarMessageShow.warningMSG('description field is required.', context);
                                  }
                                  else{
                                    sendMessage();
                                  }
                                },
                                child: Text(
                                  "Send",
                                  style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
    ).then((value){
    });
  }

  Future sendMessage()async{
    print("UserId -> ${widget.client_id}");
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
    dio.options.headers["Accept"] = "application/json";

    FormData formData = FormData.fromMap({
      'user_sop_id': widget.client_id,
      'user_inbox[subject]' : subject.text,
      'user_inbox[message]': descrption.text,
      // 'user_inbox_file[file][]': await MultipartFile.fromFile(file.path).then((value){
      //   print("File Uploads");
      // }).onError((error, stackTrace){
      //   print("error $error");
      // }),
    });

    if (file != null) {
      formData.files.add(MapEntry(
          'user_inbox_file[file][]', await MultipartFile.fromFile(file!.path)));
    }

    var response = await dio.post(
        ApiConstants.sendMessage,
        options: Options(validateStatus: (_)=> true),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        }
    );
    print("response code ->${response.statusCode}");
    print("response Message ->${response.statusMessage}");
    if(response.statusCode == 200){
      var jsonResponse = response.data;
      var status = jsonResponse['status'];
      var message = jsonResponse['message'];

      print("Status -> $status");
      print("Message -> $message");

      if (status == 200) {
        SnackBarMessageShow.successsMSG('$message', context);
        Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
        LoadingIndicater().onLoadExit(false, context);
      } else {
        SnackBarMessageShow.errorMSG('$message', context);
        Navigator.pop(context);
        LoadingIndicater().onLoadExit(false, context);
      }
    }
    else{
      SnackBarMessageShow.errorMSG('Something went wrong', context);
      Navigator.pop(context);
      LoadingIndicater().onLoadExit(false, context);
    }
  }
}
