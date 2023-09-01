//@dart=2.9
// ignore_for_file: non_constant_identifier_names, missing_return, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Api%20Repository/api_urls.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Enums/enums_status.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Search Data/search_transaction_data.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';

class TransactionPage extends StatefulWidget{
  const TransactionPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TransactionPage();
  }
}

class _TransactionPage extends State<TransactionPage>{

  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();

  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  int curentindex = 0;


  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        agentDrawerMenuProvider.fetchTransaction(1, getAccessToken.access_token);
      });
    });
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String searchQuery = '';
  void setSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("TRANSACTION",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.sort_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                children: [
                  Flexible(
                    child: Card(
                      elevation: 8,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Container(
                        //height: MediaQuery.of(context).size.height / 20,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40))
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS)
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchText = value;
                            });
                          },
                          onTap: (){
                            showSearch(
                              context: context,
                              delegate: TransactionSearch(
                                context: context,
                                access_token: getAccessToken.access_token,
                                onQueryChanged: setSearchQuery,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(Icons.search,color: PrimaryColorOne),
                        )
                    ),
                  ),
                ],
              ),
            ),
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
                      switch(value.transactionDataList.status){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.transactionDataList.data.transactionData.data.length,
                              itemBuilder: (context, index){
                                var transaction = value.transactionDataList.data.transactionData.data;
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
                                                                  transaction[index].userId,
                                                                  transaction[index].firstName,
                                                                  transaction[index].middleName,
                                                                  transaction[index].lastName
                                                                ),
                                                                expanded: buildExpanded1(
                                                                  transaction[index].orderPrice,
                                                                  transaction[index].orderPrice
                                                                ),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                  transaction[index].serviceName,
                                                                  transaction[index].letterTypeName
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  transaction[index].paymentDate
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

                                        if (transaction.length == 10 || index + 1 != transaction.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == transaction.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: agentDrawerMenuProvider.transactionDataList.data.transactionData.lastPage,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            agentDrawerMenuProvider.fetchTransaction(curentindex + 1, getAccessToken.access_token);
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
  buildCollapsed1(var id, var first_nm, var middle_nm, var last_nm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      //padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("Case ID. $id",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text("$first_nm $middle_nm $last_nm" ?? "",style: FrontHeaderNM)
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,)
        ],
      ),
    );
  }
  buildCollapsed3(var service_nm, var letter_nm) {
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
                  child: Text("$service_nm" ?? "",style: FottorR)
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
                  child: Text("$letter_nm" ?? "",style: FottorR)
              ),
            )
          ],
        )
      ],
    );
  }

  buildExpanded1(var price, var usdPrice) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4.5,
                  child: Text("Price",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("\u{20B9}$price",style: BackHeaderTopR)
                ),
              ),
              Icon(Icons.keyboard_arrow_up_rounded,color: Colors.white,)
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 4.5,
                  child: Text("USD Price",style: BackHeaderTopL)
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("",style: BackHeaderTopR)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3(var payment_on) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
                  child: Text("$payment_on" ?? "",style: FottorR)
              ),
            )
          ],
        ),
        /*Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Cancel On",style: FottorL)
            ),
            Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Action",style: FottorL)
            ),
            Text(":",style: TextStyle(color: Colors.black)),
            InkWell(
              onTap: (){
                //openActionButton();
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: Container(
                    padding: PaddingField,
                    child: Icon(Icons.menu_open_sharp,color: PrimaryColorOne,size: 15)
                ),
              ),
            )
          ],
        ),*/
      ],
    );
  }

  openActionButton() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 40.0,
                    backgroundColor: Colors.white,
                    child: Image.asset("assets/image/icon.png",width: 50,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("VISABOARD", style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Are you sure you want to cancel order? Agent will get refund into their system wallet.",
                      style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        child: Text("Cancel",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text("Ok",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                        onPressed: (){
                          //Fluttertoast.showToast(msg: 'Testing Cancel Order/ Demo');
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
