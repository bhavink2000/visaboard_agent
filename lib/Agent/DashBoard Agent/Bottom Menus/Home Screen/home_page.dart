
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../../App Helper/Enums/enums_status.dart';
import '../../../App Helper/Get Access Token/get_access_token.dart';
import '../../../App Helper/Providers/Dashboard Data Provider/dashboard_data_provider.dart';
import '../../../App Helper/Ui Helper/error_helper.dart';
import '../../../App Helper/Ui Helper/loading_always.dart';
import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../../../Drawer Menus/Client/client_add_page.dart';
import 'ApplyForms/apply_forms.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {

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
        dashboardDataProvider.fetchDashBoardCounter(1, getAccessToken.access_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height / 1.45,
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: ChangeNotifierProvider<DashboardDataProvider>(
        create: (BuildContext context)=>dashboardDataProvider,
        child: Consumer<DashboardDataProvider>(
          builder: (context, value, __){
            switch(value.dashBoardCounterData.status!){
              case Status.loading:
                return const CenterLoading();
              case Status.error:
                return const ErrorHelper();
              case Status.completed:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                            child: AnimationLimiter(
                              child: AnimationConfiguration.staggeredList(
                                position: 3,
                                duration: const Duration(milliseconds: 1000),
                                child: SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClientAddPage()));
                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff0a6fb8)),
                                          child: Text(
                                            "Add Applicant",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: Constants.OPEN_SANS,

                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 25, 0),
                              child: AnimationLimiter(
                                child: AnimationConfiguration.staggeredList(
                                  position: 5,
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForms(name: 'Quick Apply')));
                                        },
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff0a6fb8)),
                                            child: Text(
                                              "Quick Apply",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: Constants.OPEN_SANS,

                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                      AnimationLimiter(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                              childAspectRatio: 2.3/2
                          ),
                          itemCount: value.dashBoardCounterData.data!.data!.cards!.length,
                          itemBuilder: (context, index) {
                            var dashBoardCounter = value.dashBoardCounterData.data!.data!.cards;
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 800),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Card(
                                      color: const Color(0xff0a6fb8),
                                      elevation: 8,
                                      shadowColor: PrimaryColorOne.withOpacity(0.2),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                             '${dashBoardCounter![index].serviceName}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: Constants.OPEN_SANS,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: ContinerPaddingInside,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                                  child: Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        "Active  : ${dashBoardCounter[index].activeServiceCount}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: Constants.OPEN_SANS
                                                        ),
                                                      )
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(2),
                                                  child: Divider(
                                                    color: Color(0xff0a6fb8),
                                                    thickness: 1.5,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                                                  child: Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        "Total : ${dashBoardCounter[index].serviceCount}",
                                                        style: TextStyle(
                                                            fontFamily: Constants.OPEN_SANS,
                                                            fontSize: 16),
                                                      )
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.45,
                                height: MediaQuery.of(context).size.height / 7,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Refer code :",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10,),
                                    Text(value.dashBoardCounterData.data!.data!.referCode!,style: TextStyle(fontFamily: Constants.OPEN_SANS),)
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.45,
                                height: MediaQuery.of(context).size.height / 7,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Your account manager",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10),
                                    Text(value.dashBoardCounterData.data!.data!.contactNo!.first,style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                                    Text(value.dashBoardCounterData.data!.data!.contactNo!.last,style: TextStyle(fontFamily: Constants.OPEN_SANS),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
