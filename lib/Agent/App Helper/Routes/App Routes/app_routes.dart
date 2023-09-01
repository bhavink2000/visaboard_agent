// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:visaboard_agent/Agent/Drawer%20Menus/Help%20Desk/help_desk_page.dart';
import '../../../Authentication Pages/Login Screen/login_screen.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../../../Authentication Pages/OnBoarding/screens/landing_page.dart';
import '../../../Authentication Pages/Splash Screen/splash_screen.dart';
import '../../../DashBoard Agent/Profile/profile_page.dart';
import '../../../DashBoard Agent/dashboard_agent.dart';
import '../../../Drawer Menus/Agent QR Code/agent_qrcode_page.dart';
import '../../../Drawer Menus/Client/client_page.dart';
import '../../../Drawer Menus/Lead Management/Followup/followup_page.dart';
import '../../../Drawer Menus/Lead Management/lead_management_page.dart';
import '../../../Drawer Menus/Order Visa File/order_visa_file.dart';
import '../../../Drawer Menus/Template/template_page.dart';
import '../../../Drawer Menus/Transaction/transaction_page.dart';
import '../../../Drawer Menus/Wallet/wallet_page.dart';
import '../../Ui Helper/ui_helper.dart';
import 'drawer_menus_routes_names.dart';
import 'app_routes_name.dart';
class AppRoutes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.splashscreen:return MaterialPageRoute(builder: (BuildContext context) =>  const SplashScreen());
      case AppRoutesName.landingpage:return MaterialPageRoute(builder: (BuildContext context) =>  LandingPage());
      case AppRoutesName.login:return MaterialPageRoute(builder: (BuildContext context) =>  const LoginPage());
      case AppRoutesName.dashboard:return MaterialPageRoute(builder: (BuildContext context) =>  const Dashboard());

      case AppRoutesName.profile:return MaterialPageRoute(builder: (context) => const ProfilePage());

      case DrawerMenusName.client:return MaterialPageRoute(builder: (BuildContext context) =>  const ClientPage());
      case DrawerMenusName.template:return MaterialPageRoute(builder: (BuildContext context) =>  const TemplatePage());
      case DrawerMenusName.transaction:return MaterialPageRoute(builder: (BuildContext context) =>  const TransactionPage());
      case DrawerMenusName.order_visa_file:return MaterialPageRoute(builder: (BuildContext context) =>  OrderVisaFile());
      case DrawerMenusName.help_desk:return MaterialPageRoute(builder: (BuildContext context) =>  const HelpDeskPage());
      case DrawerMenusName.lead_management:return MaterialPageRoute(builder: (BuildContext context) =>  const LeadManagementPage());
      case DrawerMenusName.followup:return MaterialPageRoute(builder: (BuildContext context) =>  const FollowUpPage());
      case DrawerMenusName.wallet_page_d:return MaterialPageRoute(builder: (BuildContext context) =>  const WalletPageD());
      case DrawerMenusName.agent_qrcode:return MaterialPageRoute(builder: (BuildContext context) =>  const AgentQRCodePage());


      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => Scaffold(
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on,color: PrimaryColorOne,size: 25),
                    const SizedBox(height: 10,),
                    Text("No Route Found",style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS),),
                  ],
                ),
              ),
            )
        );
    }
  }
}
