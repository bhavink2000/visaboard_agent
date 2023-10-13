// ignore_for_file: non_constant_identifier_names, missing_return, use_build_context_synchronously

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/error_helper.dart';

import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Routes/App Routes/app_routes_name.dart';
import '../../App Helper/Routes/App Routes/drawer_menus_routes_names.dart';
import '../../App Helper/Search Data/search_wallet_data.dart';
import '../../App Helper/Ui Helper/Drawer Menus Helper/drawer_menus_datashow_helper.dart';
import '../../App Helper/Ui Helper/divider_helper.dart';
import '../../App Helper/Ui Helper/loading.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/size_helper.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';


class WalletPageD extends StatefulWidget{
  const WalletPageD({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _WalletPageD();
  }
}

class _WalletPageD extends State<WalletPageD>{

  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  final wSearch = TextEditingController();
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        agentDrawerMenuProvider.fetchWalletTransaction(1, getAccessToken.access_token,'');
      });
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();


  @override
  Widget build(BuildContext context) {
    Map wData = {
      'search_text': wSearch.text,
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("WALLET",style: AllHeader)),
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
                                  controller: wSearch,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          wSearch.clear();
                                          wSearch.text = '';
                                        });
                                        Map wData = {
                                          'search_text': '',
                                        };
                                        agentDrawerMenuProvider.fetchWalletTransaction(1, getAccessToken.access_token, wData);
                                        //homeMenusProvider.fetchTest(1, getAccessToken.access_token, testData);
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    Map wData = {
                                      'search_text': wSearch.text,
                                    };
                                    agentDrawerMenuProvider.fetchWalletTransaction(1, getAccessToken.access_token, wData);
                                  },
                                  // onTap: (){
                                  //   showSearch(
                                  //     context: context,
                                  //     delegate: WalletSearch(context: context,access_token: getAccessToken.access_token)
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
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: (){
                          openAddWallet();
                        },
                        child: Align(alignment: Alignment.topLeft,child: Text("Add \nWallet +",style: TextStyle(fontSize: 10,letterSpacing: 0.5,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
                      ),
                      TextButton(
                        onPressed: (){
                          openWithdrawWallet();
                        },
                        child: Align(alignment: Alignment.topLeft,child: Text("Withdraw \nWallet +",style: TextStyle(fontSize: 10,letterSpacing: 0.5,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
                      ),
                    ],
                  ),
                ),
              ],
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
                      switch(value.walletTDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.walletTDataList.data!.walletTData!.data!.length,
                              itemBuilder: (context, index){
                                var walletTransaction = value.walletTDataList.data!.walletTData!.data;
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
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
                                                                  walletTransaction![index].id
                                                                ),
                                                                expanded: buildExpanded1(index),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                  walletTransaction[index].status
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  walletTransaction[index].creditAmount,
                                                                  walletTransaction[index].debitAmount,
                                                                  walletTransaction[index].creditDate,
                                                                  walletTransaction[index].debitDate,
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

                                        if (walletTransaction!.length == 10 || index + 1 != walletTransaction!.length)
                                          Container()
                                        else
                                          SizeHelper().getSize(context,walletTransaction!.length),

                                        index + 1 == walletTransaction.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: agentDrawerMenuProvider.walletTDataList.data!.walletTData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            agentDrawerMenuProvider.fetchWalletTransaction(curentindex + 1, getAccessToken.access_token,wData);
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
                ),
              ),
            )
          ],
        ),
      ),
    );
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
            Text("$id" ?? "", style: BackHeaderTopR),
            Spacer(),
            Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,)
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
              //color: status == "Cancel" ? Colors.red.withOpacity(0.6) : Colors.green.withOpacity(0.6),
              child: Text(
                "$status" ?? "",
                style: TextStyle(
                    fontFamily: Constants.OPEN_SANS,
                    color: status == "Cancel" ? Colors.red : status == "Pending" ?  Colors.orange : Colors.green,
                    fontSize: 11,
                  fontWeight: FontWeight.bold
                )
              )
          ),
        )
      ],
    );
  }

  buildExpanded1(var index) {
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
                    child: Text("Add Wallet",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                                amount.text = '';
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: InkWell(
                              onTap: (){
                                if(amount.text.isEmpty){
                                  Fluttertoast.showToast(msg: 'This field is required.');
                                }
                                else{
                                  addWallet();
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
                ],
              ),
            ),
          );
        }
    );
  }

  Future<void> addWallet() async {
    print("in addwallet");
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      final response = await http.post(Uri.parse(ApiConstants.getWalletAdd), headers: headers);
      final responseData = json.decode(response.body);
      print("response ->$responseData");
      var bodyStatus = responseData['status'];
      var bodyMSG = responseData['data']['payment_url'];
      print("bodymsg->$bodyMSG");
      if (bodyStatus == 200) {
        launch("$bodyMSG");
        amount.text = '';
        Navigator.pop(context);
      } else {
        SnackBarMessageShow.warningMSG('$bodyMSG', context);
        amount.text = '';
        Navigator.pop(context);
      }
    } catch (error) {
      print(error.toString());
      amount.text = '';
      SnackBarMessageShow.errorMSG('Something went wrong', context);
      Navigator.pop(context);
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
                    child: Text("Withdraw Wallet",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                                if(withdrawamount.text.isEmpty){
                                  Fluttertoast.showToast(msg: 'This field is required.');
                                }
                                else{
                                  withdrawWallet();
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
    dio.options.headers["authorization"] = "Bearer ${getAccessToken.access_token}";
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
        Navigator.pushNamed(context, DrawerMenusName.wallet_page_d);
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

