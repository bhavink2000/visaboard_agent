import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Enums/enums_status.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/loading_always.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Order%20Visa%20File/service_requested.dart';

import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import 'Edit Pages/academics_page.dart';
import 'Edit Pages/family_inforamtion_page.dart';
import 'Edit Pages/funding_sponsor_page.dart';
import 'Edit Pages/immigration_history_page.dart';
import 'Edit Pages/language_test_Page.dart';
import 'Edit Pages/personal_details_page.dart';
import 'Edit Pages/proposed_studies_page.dart';
import 'Edit Pages/spouse_details_page.dart';
import 'Edit Pages/work_experince_page.dart';


class EditOrderVisaFile extends StatefulWidget {
  var user_id, user_sop_id;
  EditOrderVisaFile({Key? key,this.user_id,this.user_sop_id}) : super(key: key);

  @override
  State<EditOrderVisaFile> createState() => _EditOrderVisaFileState();
}

class _EditOrderVisaFileState extends State<EditOrderVisaFile> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    Map body = {
      'user_id': '${widget.user_id}',
      'user_sop_id': '${widget.user_sop_id}'
    };
    print("Body -> $body");
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        agentDrawerMenuProvider.fetchOVFEdit(1, getAccessToken.access_token, body);
      });
    });
    // Future.delayed(const Duration(seconds: 5),(){
    //   openServiceRBox();
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }
  String tabName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<AgentDrawerMenuProvider>(
        create: (BuildContext context)=>agentDrawerMenuProvider,
        child: Consumer<AgentDrawerMenuProvider>(
          builder: (context, value, __){
            switch(value.oVFEditData.status!){
              case Status.loading:
                return CenterLoading();
              case Status.error:
                return const ErrorHelper();
              case Status.completed:
                return SafeArea(
                  child: Expanded(
                    child: value.oVFEditData.data!.tabs!.isNotEmpty ? PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: value.oVFEditData.data!.tabs!.length,
                      itemBuilder: (context, index){
                        var tab = value.oVFEditData.data!.tabs;
                        var item = value.oVFEditData.data!.data;
                        print("---------------------");
                        print("tab ->${tab![index].tab}");
                        print("tab ->${tab![index].status}");
                        print("----------------------");

                        switch (tab[index].tab) {
                          case 'Personal Details':
                            return PersonalDetailsPage(
                              pagecontroller: _pageController,
                              editDetails: item,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Academics':
                            return AcademicsPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Language Tests':
                            return LanguageTestPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Work Experience':
                            return WorkExperincePage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Spouse Details':
                            return SpouseDetailsPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Proposed Studies':
                            return ProposedStudiesPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Funding / Sponsor':
                            return FundingSponsorPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Immigration History':
                            return ImmigrationHistoryPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          case 'Family Information':
                            return FamilyInfoPage(
                              pagecontroller: _pageController,
                              editDetails: item!,
                              tabStatus: tab[index].status,
                              tabName: tab[index].tab,
                              user_id: widget.user_id,
                              user_sop_id: widget.user_sop_id,
                            );
                          default:
                            return SizedBox.shrink();
                        }
                      },
                    ) : Center(child: Text('No Forms Available'),),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  // Future openServiceRBox(){
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
  //           child: AlertDialog(
  //             shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
  //             content: Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(30),
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   CircleAvatar(
  //                     maxRadius: 40.0,
  //                     backgroundColor: Colors.white,
  //                     child: Image.asset("assets/image/icon.png",width: 50,),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: InkWell(
  //                         onTap: (){},
  //                         child: Text("VISABOARD", style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 18),)
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(5),
  //                     child: Text(
  //                       "You Can Show Requested to Click on View",
  //                       style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: <Widget>[
  //                       TextButton(
  //                         child: Text("Close",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
  //                         onPressed: () => Navigator.of(context).pop(),
  //                       ),
  //                       TextButton(
  //                         child: Text("View",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
  //                         onPressed: (){
  //                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceRequested(u_sop_id: widget.user_sop_id)));
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       }
  //   );
  // }
}
