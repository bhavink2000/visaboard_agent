// //@dart=2.9
// // ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables
//
// import 'dart:convert';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import '../../Authentication Pages/OnBoarding/constants/constants.dart';
// import '../../Drawer Menus/Order Visa File/order_visa_file.dart';
// import '../Api Repository/api_urls.dart';
// import '../Ui Helper/icons_helper.dart';
// import '../Ui Helper/loading_always.dart';
// import '../Ui Helper/ui_helper.dart';
// import '../custom_pagination_widget.dart';
//
// class ClientSearch extends SearchDelegate{
//   var access_token;
//   BuildContext context;
//   ClientSearch({Key key,this.access_token,this.context});
//
//   var jsonData;
//   int curentindex = 0;
//   Future<List<dynamic>> getItemsData(var index) async {
//
//     final url = Uri.parse("${ApiConstants.getClient}?page=$index");
//     final headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $access_token',
//     };
//     final body = {'search_text': query};
//     final response = await http.post(url, headers: headers, body: body);
//     if (response.statusCode == 200) {
//       jsonData = jsonDecode(response.body) as Map<String, dynamic>;
//       final itemList = jsonData['data']['data'] as List<dynamic>;
//       return itemList;
//     } else {
//       throw Exception('Failed to load items');
//     }
//   }
//
//   Future<List> loadNextPage(int page) async {
//     //final itemList = await getItemsData(page);
//     return await getItemsData(page);
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) => IconButton(
//     icon: const Icon(Icons.arrow_back),
//     onPressed: (){
//       close(context, null);
//     },
//   );
//
//   @override
//   List<Widget> buildActions(BuildContext context) => [
//     IconButton(
//       icon: const Icon(Icons.clear),
//       onPressed: (){
//         if(query.isEmpty) {
//           close(context, null);
//         }
//         else{
//           query = '';
//         }
//       },
//     ),
//   ];
//
//   @override
//   Widget buildResults(BuildContext context){
//     return FutureBuilder<List<dynamic>>(
//       future: getItemsData(curentindex + 1),
//       builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CenterLoading();
//         } else if (snapshot.hasError) {
//           final error = snapshot.error;
//           return Center(child: Text('Error: $error'));
//         } else {
//           final items = snapshot.data;
//           return ListView.builder(
//             padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//             itemCount: items.length,
//             itemBuilder: (BuildContext context, int index) {
//               final item = items[index];
//               return Column(
//                 children: [
//                   ExpandableNotifier(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                         child: ScrollOnExpand(
//                           child: Builder(
//                             builder: (context){
//                               var controller = ExpandableController.of(context, required: true);
//                               return InkWell(
//                                 onTap: (){
//                                   controller.toggle();
//                                 },
//                                 child: Card(
//                                   elevation: 5,
//                                   clipBehavior: Clip.antiAlias,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Expandable(
//                                         collapsed: buildCollapsed1(
//                                           item['id'],
//                                           item['first_name'],
//                                           item['middle_name'],
//                                           item['last_name'],
//                                         ),
//                                         expanded: buildExpanded1(),
//                                       ),
//                                       Expandable(
//                                         collapsed: buildCollapsed3(
//                                             item['action'],
//                                         ),
//                                         expanded: buildExpanded3(
//                                           item['country_name'],
//                                           item['service_name'],
//                                           item['letter_type_name'],
//                                           item['create_at'],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       )
//                   ),
//                   if (items.length == 10 || index + 1 != items.length)
//                     Container()
//                   else
//                     SizedBox(height: MediaQuery.of(context).size.height / 1.5),
//
//                   index + 1 == items.length ? CustomPaginationWidget(
//                     currentPage: curentindex,
//                     lastPage: jsonData['data']['last_page'],
//                     onPageChange: (page) {
//                       curentindex = page - 1;
//                       loadNextPage(curentindex + 1);
//                     },
//                   ) : Container(),
//                 ],
//               );
//             },
//           );
//         }
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Container();
//   }
//
//   buildCollapsed1(var id, var f_nm, var m_nm,var l_nm) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: PrimaryColorOne,
//       padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                   padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                   child: Text("Client ID" ?? "",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12))
//               ),
//               CardDots,
//               Expanded(
//                 child: Container(
//                     padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                     child: Text("$id" ?? "",style: FrontHeaderNM)
//                 ),
//               )
//             ],
//           ),
//           const SizedBox(height: 5),
//           Row(
//             children: [
//               Container(
//                   padding: const EdgeInsets.fromLTRB(8, 0, 22, 0),
//                   child: Text("Name" ?? "",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 12))
//               ),
//               CardDots,
//               Expanded(
//                 child: Container(
//                     padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                     child: Text("$f_nm $m_nm $l_nm" ?? "",style: FrontHeaderNM)
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   buildCollapsed3(var action) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 7,
//                 child: Text("Action",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             InkWell(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderVisaFile(id: action)));
//               },
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
//                 child: Container(
//                     padding: PaddingField,
//                     child: IconsHelper().ActionIcon
//                 ),
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
//
//   buildExpanded1() {
//     return Container();
//   }
//   buildExpanded3(var country, var service_nm, var letter_nm, var create_on) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.5,
//                 child: Text("Foreign Country",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("$country" ?? "",style: FrontFottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.5,
//                 child: Text("Service Type",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("$service_nm" ?? "",style: FrontFottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.5,
//                 child: Text("Letter Type",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("$letter_nm" ?? "",style: FrontFottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 3.5,
//                 child: Text("Created on",style: FrontFottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("$create_on",style: FrontFottorR)
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }