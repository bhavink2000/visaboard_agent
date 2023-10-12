// ignore_for_file: non_constant_identifier_names, missing_return

import 'package:flutter/src/material/badge.dart' show Badge;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Search%20Data/Dashboard%20Search/search_notification_data.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/error_helper.dart';
import '../../../App Helper/Enums/enums_status.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Providers/Dashboard Data Provider/dashboard_data_provider.dart';
import '../../../App Helper/Ui Helper/loading_always.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../App Helper/custom_pagination_widget.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../../../Drawer Menus/Client/client_add_page.dart';
import '../../../Drawer Menus/Order Visa File/chat_screen_order_visa_file.dart';
import '../../../Drawer Menus/Order Visa File/edit_screen_order_visa_file.dart';
import '../../../Drawer Menus/Order Visa File/upload_docs_screen.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  GetAccessToken getAccessToken = GetAccessToken();
  DashboardDataProvider dashboardDataProvider = DashboardDataProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        dashboardDataProvider.fetchNotification(1, getAccessToken.access_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                    hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),
                                    suffixIcon: const Icon(Icons.search)
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    search = value;
                                  });
                                },
                                onTap: (){
                                  showSearch(
                                    context: context,
                                    delegate: NotificationSearch(context: context,access_token: getAccessToken.access_token)
                                  );
                                },
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
                  child: Align(alignment: Alignment.topLeft,child: Text("Add \nApplicant +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne))),
                ),
              ),
            ],
          ),
          Expanded(
            child: ChangeNotifierProvider<DashboardDataProvider>(
              create: (BuildContext context)=>dashboardDataProvider,
              child: Consumer<DashboardDataProvider>(
                builder: (context, value, __){
                  switch(value.notificationData.status!){
                    case Status.loading:
                      return const CenterLoading();
                    case Status.error:
                      return const ErrorHelper();
                    case Status.completed:
                      return AnimationLimiter(
                        child: value.notificationData.data!.notifiData!.data!.isEmpty ? Center(child: Text('No notification',style: TextStyle(fontFamily: Constants.OPEN_SANS),),): ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: value.notificationData.data!.notifiData!.data!.length,
                          itemBuilder: (context, index){
                            var notifiData = value.notificationData.data!.notifiData!.data;
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
                                                              notifiData![index].userId,
                                                              notifiData[index].firstName,
                                                              notifiData[index].middleName,
                                                              notifiData[index].lastName,
                                                            ),
                                                            expanded: buildExpanded1(
                                                                notifiData[index].serviceName,
                                                                notifiData[index].letterTypeName,
                                                            ),
                                                          ),
                                                          Expandable(
                                                            collapsed: buildCollapsed3(
                                                                notifiData[index].userSopStatus,
                                                                notifiData[index].action!.editStatus ?? 0,
                                                                notifiData[index].action!.uploadDocsStatus ?? 0,
                                                                notifiData[index].action!.chatStatus ?? 0,
                                                                notifiData[index].action!.paynowStatus ?? 0,
                                                                notifiData[index].invoicePdf,
                                                                notifiData[index].agentUnreadCount,
                                                                notifiData[index].userId,
                                                                notifiData[index].encId,
                                                                notifiData[index].firstName,
                                                                notifiData[index].lastName,
                                                                notifiData[index].serviceName,
                                                                notifiData[index].letterTypeName,
                                                                notifiData[index].countryName,
                                                                notifiData[index].orderPrice,
                                                                notifiData[index].encId,
                                                                notifiData[index].encUserId
                                                            ),
                                                            expanded: buildExpanded3(
                                                              notifiData[index].countryName,
                                                              notifiData[index].orderPrice,
                                                              notifiData[index].createAt,
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


                                    if (notifiData!.length == 10 || index + 1 != notifiData!.length)
                                      Container()
                                    else
                                      SizedBox(height: MediaQuery.of(context).size.height / 1.75),

                                    index + 1 == notifiData.length ? CustomPaginationWidget(
                                      currentPage: curentindex,
                                      lastPage: dashboardDataProvider.notificationData.data!.notifiData!.lastPage!,
                                      onPageChange: (page) {
                                        setState(() {
                                          curentindex = page - 1;
                                        });
                                        dashboardDataProvider.fetchNotification(curentindex + 1, getAccessToken.access_token);
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
          )
        ],
      ),
    );
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
          ),
          const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,)
        ],
      ),
    );
  }
  buildCollapsed3(var uStatus, var edit, var upload, var msg, var pay,var invoice,var notifi,
  var id,var c_id, var c_fnm, var c_lnm,var s_nm, var l_nm, var country_nm,var o_price, var user_sop_id, var user_id) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 6,
                child: Text("Status",style: FrontFottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                  padding: PaddingField,
                  child: Text(
                      "$uStatus",
                      style: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          color: uStatus == 'Completed'
                              ? Colors.green
                              : uStatus == 'In-Process'
                              ? Colors.yellow
                              : uStatus == 'Hold'
                              ? Colors.green.withOpacity(0.8)
                              : Colors.red,
                          fontSize: 11
                      )
                  )
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 6,
                child: Text("Action",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black,fontSize: 12))
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Row(
              children: [
                pay == 1 ? InkWell(
                  onTap: (){
                    Fluttertoast.showToast(msg: "Pay Now");
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(Icons.wallet_rounded,size: 20,color: PrimaryColorOne,),
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
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Badge(
                      label: Text("$notifi"),
                        //badgeContent: Text('$notifi'),
                        child: Icon(Icons.message_rounded,size: 20,color: PrimaryColorOne)
                    ),
                  ),
                ) : Container(),
                edit == 1 ? InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderVisaFile(user_id: user_id,user_sop_id: user_sop_id)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(Icons.edit_rounded,size: 20,color: PrimaryColorOne),
                  ),
                ) : Container(),
                upload == 1 ?InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadDocs(user_sop_id: user_sop_id,user_id: user_id,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(Icons.upload_rounded,size: 20,color: PrimaryColorOne),
                  ),
                ) : Container(),
                invoice != null ?InkWell(
                  onTap: (){
                    launch("$invoice");
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Icon(Icons.picture_as_pdf_rounded,size: 20,color: PrimaryColorOne),
                  ),
                ) : Container(),
              ],
            )
          ],
        ),
      ],
    );
  }

  buildExpanded1(var sType, var lType) {
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Service",style: BackHeaderTopR)
              ),
              const Text(":",style: TextStyle(color: Colors.white)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$sType",style: BackHeaderTopL)
                ),
              ),
              const Icon(Icons.keyboard_arrow_up_rounded,color: Colors.white,)
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Letter",style: BackHeaderTopR)
              ),
              const Text(":",style: TextStyle(color: Colors.white)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("$lType",style: BackHeaderTopL)
                ),
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
