// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../App Helper/Routes/App Routes/app_routes_name.dart';
import '../App Helper/Routes/App Routes/drawer_menus_routes_names.dart';
import '../App Helper/Ui Helper/ui_helper.dart';
import '../Authentication Pages/OnBoarding/constants/constants.dart';
import 'Order Visa File/order_visa_file.dart';

class CustomDrawer extends StatefulWidget {
  final AdvancedDrawerController controller;
  const CustomDrawer({Key? key, required this.controller}) : super(key: key);
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final List<Entry> menus = <Entry>[
    Entry('Dashboard', Icons.dashboard , <Entry>[]),
    Entry('Clients', Icons.person , <Entry>[]),
    Entry('Order -Visa File', Icons.file_present_rounded , <Entry>[]),
    Entry('Templates', Icons.backpack , <Entry>[]),
    Entry('Transaction', Icons.transfer_within_a_station , <Entry>[]),
    Entry('Wallet', Icons.wallet , <Entry>[]),
    Entry('QR Code', Icons.qr_code , <Entry>[]),
    Entry('Help Desk', Icons.help_outline_rounded , <Entry>[]),
    Entry('Lead Management', Icons.folder_open , <Entry>[]),
    Entry('Lead Management FollowUp', Icons.supervisor_account , <Entry>[]),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset("assets/image/icon.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text("VisaBoard",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(color: Colors.white70,thickness: 0.5),
                itemCount: menus.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: _buildTiles(menus[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTiles(Entry root) {
    if (root.widgets.isEmpty) {
      return ListTile(
        onTap: () async {
          if(root.title == "Dashboard") {
            Navigator.pushNamed(context, AppRoutesName.dashboard);
          }
          else if(root.title == "Clients"){
            Navigator.pushNamed(context, DrawerMenusName.client);
          }
          else if(root.title == "Order -Visa File"){
            Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
          }
          else if(root.title == "Templates"){
            Navigator.pushNamed(context, DrawerMenusName.template);
          }
          else if(root.title == "Transaction"){
            Navigator.pushNamed(context, DrawerMenusName.transaction);
          }
          else if(root.title == "Wallet"){
            Navigator.pushNamed(context, DrawerMenusName.wallet_page_d);
          }
          else if(root.title == "Help Desk"){
            Navigator.pushNamed(context, DrawerMenusName.help_desk);
          }
          else if(root.title == "Lead Management"){
            Navigator.pushNamed(context, DrawerMenusName.lead_management);
          }
          else if(root.title == "Lead Management FollowUp"){
            Navigator.pushNamed(context, DrawerMenusName.followup);
          }
          else if(root.title == "QR Code"){
            Navigator.pushNamed(context, DrawerMenusName.agent_qrcode);
          }
        },
        contentPadding: const EdgeInsets.symmetric(vertical: -5),
        title: Row(
          children: [
            Icon(root.icon,color: Colors.white,size: 20,),
            const SizedBox(width: 10),
            Text(root.title, style: DrawerMenuStyle),
          ],
        ),
      );
    }

    return ExpansionTile(
      trailing: const Icon(
        Icons.arrow_right,
        color: Colors.white,
      ),
      childrenPadding: EdgeInsets.zero,
      tilePadding: const EdgeInsets.symmetric(vertical: -5),
      key: PageStorageKey<Entry>(root),
      title: Row(
        children: [
          Icon(root.icon,color: Colors.white,size: 20,),
          const SizedBox(width: 10),
          Text(root.title, style: DrawerMenuStyle),
        ],
      ),
      children: root.widgets.map(_buildTiles).toList(),
    );
  }
}

class Entry {
  String title;
  IconData icon;
  List<Entry> widgets;
  Entry(this.title, this.icon, this.widgets);
}