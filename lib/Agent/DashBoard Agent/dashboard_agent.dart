
import 'dart:io';
import 'dart:ui';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../App Helper/Routes/App Routes/app_routes_name.dart';
import '../App Helper/Ui Helper/ui_helper.dart';
import '../Authentication Pages/OnBoarding/constants/constants.dart';
import '../Drawer Menus/drawer_menus.dart';
import 'Bottom Menus/Home Screen/home_page.dart';
import 'Bottom Menus/Notification Screen/notification_menu.dart';
import 'Bottom Menus/Setting Screen/setting_menu.dart';
import 'Bottom Menus/Wallet Screen/wallet_menu.dart';


class Dashboard extends StatefulWidget{
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard>{

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();

  int currentIndex = 0;

  final List _children = [
    const HomePage(),
    const NotificationPage(),
    const WalletMenuPage(),
    const SettingPage(),
  ];
  void onTapScreen(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      key: _key,
      drawer: CustomDrawer(controller: _advancedDrawerController,),
      backdropColor: DrawerBackColor,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),),
      child: WillPopScope(
        onWillPop: (){
          return openExitBox();
        },
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)
                )
            ),
            centerTitle: true,
            title: Text("DASHBOARD",style: AllHeader),
            elevation: 0,
            backgroundColor: PrimaryColorOne,
            leading: IconButton(
                onPressed: (){_advancedDrawerController.showDrawer();},
                icon: const Icon(Icons.sort_rounded,color: Colors.white,size: 30,)
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, AppRoutesName.profile);
                  },
                  icon: const Icon(Icons.person_pin,color: Colors.white,size: 30,)
              ),
            ],
          ),
          body: _children[currentIndex],
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: currentIndex,
              showElevation: false, // use this to remove appBar's elevation
              onItemSelected: (index) => onTapScreen(index),
              items: [
                BottomNavyBarItem(
                  icon: const Icon(Icons.home),
                  title: const Text('Home'),
                  activeColor: const Color(0xff0052D4),
                ),
                BottomNavyBarItem(
                    icon: const Icon(Icons.notifications),
                    title: const Text('Notification'),
                    activeColor: const Color(0xff0052D4)
                ),
                BottomNavyBarItem(
                    icon: const Icon(Icons.wallet),
                    title: const Text('Wallet'),
                    activeColor: const Color(0xff0052D4)
                ),
                BottomNavyBarItem(
                    icon: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    activeColor: const Color(0xff0052D4)
                ),
              ],
            )
        ),
      ),
    );
  }

  openExitBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
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
                        "Do You Want To Exit..?",
                        style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          child: Text("Stay",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text("Exit",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 2),),
                          onPressed: (){
                            exit(0);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}