// //@dart=2.9
// // ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables
//
// import 'dart:convert';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
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
// class TransactionSearch extends SearchDelegate{
//   var access_token;
//   final BuildContext context;
//   final void Function(String query) onQueryChanged;
//   TransactionSearch({Key key,this.access_token,this.context,this.onQueryChanged});
//
//   var jsonData;
//   int curentindex = 0;
//   Future<List<dynamic>> getItemsData(var index) async {
//
//     final url = Uri.parse("${ApiConstants.getTransaction}?page=$index");
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
//
//   Future<List> loadNextPage(int page) async {
//     final itemList = await getItemsData(page);
//     return itemList;
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
//                                           item['user_id'],
//                                           item['first_name'],
//                                           item['middle_name'],
//                                           item['last_name'],
//                                         ),
//                                         expanded: buildExpanded1(
//                                           item['price'],
//                                           item['order_price'],
//                                         ),
//                                       ),
//                                       Expandable(
//                                         collapsed: buildCollapsed3(
//                                           item['service_name'],
//                                           item['letter_type_name'],
//                                         ),
//                                         expanded: buildExpanded3(
//                                           item['payment_date'],
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
//                     SizedBox(height: MediaQuery.of(context).size.height / 4),
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
//   buildCollapsed1(var id, var first_nm, var middle_nm, var last_nm) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: PrimaryColorOne,
//       //padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
//       child: Row(
//         children: [
//           Container(
//               padding: PaddingField,
//               child: Text("Case ID. $id",style: FrontHeaderID)
//           ),
//           CardDots,
//           Expanded(
//             child: Container(
//                 padding: PaddingField,
//                 child: Text("$first_nm $middle_nm $last_nm" ?? "",style: FrontHeaderNM)
//             ),
//           )
//         ],
//       ),
//     );
//   }
//   buildCollapsed3(var service_nm, var letter_nm) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 6,
//                 child: Text("Service",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("$service_nm" ?? "",style: FottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 6,
//                 child: Text("Letter",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("$letter_nm" ?? "",style: FottorR)
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
//
//   buildExpanded1(var price, var usdPrice) {
//     return Container(
//       color: PrimaryColorOne,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                   padding: PaddingField,
//                   width: MediaQuery.of(context).size.width / 4.5,
//                   child: Text("Price",style: BackHeaderTopL)
//               ),
//               CardDots,
//               Expanded(
//                 child: Container(
//                     padding: PaddingField,
//                     child: Text("$price",style: BackHeaderTopR)
//                 ),
//               )
//             ],
//           ),
//           Row(
//             children: [
//               Container(
//                   padding: PaddingField,
//                   width: MediaQuery.of(context).size.width / 4.5,
//                   child: Text("USD Price",style: BackHeaderTopL)
//               ),
//               CardDots,
//               Expanded(
//                 child: Container(
//                     padding: PaddingField,
//                     child: Text("",style: BackHeaderTopR)
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   buildExpanded3(var payment_on) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 4.5,
//                 child: Text("Payment On",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("$payment_on" ?? "",style: FottorR)
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
//
//   openActionButton() {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
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
//                     child: Text("VISABOARD", style: TextStyle(fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,fontSize: 18),),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Text(
//                       "Are you sure you want to cancel order? Agent will get refund into their system wallet.",
//                       style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       TextButton(
//                         child: Text("Cancel",style: TextStyle(fontFamily: Constants.OPEN_SANS),),
//                         onPressed: () => Navigator.of(context).pop(),
//                       ),
//                       TextButton(
//                         child: Text("Ok",style: TextStyle(fontFamily: Constants.OPEN_SANS),),
//                         onPressed: (){
//                           Fluttertoast.showToast(msg: 'Testing Cancel Order/ Demo');
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//     );
//   }
// }
