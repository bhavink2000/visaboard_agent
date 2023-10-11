import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';

class HelpDeskPage extends StatefulWidget {
  const HelpDeskPage({Key? key}) : super(key: key);

  @override
  State<HelpDeskPage> createState() => _HelpDeskPageState();
}

class _HelpDeskPageState extends State<HelpDeskPage> {
  final _advancedDrawerController = AdvancedDrawerController();
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
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
          title: InkWell(onTap: (){Navigator.of(context, rootNavigator: true).pop();},child: Align(alignment: Alignment.topRight,child: Text("HELP DESK",style: AllHeader))),
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),color: Colors.white,
                ),
                padding: MainWhiteContinerTopPadding,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                      child: InkWell(
                        onTap: ()=>launch("https://api.whatsapp.com/send?phone=918347349543&text=Looking%20for%20%20SOP%20and%20%20other%20VISA%20document%20Services&source=website&data="),
                        child: Card(
                          elevation: 8,
                          shadowColor: PrimaryColorOne.withOpacity(0.5),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          child: Container(
                            decoration: BoxDecoration(
                                color: PrimaryColorOne,
                                borderRadius: const BorderRadius.all(Radius.circular(30))
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(15),
                                      child: Text("WhatsApp",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),)
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(Icons.whatshot,color: Colors.white,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                      child: InkWell(
                          onTap: () async {
                            final phoneNumber = '8980006120';
                            final phoneUrl = 'tel:$phoneNumber';
                            if (await canLaunch(phoneUrl)) {
                              await launch(phoneUrl);
                            } else {
                              throw 'Could not launch $phoneUrl';
                            }
                            print("Calling phone");
                          },
                        child: Card(
                          elevation: 8,
                          shadowColor: PrimaryColorOne.withOpacity(0.5),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          child: Container(
                            decoration: BoxDecoration(
                                color: PrimaryColorOne,
                                borderRadius: const BorderRadius.all(Radius.circular(30))
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(15),
                                      child: Text("Contact",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),)
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(Icons.phone_iphone,color: Colors.white,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                      child: InkWell(
                        onTap: () async{
                          final email = Uri(
                            scheme: 'mailto',
                            path: 'support@visaboard.in',
                            query: 'subject=Visaboard&body=Message',
                          );
                          if (await canLaunch(email.toString())) {
                            launch(email.toString());
                          } else {
                            //Fluttertoast.showToast(msg: 'Could not launch $email');
                            throw 'Could not launch $email';
                          }
                          print("calling email");
                          //launch("mailto:support@visaboard.in");
                        },
                        child: Card(
                          elevation: 8,
                          shadowColor: PrimaryColorOne.withOpacity(0.5),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          child: Container(
                            decoration: BoxDecoration(
                                color: PrimaryColorOne,
                                borderRadius: const BorderRadius.all(Radius.circular(30))
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(15),
                                      child: Text("Email",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),)
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(Icons.email,color: Colors.white,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
