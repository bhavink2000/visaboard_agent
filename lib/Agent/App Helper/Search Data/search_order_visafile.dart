// //@dart=2.9
// // ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:expandable/expandable.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import '../../Authentication Pages/OnBoarding/constants/constants.dart';
// import '../../Drawer Menus/Order Visa File/chat_screen_order_visa_file.dart';
// import '../../Drawer Menus/Order Visa File/edit_screen_order_visa_file.dart';
// import '../../Drawer Menus/Order Visa File/order_visa_file.dart';
// import '../../Drawer Menus/Order Visa File/upload_docs_screen.dart';
// import '../Api Repository/api_urls.dart';
// import '../Ui Helper/icons_helper.dart';
// import '../Ui Helper/loading_always.dart';
// import '../Ui Helper/ui_helper.dart';
// import '../custom_pagination_widget.dart';
//
// class OrderVisaFileSearch extends SearchDelegate{
//   var access_token;
//   BuildContext context;
//   OrderVisaFileSearch({Key key,this.access_token,this.context});
//
//   var jsonData;
//   int curentindex = 0;
//   Future<List<dynamic>> getItemsData(var index) async {
//
//     final url = Uri.parse("${ApiConstants.getOrderVisaFile}?page=$index");
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
//                                           item['user_id'],
//                                           item['first_name'],
//                                           item['middle_name'],
//                                           item['last_name'],
//                                         ),
//                                         expanded: buildExpanded1(),
//                                       ),
//                                       Expandable(
//                                         collapsed: buildCollapsed3(
//                                           item['user_sop_status'],
//                                           item['action']['edit_status'],
//                                           item['action']['upload_docs_status'],
//                                           item['action']['chat_status'],
//                                           item['action']['paynow_status'],
//                                           item['invoice_pdf'],
//                                           item['user_id'],
//                                           item['enc_id'],
//                                           item['first_name'],
//                                           item['last_name'],
//                                           item['service_name'],
//                                           item['letter_type_name'],
//                                           item['create_at'],
//                                           item['order_price'],
//                                           item['enc_id'],
//                                           item['enc_user_id'],
//                                         ),
//                                         expanded: buildExpanded3(
//                                           item['service_name'],
//                                           item['letter_type_name'],
//                                           item['create_at'],
//                                           item['order_price'],
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
//   buildCollapsed1(var id, var first_nm, var middle_nm, var last_nm){
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: PrimaryColorOne,
//       //padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
//       child: Row(
//         children: [
//           Container(
//               padding: PaddingField,
//               child: Text("Case ID. $id" ?? "",style: FrontHeaderID)
//           ),
//           CardDots,
//           Expanded(
//             child: Container(
//                 padding: PaddingField,
//                 child: Text("$first_nm $middle_nm $last_nm",style: FrontHeaderNM)
//             ),
//           )
//         ],
//       ),
//     );
//   }
//   buildCollapsed3(
//       var userStatus,var edit, var upload, var chat, var pay, var invoice,
//       var id,var c_id, var c_fnm, var c_lnm,var s_nm, var l_nm, var country_nm,var o_price, var user_sop_id, var user_id) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 6,
//                 child: Text("Status",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
//               child: Container(
//                   padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
//                   color: userStatus == "Completed" ? Colors.green : userStatus == "In-Process" ? Colors.orange : Colors.red,
//                   child: Text(
//                       userStatus == "Completed"
//                           ? "$userStatus"
//                           : "$userStatus",
//                       style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white,fontSize: 11
//                       )
//                   )
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 6,
//                 child: Text("Action",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.black87,fontSize: 11))
//             ),
//             const Text(":",style: TextStyle(color: Colors.black87)),
//             Row(
//               children: [
//                 pay == 1 ? InkWell(
//                   onTap: (){
//                     Fluttertoast.showToast(msg: "Pay Now");
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                     child: IconsHelper().WalletIcon,
//                   ),
//                 ) : Container(),
//                 chat == 1 ? InkWell(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreenOrderVisaFile(
//                       client_id: c_id,
//                       c_id: id,
//                       client_fnm: c_fnm,
//                       client_lnm: c_lnm,
//                       service_nm: s_nm,
//                       letter_nm: l_nm,
//                       country_nm: country_nm,
//                       order_p: o_price,
//                       user_sop_id: user_sop_id,
//                     )));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                     child: IconsHelper().ChatIcon,
//                   ),
//                 ) : Container(),
//                 edit == 1 ? InkWell(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderVisaFile(user_id: user_id,user_sop_id: user_sop_id)));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                     child: IconsHelper().EditIcon,
//                   ),
//                 ) : Container(),
//                 upload == 1 ?InkWell(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadDocs(user_sop_id: user_sop_id,user_id: user_id,)));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                     child: IconsHelper().UploadIcon,
//                   ),
//                 ) : Container(),
//                 invoice != null ?InkWell(
//                   onTap: (){
//                     launch("$invoice");
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                     child: IconsHelper().InvoiceIcon,
//                   ),
//                 ) : Container(),
//               ],
//             )
//           ],
//         )
//       ],
//     );
//   }
//
//   buildExpanded1() {
//     return Container();
//   }
//   buildExpanded3(var service_nm, var letter_nm, var create_on, var price) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 4.5,
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
//                 width: MediaQuery.of(context).size.width / 4.5,
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
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 4.5,
//                 child: Text("Created on",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("$create_on" ?? "",style: FottorR)
//               ),
//             )
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//                 padding: PaddingField,
//                 width: MediaQuery.of(context).size.width / 4.5,
//                 child: Text("Order Price	",style: FottorL)
//             ),
//             const Text(":",style: TextStyle(color: Colors.black)),
//             Expanded(
//               child: Container(
//                   padding: PaddingField,
//                   child: Text("₹$price" ?? "",style: FottorR)
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
//
//   TextEditingController subject = TextEditingController();
//   TextEditingController descrption = TextEditingController();
//   File file;
//   String _selectedValueemail;
//   List<String> listOfValueemail = ['Complete Email', 'Query Email'];
//   openSendNewMessage() {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
//             contentPadding: const EdgeInsets.only(top: 10.0),
//             content: StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState){
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
//                       child: Text("New Message",style: TextStyle(fontFamily: Constants.OPEN_SANS,),),
//                     ),
//                     Divider(thickness: 1.5,color: PrimaryColorOne,),
//                     Flexible(
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.width / 7,
//                           child: TextField(
//                             controller: subject,
//                             style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
//                             decoration: InputDecoration(
//                                 hintText: 'Subject',
//                                 hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.width / 7,
//                           child: TextField(
//                             controller: descrption,
//                             style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
//                             decoration: InputDecoration(
//                                 hintText: 'Description',
//                                 hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                         child: SizedBox(
//                             width: MediaQuery.of(context).size.width / 3.5,
//                             height: MediaQuery.of(context).size.width / 6.5,
//                             child: DropdownButtonFormField(
//                               dropdownColor: Colors.white,
//                               decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: 'Select Email Type',
//                                   hintStyle: TextStyle(fontSize: 10)
//                               ),
//                               value: _selectedValueemail,
//                               style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
//                               isExpanded: true,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedValueemail = value;
//                                 });
//                               },
//                               onSaved: (value) {
//                                 setState(() {
//                                   _selectedValueemail = value;
//                                 });
//                               },
//                               validator: (String value) {
//                                 if (value.isEmpty) {
//                                   return "can't empty";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               items: listOfValueemail.map((String val) {
//                                 return DropdownMenuItem(
//                                   value: val,
//                                   child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
//                                 );
//                               }).toList(),
//                             )
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                       child: Card(
//                         elevation: 10,
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(5),
//                               child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(backgroundColor: PrimaryColorOne),
//                                   onPressed: ()async {
//                                     try{
//                                       FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
//                                       if(pickedfile != null){
//                                         setState((){
//                                           file = File(pickedfile.files.single.path);
//                                         });
//                                       }
//                                     }
//                                     on PlatformException catch (e) {
//                                       print(" File not Picked ");
//                                     }
//                                   },
//                                   child: file == null
//                                       ? const Text("Choose File",style: TextStyle(color: Colors.white))
//                                       : const Text("File Picked",style: TextStyle(color: Colors.white))
//                               ),
//                             ),
//                             Padding(
//                                 padding: const EdgeInsets.all(5),
//                                 child: file == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12)) : Expanded(child: Text(file.path.split('/').last,style: const TextStyle(fontSize: 9),))
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.only(
//                             bottomRight: Radius.circular(32),
//                             bottomLeft: Radius.circular(30),
//                           ),color: PrimaryColorOne
//                       ),
//                       child: IntrinsicHeight(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
//                               child: InkWell(
//                                 onTap: (){
//                                   Navigator.pop(context);
//                                   file = null;
//                                   subject.text = "";
//                                   descrption.text = "";
//                                 },
//                                 child: Text(
//                                   "Discard",
//                                   style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                             const VerticalDivider(thickness: 1.5,color: Colors.white,),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
//                               child: InkWell(
//                                 onTap: (){},
//                                 child: Text(
//                                   "Send",
//                                   style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           );
//         }
//     ).then((value){
//     });
//   }
// }