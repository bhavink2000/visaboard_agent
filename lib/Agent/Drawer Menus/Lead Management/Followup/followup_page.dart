// ignore_for_file: non_constant_identifier_names

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../App Helper/Enums/enums_status.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../../App Helper/Ui Helper/error_helper.dart';
import '../../../App Helper/Ui Helper/loading_always.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../../drawer_menus.dart';

class FollowUpPage extends StatefulWidget{
  const FollowUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FollowUpPage();
  }
}

class _FollowUpPage extends State<FollowUpPage>{
  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();

  bool? isLoading;
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String access_token = "",token_type = "";

  @override
  void initState() {
    isLoading = true;
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        agentDrawerMenuProvider.fetchLeadFollowUp(1, getAccessToken.access_token, '');
      });
    });
    super.initState();
  }

  final _advancedDrawerController = AdvancedDrawerController();
  String search = "";
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
        key: key,
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff0052D4),
        appBar: AppBar(
          title: InkWell(onTap: (){Navigator.of(context, rootNavigator: true).pop();},child: Align(alignment: Alignment.topRight,child: Text("FOLLOWUP",style: AllHeader))),
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
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
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
                    ),
                  ),
                ),
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
                        switch(value.leadFollowUpList.status!){
                          case Status.loading:
                            return const CenterLoading();
                          case Status.error:
                            return const ErrorHelper();
                          case Status.completed:
                            return AnimationLimiter(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: value.leadFollowUpList.data!.data!.data!.length,
                                itemBuilder: (context, index){
                                  var leadF = value.leadFollowUpList.data!.data!.data![index];
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
                                                                    leadF.id,
                                                                    leadF.followupName
                                                                  ),
                                                                  expanded: buildExpanded1(index),
                                                                ),
                                                                Expandable(
                                                                  collapsed: buildCollapsed3(
                                                                    leadF.followupEmail,
                                                                    leadF.followupContactNumber
                                                                  ),
                                                                  expanded: buildExpanded3(
                                                                    leadF.followupReason,
                                                                    leadF.createAt
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
  buildCollapsed1(var id, var fNm) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
      //padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("${id}" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text("${fNm}",style: FrontHeaderNM)
            ),
          )
        ],
      ),
    );
  }
  buildCollapsed3(var fMail, var fNumber) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Email",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: Container(
                    padding: PaddingField,
                    child: Text("${fMail}",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Number",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: InkWell(
                  onTap: ()=>launch("tel://$fNumber"),
                  child: Container(
                      padding: PaddingField,
                      child: Text("${fNumber}",style: FottorR)
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  buildExpanded1(var index) {
    return Container();
  }
  buildExpanded3(var fReason, var createOn) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Reason",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("${fReason}",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Created On",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("${createOn}",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text("Action",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            InkWell(
              onTap: (){
                openFollowupBox();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                    padding: PaddingField,
                    child: Icon(Icons.edit,color: PrimaryColorOne,size: 15,)
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
  openFollowupBox() {
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Followup", style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextFormField(
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Note'
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text("Submit",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

}