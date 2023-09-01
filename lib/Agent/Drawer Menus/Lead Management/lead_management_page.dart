//@dart=2.9
// ignore_for_file: non_constant_identifier_names

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';
import '../drawer_menus.dart';
import 'lead_management_edit.dart';
import 'lead_management_new_add.dart';

class LeadManagementPage extends StatefulWidget{
  const LeadManagementPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LeadManagementPage();
  }
}

class _LeadManagementPage extends State<LeadManagementPage>{

  bool isLoading;
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String access_token = "",token_type = "";
  @override
  void initState() {
    isLoading = true;
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }
  List<String> selectedItemValue = List<String>();
  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> prvsvac = ['Pending', 'Registered Client', 'VisaFile Submitted','Successful Client','Visa Rejected','Non-Active Client'];
    return prvsvac.map((value) => DropdownMenuItem(
      value: value,
      child: Text(value),
    )).toList();
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
          title: InkWell(onTap: (){Navigator.of(context, rootNavigator: true).pop();},child: Align(alignment: Alignment.topRight,child: Text("LEAD MANAGEMENT",style: AllHeader))),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (){_advancedDrawerController.showDrawer();},
              icon: const Icon(Icons.sort_rounded,color: Colors.white,size: 30,)
          ),
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
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 10, 0),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LeadManageAddNew()));
                    },
                    child: Align(alignment: Alignment.topLeft,child: Text("Add \nLead +",style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.white))),
                  ),
                ),
              ],
            ),
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
                child: isLoading == false
                  ? AnimationLimiter(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index){
                      for (int i = 0; i < 10; i++) {
                        selectedItemValue.add("Pending");
                      }
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
                                                controller.toggle();
                                              },
                                              child: Card(
                                                elevation: 5,
                                                clipBehavior: Clip.antiAlias,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expandable(
                                                      collapsed: buildCollapsed1(index),
                                                      expanded: buildExpanded1(index),
                                                    ),
                                                    Expandable(
                                                      collapsed: buildCollapsed3(),
                                                      expanded: buildExpanded3(),
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
                )
                  : CenterLoading(),
              ),
            )
          ],
        ),
      ),
    );
  }
  buildCollapsed1(var index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: PrimaryColorOne,
     // padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: Row(
        children: [
          Container(
              padding: PaddingField,
              child: Text("442" ?? "",style: FrontHeaderID)
          ),
          CardDots,
          Expanded(
            child: Container(
                padding: PaddingField,
                child: Text("Komal Patel",style: FrontHeaderNM)
            ),
          )
        ],
      ),
    );
  }
  buildCollapsed3() {
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
                    child: Text("komalpatel23113010412@gmail.com",style: FottorR)
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Contact",style: FottorL)
              ),
              const Text(":",style: TextStyle(color: Colors.black)),
              Expanded(
                child: InkWell(
                  onTap: ()=>launch("tel://7894561230"),
                  child: Container(
                      padding: PaddingField,
                      child: Text("9313729585",style: FottorR)
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
    return Container(
      color: PrimaryColorOne,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: PaddingField,
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Status",style: BackHeaderTopL)
              ),
              CardDots,
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                    width: MediaQuery.of(context).size.width / 2.7,
                    height: MediaQuery.of(context).size.height / 20,
                    child: DropdownButtonFormField(
                      dropdownColor: PrimaryColorOne,
                      decoration: const InputDecoration(border: InputBorder.none,
                          hintText: 'Status', hintStyle: TextStyle(fontSize: 10)
                      ),
                      items: _dropDownItem(),
                      value: selectedItemValue[index].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,fontFamily: Constants.OPEN_SANS,decoration: TextDecoration.underline),
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          selectedItemValue[index] = value;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          selectedItemValue[index] = value;
                        });
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "can't empty";
                        } else {
                          return null;
                        }
                      },
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
                  child: Text("Action",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12))
              ),
              const Text(":",style: TextStyle(color: Colors.white)),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LeadManageEdit()));
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Icon(Icons.edit,color: Colors.white,size: 18,),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  buildExpanded3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("Date Of Birth	",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("Country",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("India",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("City",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("Category",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("",style: FottorR)
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
                padding: PaddingField,
                width: MediaQuery.of(context).size.width / 4,
                child: Text("Created On",style: FottorL)
            ),
            const Text(":",style: TextStyle(color: Colors.black)),
            Expanded(
              child: Container(
                  padding: PaddingField,
                  child: Text("12 Oct 22 1:01 PM",style: FottorR)
              ),
            )
          ],
        ),
      ],
    );
  }
}