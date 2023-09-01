//@dart=2.9
// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../../Drawer Menus/Order Visa File/order_visa_file.dart';
import '../Api Repository/api_urls.dart';
import '../Routes/App Routes/app_routes_name.dart';
import '../Ui Helper/icons_helper.dart';
import '../Ui Helper/loading.dart';
import '../Ui Helper/loading_always.dart';
import '../Ui Helper/snackbar_msg_show.dart';
import '../Ui Helper/ui_helper.dart';
import '../custom_pagination_widget.dart';

class WalletSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  WalletSearch({Key key,this.access_token,this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getWalletTransaction}?page=$index");
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
    final itemList = await getItemsData(page);
    return itemList;
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
            itemCount: items.length,
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
                                  controller.toggle();
                                },
                                child: Card(
                                  elevation: 5,
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expandable(
                                        collapsed: buildCollapsed1(
                                          item['id'],
                                        ),
                                        expanded: buildExpanded1(),
                                      ),
                                      Expandable(
                                        collapsed: buildCollapsed3(
                                          item['status'],
                                        ),
                                        expanded: buildExpanded3(
                                          item['credit_amount'],
                                          item['debit_date'],
                                          item['credit_date'],
                                          item['debit_date'],
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
                    SizedBox(height: MediaQuery.of(context).size.height / 4),

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

  buildCollapsed1(var id) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("Sr. No." ?? "",
                  style: FrontHeaderID)
          ),
          CardDots,
          Text("$id" ?? "", style: BackHeaderTopR)
        ],
      ),
    );
  }
  buildCollapsed3(var status) {
    return Row(
      children: [
        Container(
            padding: PaddingField,
            //color: Colors.yellow,
            width: MediaQuery.of(context).size.width / 6,
            child: Text("Status",style: FrontFottorL)
        ),
        const Text(":",style: TextStyle(color: Colors.black)),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
              padding: PaddingField,
              color: status == "Cancel" ? Colors.red.withOpacity(0.6) : Colors.green.withOpacity(0.6),
              child: Text("$status" ?? "",style: FrontFottorR)
          ),
        )
      ],
    );
  }

  buildExpanded1() {
    return Container();
  }
  buildExpanded3(var credit_a, var debit_a, var credit_d, var debit_d) {
    return Container(
      padding: ContinerPaddingInside,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.8,
                  child: Text("Credit Amount",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("₹$credit_a" ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.8,
                  child: Text("Credit Date",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$credit_d" ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.8,
                  child: Text("Debit Amount",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$debit_a" ?? "",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 3.8,
                  child: Text("Debit Date",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$debit_d" ?? "",style: FottorR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  final amount = TextEditingController();
  final withdrawamount = TextEditingController();
  openAddWallet() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Text("Add Wallet",style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                  ),
                  Divider(thickness: 1.5,color: PrimaryColorOne,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 7,
                      child: TextField(
                        controller: amount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'amount',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
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
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const VerticalDivider(thickness: 1.5,color: Colors.white,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: InkWell(
                              onTap: (){
                                addWallet();
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Future<void> addWallet() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token',
    };
    try {
      final response = await http.post(Uri.parse(ApiConstants.getWalletAdd), headers: headers);
      final responseData = json.decode(response.body);

      var bodyStatus = responseData['status'];
      var bodyMSG = responseData['redirect_link'];

      if (bodyStatus == 200) {
        launch("$bodyMSG");
      } else {
        SnackBarMessageShow.errorMSG('$bodyMSG', context);
      }
    } catch (error) {
      print(error.toString());
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }

  openWithdrawWallet() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Text("Withdraw Wallet",style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                  ),
                  Divider(thickness: 1.5,color: PrimaryColorOne,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width / 7,
                      child: TextField(
                        controller: withdrawamount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                            hintText: 'amount',
                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
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
                                withdrawamount.clear();
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const VerticalDivider(thickness: 1.5,color: Colors.white,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: InkWell(
                              onTap: (){
                                withdrawWallet();
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  Future withdrawWallet()async{
    LoadingIndicater().onLoad(true, context);

    Dio dio = Dio();
    FormData formData;
    var response;
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer $access_token";
    dio.options.headers["Accept"] = "application/json";

    if (withdrawamount != null) {
      formData = FormData.fromMap({
        'amount' : withdrawamount.text,
      });
      response = await dio.post(
          ApiConstants.getWalletWithdraw,
          options: Options(validateStatus: (_)=> true),
          data: formData,
          onSendProgress: (int sent, int total) {
            print('$sent $total');
          }
      );
    } else {
      SnackBarMessageShow.errorMSG('Withdraw amount cannot be empty', context);
      Navigator.pop(context);
      LoadingIndicater().onLoadExit(false, context);
    }
    if(response.statusCode == 200){
      var jsonResponse = response.data;
      var status = jsonResponse['status'];
      var message = jsonResponse['message'];

      if (status == 200) {
        SnackBarMessageShow.successsMSG('$message', context);
        Navigator.pushNamed(context, AppRoutesName.dashboard);
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
