
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../App Helper/Enums/enums_status.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Providers/Dashboard Data Provider/dashboard_data_provider.dart';
import '../../../App Helper/Search Data/Dashboard Search/search_wallet_dash_data.dart';
import '../../../App Helper/Ui Helper/error_helper.dart';
import '../../../App Helper/Ui Helper/loading_always.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../App Helper/custom_pagination_widget.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class WalletMenuPage extends StatefulWidget {
  const WalletMenuPage({Key? key}) : super(key: key);

  @override
  State<WalletMenuPage> createState() => _WalletMenuPageState();
}

class _WalletMenuPageState extends State<WalletMenuPage> {
  GetAccessToken getAccessToken = GetAccessToken();
  DashboardDataProvider dashboardDataProvider = DashboardDataProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  final wSearch = TextEditingController();
  int curentindex = 0;

  var walletBalance;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        dashboardDataProvider.fetchWalletDashboard(1, getAccessToken.access_token, '');
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Map wData = {
      'search_text': wSearch.text,
    };
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: ChangeNotifierProvider<DashboardDataProvider>(
          create: (BuildContext context)=>dashboardDataProvider,
          child: Consumer<DashboardDataProvider>(
            builder: (context, value, __){
              switch(value.walletDData.status!){
                case Status.loading:
                  return const CenterLoading();
                case Status.error:
                  return const ErrorHelper();
                case Status.completed:
                  return Column(
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
                                                  dashboardDataProvider.fetchWalletDashboard(1, getAccessToken.access_token, wData);
                                                  //homeMenusProvider.fetchTest(1, getAccessToken.access_token, testData);
                                                },
                                                child: const Icon(Icons.close),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              Map wData = {
                                                'search_text': wSearch.text,
                                              };
                                              dashboardDataProvider.fetchWalletDashboard(1, getAccessToken.access_token, wData);
                                            },
                                            // onTap: (){
                                            //   showSearch(
                                            //       context: context,
                                            //       delegate: WalletDashSearch(context: context,access_token: getAccessToken.access_token)
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
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: PrimaryColorOne),
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                              child: Text("Available \nBalance: ${value.walletDData.data!.totalWalletAmount ?? 0.00}",style: TextStyle(color: Colors.white70,fontFamily: Constants.OPEN_SANS,fontSize: 10)),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          child: AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.walletDData.data!.walletDData!.data!.length,
                              itemBuilder: (context, index){
                                var walletD = value.walletDData.data!.walletDData!.data;
                                walletBalance = value.walletDData.data!.totalWalletAmount;
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
                                                                    walletD![index].id
                                                                ),
                                                                expanded: buildExpanded1(index),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                    walletD[index].serviceName,
                                                                    walletD[index].letterTypeName
                                                                ),
                                                                expanded: buildExpanded3(
                                                                    walletD[index].orderPrice,
                                                                    walletD[index].creditAmount,
                                                                    walletD[index].debitAmount,
                                                                    walletD[index].paymentOn,
                                                                    walletD[index].cancelOn,
                                                                    walletD[index].refundOn
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

                                        if (walletD!.length == 10 || index + 1 != walletD!.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == walletD.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: dashboardDataProvider.walletDData.data!.walletDData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            dashboardDataProvider.fetchWalletDashboard(curentindex + 1, getAccessToken.access_token,wData);
                                          },
                                        ) : Container(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
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
          ),
          const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white)
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
                  child: Text("${lPrice == null ? '' : lPrice}",style: FottorR)
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
