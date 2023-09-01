//@dart=2.9
// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../Api Repository/api_urls.dart';
import '../../Ui Helper/loading_always.dart';
import '../../Ui Helper/ui_helper.dart';
import '../../custom_pagination_widget.dart';

class WalletDashSearch extends SearchDelegate{
  var access_token;
  BuildContext context;
  WalletDashSearch({Key key,this.access_token,this.context});

  var jsonData;
  int curentindex = 0;
  Future<List<dynamic>> getItemsData(var index) async {

    final url = Uri.parse("${ApiConstants.getWalletDashBoard}?page=$index");
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
      throw Exception('No Data Found');
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
          return CenterLoading();
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
                                        expanded: buildExpanded1(index),
                                      ),
                                      Expandable(
                                        collapsed: buildCollapsed3(
                                          item['service_name'],
                                          item['letter_type_name'],
                                        ),
                                        expanded: buildExpanded3(
                                          item['order_price'],
                                          item['credit_amount'],
                                          item['debit_amount'],
                                          item['payment_on'],
                                          item['cancel_on'],
                                          item['refund_on'],
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
      //padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("Id." ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text("$id",style: FrontHeaderNM)
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
                  child: Text(sType == null ? "" : "$sType",style: FottorR)
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
                  child: Text(lType == null ? "" : "$lType",style: FottorR)
              ),
            )
          ],
        ),
      ],
    );
  }

  buildExpanded1(var index) {
    return Container();
  }
  buildExpanded3(var lPrice, var credit, var debit, var pOn, var cOn, var rOn) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Letter Price",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$lPrice",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Credit",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$credit",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Debit",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$debit",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Payment On",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$pOn",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Cancel On",style: FottorL)
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
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Refund On",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$rOn",style: FottorR)
              ),
            )
          ],
        ),
      ],
    );
  }
}
