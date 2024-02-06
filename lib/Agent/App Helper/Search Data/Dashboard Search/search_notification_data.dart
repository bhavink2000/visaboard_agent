// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../../../Drawer Menus/Order Visa File/Ovf Screens/chat_screen_order_visa_file.dart';
import '../../../Drawer Menus/Order Visa File/Ovf Screens/edit_screen_order_visa_file.dart';
import '../../../Drawer Menus/Order Visa File/Ovf Screens/upload_docs_screen.dart';
import '../../Api Repository/api_urls.dart';
import '../../Ui Helper/loading_always.dart';
import '../../Ui Helper/ui_helper.dart';
import '../../custom_pagination_widget.dart';


class NotificationSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  NotificationSearch({Key? key,this.access_token,required this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getNotification}?page=$index");
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    final body = {'search_text': query};
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final itemList = jsonData['data']['data'] as List<dynamic>;
      return itemList;
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List> loadNextPage(int page) async {
    //final itemList = await getItemsData(page);
    return await getItemsData(page);
  }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: (){
      close(context, null);
    },
  );

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: (){
        if(query.isEmpty) {
          close(context, null);
        }
        else{
          query = '';
        }
      },
    ),
  ];

  @override
  Widget buildResults(BuildContext context){
    return FutureBuilder<List<dynamic>>(
      future: getItemsData(curentindex + 1),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CenterLoading();
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          return Center(child: Text('Error: $error'));
        } else {
          final items = snapshot.data;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            itemCount: items!.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return Column(
                children: [
                  ExpandableNotifier(
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
                                          item['user_id'],
                                          item['first_name'],
                                          item['middle_name'],
                                          item['last_name'],
                                        ),
                                        expanded: buildExpanded1(
                                          item['user_sop_status'],
                                          item['action']['edit_status'],
                                          item['action']['upload_docs_status'],
                                          item['action']['chat_status'],
                                          item['action']['paynow_status'],
                                          item['invoice_pdf'],
                                          item['agent_unread_count'],
                                          item['user_id'],
                                          item['enc_id'],
                                          item['first_name'],
                                          item['last_name'],
                                          item['service_name'],
                                          item['letter_type_name'],
                                          item['create_at'],
                                          item['order_price'],
                                          item['enc_user_id'],
                                          item['enc_id'],
                                        ),
                                      ),
                                      Expandable(
                                        collapsed: buildCollapsed3(
                                          item['service_name'],
                                          item['letter_type_name'],
                                        ),
                                        expanded: buildExpanded3(
                                          item['country_name'],
                                          item['order_price'],
                                          item['create_at'],
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
                  if (items.length == 10 || index + 1 != items.length)
                    Container()
                  else
                    SizedBox(height: MediaQuery.of(context).size.height / 1.5),

                  index + 1 == items.length ? CustomPaginationWidget(
                    currentPage: curentindex,
                    lastPage: jsonData['data']['last_page'],
                    onPageChange: (page) {
                      curentindex = page - 1;
                      loadNextPage(curentindex + 1);
                    },
                  ) : Container(),
                ],
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  buildCollapsed1(var uId, var fNm, var mNm, var lNm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      //padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("Client Id. $uId" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text("$fNm $mNm $lNm",style: FrontHeaderNM)
            ),
          )
        ],
      ),
    );
  }
  buildCollapsed3(var sType, var lType) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 6,
                child: Text("Service",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$sType",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 6,
                child: Text("Letter",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$lType",style: FottorR)
              ),
            )
          ],
        ),
      ],
    );
  }

  buildExpanded1(var uStatus, var edit, var upload, var msg, var pay,var invoice,var notifi,
      var id,var c_id, var c_fnm, var c_lnm,var s_nm, var l_nm, var country_nm,var o_price, var user_sop_id, var user_id) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Status",style: BackHeaderTopL)
              ),
              CardDots,
              Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                    padding: PaddingField,
                    color: uStatus == 'Completed' ? Colors.green.withOpacity(0.8) : uStatus == 'In-Process' ? Colors.yellow.withOpacity(0.8) : uStatus == 'Hold'? Colors.green.withOpacity(0.8) :Colors.red.withOpacity(0.8),
                    child: Text("$uStatus",style: BackHeaderTopR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Action",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12))
              ),
              const Text(":",style: TextStyle(color: Colors.white)),
              Row(
                children: [
                  pay == 1 ? InkWell(
                    onTap: (){
                      Fluttertoast.showToast(msg: "Pay Now");
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.wallet_rounded,size: 20,color: Colors.white,),
                    ),
                  ) : Container(),
                  msg == 1 ? InkWell(
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
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Badge(
                        label: Text("$notifi"),
                          //badgeContent: Text('$notifi'),
                          child: Icon(Icons.message_rounded,size: 20,color: Colors.white,)
                      ),
                    ),
                  ) : Container(),
                  edit == 1 ? InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderVisaFile(user_id: user_id,user_sop_id: user_sop_id)));
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.edit_rounded,size: 20,color: Colors.white,),
                    ),
                  ) : Container(),
                  upload == 1 ?InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadDocs(user_sop_id: user_sop_id,user_id: user_id,)));
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.upload_rounded,size: 20,color: Colors.white,),
                    ),
                  ) : Container(),
                  invoice != null ?InkWell(
                    onTap: (){
                      launch("$invoice");
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(Icons.picture_as_pdf_rounded,size: 20,color: Colors.white,),
                    ),
                  ) : Container(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(var country, var oPrice, var cOn) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Country",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$country",style: FottorR)
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
                  child: Text("₹$oPrice",style: FottorR)
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
                  child: Text("$cOn",style: FottorR)
              ),
            )
          ],
        ),
      ],
    );
  }
}