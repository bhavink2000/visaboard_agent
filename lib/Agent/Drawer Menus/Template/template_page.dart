// ignore_for_file: missing_return

import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/error_helper.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/loading_always.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Ui Helper/divider_helper.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../App Helper/custom_pagination_widget.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';


class TemplatePage extends StatefulWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        agentDrawerMenuProvider.fetchTemplate(1,getAccessToken.access_token);
      });
    });
  }


  int curentindex = 0;
  List docsFile = [];
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      key: _key,
      drawer: CustomDrawer(controller: _advancedDrawerController,),
      backdropColor: const Color(0xff0052D4),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Scaffold(
        backgroundColor: const Color(0xff0052D4),
        appBar: AppBar(
          title: Align(alignment: Alignment.topRight,child: Text("TEMPLATES",style: AllHeader)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.sort_rounded,color: Colors.white,size: 30,)
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: MainWhiteContainerDecoration,
                padding: MainWhiteContinerTopPadding,
                child: ChangeNotifierProvider<AgentDrawerMenuProvider>(
                  create: (BuildContext context)=>agentDrawerMenuProvider,
                  child: Consumer<AgentDrawerMenuProvider>(
                    builder: (context, value, __){
                      switch(value.templateDataList.status!){
                        case Status.loading:
                          return CenterLoading();
                        case Status.error:
                          return ErrorHelper();
                        case Status.completed:
                          return AnimationLimiter(
                            child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.templateDataList.data!.templateData!.data!.length,
                              itemBuilder: (context, index){
                                var tempData = value.templateDataList.data!.templateData!.data;

                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: Column(
                                      children: [
                                        FadeInAnimation(
                                          child: Card(
                                            elevation: 8,
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),
                                                color: Color(0xff0052D4),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment.bottomLeft,
                                                        child: Padding(
                                                          padding: PaddingIDNM,
                                                          child: Text("Sr. No. ${tempData![index].id}",style: FrontHeaderID),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  DividerDrawer(),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                              padding: PaddingField,
                                                              width: MediaQuery.of(context).size.width / 4.2,
                                                              child: Text("Title",style: BackHeaderTopL)
                                                          ),
                                                          CardDots,
                                                          Expanded(
                                                            child: Container(
                                                                padding: PaddingField,
                                                                child: Text("${tempData[index].title}" ?? "",style: BackHeaderTopR)
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: PaddingField,
                                                            width: MediaQuery.of(context).size.width / 4.2,
                                                            child: Text("Description",style: BackHeaderTopL,),
                                                            //child: templateSData[index].documentHtml.isEmpty ? Text("No") : Text(templateSData[index].documentHtml[0].file,style: BackHeaderTopL)
                                                          ),
                                                          CardDots,
                                                          Expanded(
                                                            child: Container(
                                                                padding: PaddingField,
                                                                child: Text("${tempData[index].description}",style: BackHeaderTopR)
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: PaddingField,
                                                            width: MediaQuery.of(context).size.width / 4.2,
                                                            child: Text("Docs",style: BackHeaderTopL,),
                                                            //child: templateSData[index].documentHtml.isEmpty ? Text("No") : Text(templateSData[index].documentHtml[0].file,style: BackHeaderTopL)
                                                          ),
                                                          CardDots,
                                                          Expanded(
                                                            child: SizedBox(
                                                              height: MediaQuery.of(context).size.height / 20,
                                                              child: ListView.builder(
                                                                scrollDirection: Axis.horizontal,
                                                                physics: const BouncingScrollPhysics(),
                                                                itemCount: tempData[index].documents!.length,
                                                                itemBuilder: (context, indexfile){
                                                                  return InkWell(
                                                                    onTap: (){
                                                                      // tempData[index].documents.isNotEmpty
                                                                      //     ? launch(tempData[index].documents[indexfile])
                                                                      //     : Fluttertoast.showToast(msg: 'No File',backgroundColor: PrimaryColorOne,textColor: Colors.white);
                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
                                                                      child: tempData[index].documents!.isEmpty
                                                                          ? const Text("No File")
                                                                          : Text(tempData[index].documents![indexfile].toString().split('/').last,style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12,decoration: TextDecoration.underline)),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        if (tempData.length == 10 || index + 1 != tempData.length)
                                          Container()
                                        else
                                          SizedBox(height: MediaQuery.of(context).size.height / 1.6),

                                        index + 1 == tempData.length ? CustomPaginationWidget(
                                          currentPage: curentindex,
                                          lastPage: agentDrawerMenuProvider.templateDataList.data!.templateData!.lastPage!,
                                          onPageChange: (page) {
                                            setState(() {
                                              curentindex = page - 1;
                                            });
                                            agentDrawerMenuProvider.fetchTemplate(curentindex + 1, getAccessToken.access_token);
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
            ),
          ],
        ),
      ),
    );
  }
}
