// ignore_for_file: missing_return, must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Enums/enums_status.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Search Data/search_order_visafile.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/icons_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../Client/client_add_page.dart';
import '../drawer_menus.dart';
import 'chat_screen_order_visa_file.dart';
import 'edit_screen_order_visa_file.dart';
import 'upload_docs_screen.dart';

class OrderVisaFile extends StatefulWidget{
  var id;
  OrderVisaFile({Key? key,this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OrderVisaFile();
  }
}

class _OrderVisaFile extends State<OrderVisaFile>{

  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  final Ovfsearch = TextEditingController();
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Map body = {
      'id': widget.id ?? "",
    };
    print("body -> $body");
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        agentDrawerMenuProvider.fetchOrderVisaFile(1, getAccessToken.access_token, body);
      });
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    Map ovfData = {
      'search_text': Ovfsearch.text,
    };
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
          title: Align(alignment: Alignment.topRight,child: Text("Order Visa File",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.sort_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        children: [
                          Flexible(
                            child: Card(
                              elevation: 8,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 20,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(40))
                                ),
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: TextFormField(
                                  controller: Ovfsearch,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          Ovfsearch.clear();
                                          Ovfsearch.text = '';
                                        });
                                        Map OvfData = {
                                          'search_text': '',
                                        };
                                        agentDrawerMenuProvider.fetchOrderVisaFile(1, getAccessToken.access_token, OvfData);
                                        //homeMenusProvider.fetchTest(1, getAccessToken.access_token, testData);
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    Map OvfData = {
                                      'search_text': Ovfsearch.text,
                                    };
                                    agentDrawerMenuProvider.fetchOrderVisaFile(1, getAccessToken.access_token, OvfData);
                                  },
                                  // onTap: (){
                                  //   showSearch(
                                  //     context: context,
                                  //     delegate: OrderVisaFileSearch(context: context,access_token: getAccessToken.access_token),
                                  //   );
                                  // },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 10, 0),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClientAddPage()));
                    },
                    child: Align(alignment: Alignment.topLeft,child: Text("Add \nApplicant +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),color: Colors.white,
                ),
                padding: MainWhiteContinerTopPadding,
                child: ChangeNotifierProvider<AgentDrawerMenuProvider>(
                  create: (BuildContext context)=>agentDrawerMenuProvider,
                  child: Consumer<AgentDrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.orderVisaFileDataList.status!){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.orderVisaFileDataList.data!.data!.data!.length,
                              itemBuilder: (context, index){
                                var orderVisaFile = value.orderVisaFileDataList.data!.data!.data;
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: Column(
                                      children: [
                                        FadeInAnimation(
                                          child: ExpandableNotifier(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                                child: ScrollOnExpand(
                                                  child: Builder(
                                                    builder: (context){
                                                      var controller = ExpandableController.of(context, required: true);
                                                      return InkWell(
                                                        onTap: (){
                                                          controller!.toggle();
                                                        },
                                                        child: Card(
                                                          elevation: 5,
                                                          clipBehavior: Clip.antiAlias,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Expandable(
                                                                collapsed: buildCollapsed1(
                                                                  orderVisaFile![index].userId,
                                                                  orderVisaFile[index].firstName,
                                                                  orderVisaFile[index].middleName,
                                                                  orderVisaFile[index].lastName
                                                                ),
                                                                expanded: buildExpanded1(index),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                  orderVisaFile[index].userSopStatus,
                                                                  orderVisaFile[index].action!.editStatus ?? 0,
                                                                  orderVisaFile[index].action!.uploadDocsStatus ?? 0,
                                                                  orderVisaFile[index].action!.chatStatus ?? 0,
                                                                  orderVisaFile[index].action!.paynowStatus ?? 0,
                                                                  orderVisaFile[index].invoicePdf,
                                                                  orderVisaFile[index].userId,
                                                                  orderVisaFile[index].encId,
                                                                  orderVisaFile[index].firstName,
                                                                  orderVisaFile[index].lastName,
                                                                  orderVisaFile[index].serviceName,
                                                                  orderVisaFile[index].letterTypeName,
                                                                  orderVisaFile[index].countryName,
                                                                  orderVisaFile[index].orderPrice,
                                                                  orderVisaFile[index].encId,
                                                                  orderVisaFile[index].encUserId
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  orderVisaFile[index].serviceName,
                                                                  orderVisaFile[index].letterTypeName,
                                                                  orderVisaFile[index].createAt,
                                                                  orderVisaFile[index].orderPrice,
                                                                    orderVisaFile[index].userSopStatus,
                                                                    orderVisaFile[index].action!.editStatus ?? 0,
                                                                    orderVisaFile[index].action!.uploadDocsStatus ?? 0,
                                                                    orderVisaFile[index].action!.chatStatus ?? 0,
                                                                    orderVisaFile[index].action!.paynowStatus ?? 0,
                                                                    orderVisaFile[index].invoicePdf,
                                                                    orderVisaFile[index].userId,
                                                                    orderVisaFile[index].encId,
                                                                    orderVisaFile[index].firstName,
                                                                    orderVisaFile[index].lastName,
                                                                    orderVisaFile[index].serviceName,
                                                                    orderVisaFile[index].letterTypeName,
                                                                    orderVisaFile[index].countryName,
                                                                    orderVisaFile[index].orderPrice,
                                                                    orderVisaFile[index].encId,
                                                                    orderVisaFile[index].encUserId
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                          ),
                                        ),

                                        if (orderVisaFile!.length == 10 || index + 1 != orderVisaFile!.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 1.7),

                                        index + 1 == orderVisaFile.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: agentDrawerMenuProvider.orderVisaFileDataList.data!.data!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            agentDrawerMenuProvider.fetchOrderVisaFile(curentindex + 1, getAccessToken.access_token, ovfData);
                                          },
                                        ) : Container(),
                                      ],
                                    ),
                                  ),
                                );
                              },
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
  buildCollapsed1(var id, var first_nm, var middle_nm, var last_nm){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      //padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("Case ID. $id" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text("$first_nm $middle_nm $last_nm",style: FrontHeaderNM)
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,)
        ],
      ),
    );
  }
  buildCollapsed3(
      var userStatus,var edit, var upload, var chat, var pay, var invoice,
      var id,var c_id, var c_fnm, var c_lnm,var s_nm, var l_nm, var country_nm,var o_price, var user_sop_id, var user_id) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 6,
                child: Text("Status",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                  child: Text(
                      userStatus == "Completed"
                          ? "$userStatus"
                          : "$userStatus",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          color: userStatus == "Completed" ? Colors.green : userStatus == "In-Process" ? Colors.lightGreen : Colors.red,
                          fontSize: 11,
                        fontWeight: FontWeight.bold
                      )
                  )
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 6,
                child: Text("Action",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black87,fontSize: 11))
            ),
            const Text(":",style: TextStyle(color: Colors.black87)),
            Row(
              children: [
                pay == 1 ? InkWell(
                  onTap: (){
                    Fluttertoast.showToast(msg: "Pay Now");
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: IconsHelper().WalletIcon,
                  ),
                ) : Container(),
                chat == 1 ? InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreenOrderVisaFile(
                      client_id: c_id,
                      c_id: id,
                      client_fnm: c_fnm,
                      client_lnm: c_lnm,
                      service_nm: s_nm,
                      letter_nm: l_nm,
                      country_nm: country_nm,
                      order_p: o_price,
                      user_sop_id: user_sop_id,
                    )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: IconsHelper().ChatIcon,
                  ),
                ) : Container(),
                edit == 1 ? InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderVisaFile(user_id: user_id,user_sop_id: user_sop_id)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: IconsHelper().EditIcon,
                  ),
                ) : Container(),
                upload == 1 ?InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadDocs(user_sop_id: user_sop_id,user_id: user_id,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: IconsHelper().UploadIcon,
                  ),
                ) : Container(),
                invoice != null ?InkWell(
                  onTap: (){
                    launch("$invoice");
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: IconsHelper().InvoiceIcon,
                  ),
                ) : Container(),
              ],
            )
          ],
        )
      ],
    );
  }

  buildExpanded1(var index) {
    return Container();
  }
  buildExpanded3(var service_nm, var letter_nm, var create_on, var price,
  var userStatus,var edit, var upload, var chat, var pay, var invoice,
  var id,var c_id, var c_fnm, var c_lnm,var s_nm, var l_nm, var country_nm,var o_price, var user_sop_id, var user_id
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Service",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$service_nm" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Letter",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$letter_nm" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Created on",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$create_on" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Order Price	",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("₹$price" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Action",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black87,fontSize: 11))
            ),
            const Text(":",style: TextStyle(color: Colors.black87)),
            Row(
              children: [
                pay == 1 ? InkWell(
                  onTap: (){
                    Fluttertoast.showToast(msg: "Pay Now");
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: IconsHelper().WalletIcon,
                  ),
                ) : Container(),
                chat == 1 ? InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreenOrderVisaFile(
                      client_id: c_id,
                      c_id: id,
                      client_fnm: c_fnm,
                      client_lnm: c_lnm,
                      service_nm: s_nm,
                      letter_nm: l_nm,
                      country_nm: country_nm,
                      order_p: o_price,
                      user_sop_id: user_sop_id,
                    )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: IconsHelper().ChatIcon,
                  ),
                ) : Container(),
                edit == 1 ? InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderVisaFile(user_id: user_id,user_sop_id: user_sop_id)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: IconsHelper().EditIcon,
                  ),
                ) : Container(),
                upload == 1 ?InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadDocs(user_sop_id: user_sop_id,user_id: user_id,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: IconsHelper().UploadIcon,
                  ),
                ) : Container(),
                invoice != null ?InkWell(
                  onTap: (){
                    launch("$invoice");
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: IconsHelper().InvoiceIcon,
                  ),
                ) : Container(),
              ],
            )
          ],
        )
      ],
    );
  }

  TextEditingController subject = TextEditingController();
  TextEditingController descrption = TextEditingController();
  File? file;
  String? _selectedValueemail;
  List<String> listOfValueemail = ['Complete Email', 'Query Email'];
  openSendNewMessage() {
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
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                      child: Text("New Message",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
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
                            decoration: InputDecoration(
                                hintText: 'Description',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: MediaQuery.of(context).size.width / 6.5,
                            child: DropdownButtonFormField(
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Select Email Type',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: _selectedValueemail,
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValueemail = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedValueemail = value;
                                });
                              },
                              validator: (String? value) {
                                if (value == null) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: listOfValueemail.map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                );
                              }).toList(),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: Card(
                        elevation: 10,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: PrimaryColorOne),
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
                                child: file == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12)) : Expanded(child: Text(file!.path.split('/').last,style: const TextStyle(fontSize: 9),))
                            )
                          ],
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
                                onTap: (){},
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

}