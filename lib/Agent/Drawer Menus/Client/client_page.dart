
import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Search%20Data/search_client_data.dart';
import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/icons_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../Order Visa File/order_visa_file.dart';
import '../drawer_menus.dart';
import 'client_add_page.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ClientPage();
  }
}

class _ClientPage extends State<ClientPage> {
  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  final  clientSearch = TextEditingController();
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        agentDrawerMenuProvider.fetchClient(1, getAccessToken.access_token, '');
      });
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    Map clientData = {
      'search_text': clientSearch.text,
    };
    return AdvancedDrawer(
      key: key,
      drawer: CustomDrawer(
        controller: _advancedDrawerController,
      ),
      backdropColor: PrimaryColorOne,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Scaffold(
        backgroundColor: PrimaryColorOne,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(
            alignment: Alignment.topRight,
            child: Text("CLIENTS", style: AllHeader)
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                _advancedDrawerController.showDrawer();
              },
              icon: const Icon(
                Icons.sort_rounded,
                color: Colors.white,
                size: 30,
              )),
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
                                  controller: clientSearch,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          clientSearch.clear();
                                          clientSearch.text = '';
                                        });
                                        Map clientData = {
                                          'search_text': '',
                                        };
                                        agentDrawerMenuProvider.fetchClient(1, getAccessToken.access_token, clientData);
                                        //homeMenusProvider.fetchTest(1, getAccessToken.access_token, testData);
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    Map clientData = {
                                      'search_text': clientSearch.text,
                                    };
                                    agentDrawerMenuProvider.fetchClient(1, getAccessToken.access_token, clientData);
                                  },
                                  // onTap: (){
                                  //   showSearch(
                                  //     context: context,
                                  //     delegate: ClientSearch(context: context,access_token: getAccessToken.access_token)
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
                      //openAddClients();
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
                decoration: MainWhiteContainerDecoration,
                padding: MainWhiteContinerTopPadding,
                child: ChangeNotifierProvider<AgentDrawerMenuProvider>(
                  create: (BuildContext context)=>agentDrawerMenuProvider,
                  child: Consumer<AgentDrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.clientDataList.status!){
                        case Status.loading:
                          return const CenterLoading();
                        case Status.error:
                          return const ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.clientDataList.data!.clientData!.data!.length,
                              itemBuilder: (context, index) {
                                var client = value.clientDataList.data!.clientData!.data;
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
                                                                  client![index].id,
                                                                  client[index].firstName,
                                                                  client[index].middleName,
                                                                  client[index].lastName
                                                                ),
                                                                expanded: buildExpanded1(index),
                                                              ),
                                                              Expandable(
                                                                collapsed: buildCollapsed3(
                                                                  client[index].encId
                                                                ),
                                                                expanded: buildExpanded3(
                                                                  client[index].countryName,
                                                                  client[index].serviceName,
                                                                  client[index].letterTypeName,
                                                                  client[index].createAt,
                                                                  client[index].encId
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

                                        if (client!.length == 10 || index + 1 != client!.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 4),

                                        index + 1 == client.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: agentDrawerMenuProvider.clientDataList.data!.clientData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            agentDrawerMenuProvider.fetchClient(curentindex + 1, getAccessToken.access_token, clientData);
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

  buildCollapsed1(var id, var f_nm, var m_nm,var l_nm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text("Client ID" ?? "",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12))
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text("$id" ?? "",style: FrontHeaderNM)
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(8, 0, 22, 0),
                  child: Text("Name" ?? "",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12))
              ),
              CardDots,
              Expanded(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text("$f_nm $m_nm $l_nm" ?? "",style: FrontHeaderNM)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  buildCollapsed3(var id) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 7,
                child: Text("Action",style: FrontFottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderVisaFile(id: id)));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Container(
                    padding: PaddingField,
                    child: IconsHelper().ActionIcon
                ),
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
  buildExpanded3(var country, var service_nm, var letter_nm, var create_on,var id) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Foreign Country",style: FrontFottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$country" ?? "",style: FrontFottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Service Type",style: FrontFottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$service_nm" ?? "",style: FrontFottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Letter Type",style: FrontFottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$letter_nm" ?? "",style: FrontFottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Created on",style: FrontFottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("$create_on",style: FrontFottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Action",style: FrontFottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderVisaFile(id: id)));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Container(
                    padding: PaddingField,
                    child: IconsHelper().ActionIcon
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

}

