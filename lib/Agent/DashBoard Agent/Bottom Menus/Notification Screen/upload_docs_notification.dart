// //@dart=2.9
// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../../../App Helper/Ui Helper/ui_helper.dart';
// import '../../../Authentication Pages/OnBoarding/constants/constants.dart';
//
//
// class UploadDocsNotifi extends StatefulWidget {
//   const UploadDocsNotifi({Key key}) : super(key: key);
//
//   @override
//   State<UploadDocsNotifi> createState() => _UploadDocsNotifi();
// }
//
// class _UploadDocsNotifi extends State<UploadDocsNotifi> {
//
//   File passwordcopy;
//   File offerLetter;
//   File otherDocs;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                     onPressed: (){
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.arrow_back)
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
//                   child: Text("Document Upload"),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//               child: Align(alignment: Alignment.topLeft,child: Text("Student Document",style: TextStyle(fontSize: 20,fontFamily: Constants.OPEN_SANS),)),
//             ),
//             const SizedBox(height: 10,),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Align(alignment: Alignment.topLeft,child: Text("Password Copy(Front, Last & All Remarked Pages)",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 15),)),
//                 ),
//                 const SizedBox(height: 5,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                   child: Card(
//                     elevation: 10,
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(5),
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: PrimaryColorOne
//                               ),
//                               onPressed: ()async {
//                                 try{
//                                   FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
//                                   if(pickedfile != null){
//                                     setState((){
//                                       passwordcopy = File(pickedfile.files.single.path);
//                                     });
//                                   }
//                                 }
//                                 on PlatformException catch (e) {
//                                   print(" File not Picked ");
//                                 }
//                               },
//                               child: passwordcopy == null
//                                   ? const Text("Choose File",style: TextStyle(color: Colors.white))
//                                   : const Text("File Picked",style: TextStyle(color: Colors.white))
//                           ),
//                         ),
//                         Padding(
//                             padding: const EdgeInsets.all(5),
//                             child: passwordcopy == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(passwordcopy.path.split('/').last,style: const TextStyle(fontSize: 9),))
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Align(alignment: Alignment.topLeft,child: Text("Offer Letter",style: TextStyle(fontSize: 15,fontFamily: Constants.OPEN_SANS),)),
//                 ),
//                 const SizedBox(height: 5,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                   child: Card(
//                     elevation: 10,
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(5),
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: PrimaryColorOne
//                               ),
//                               onPressed: ()async {
//                                 try{
//                                   FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
//                                   if(pickedfile != null){
//                                     setState((){
//                                       offerLetter = File(pickedfile.files.single.path);
//                                     });
//                                   }
//                                 }
//                                 on PlatformException catch (e) {
//                                   print(" File not Picked ");
//                                 }
//                               },
//                               child: offerLetter == null
//                                   ? const Text("Choose File",style: TextStyle(color: Colors.white))
//                                   : const Text("File Picked",style: TextStyle(color: Colors.white))
//                           ),
//                         ),
//                         Padding(
//                             padding: const EdgeInsets.all(5),
//                             child: offerLetter == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(offerLetter.path.split('/').last,style: const TextStyle(fontSize: 9),))
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10,),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Align(alignment: Alignment.topLeft,child: Text("Other Documents",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 15),)),
//                 ),
//                 const SizedBox(height: 5,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                   child: Card(
//                     elevation: 10,
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(5),
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: PrimaryColorOne
//                               ),
//                               onPressed: ()async {
//                                 try{
//                                   FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
//                                   if(pickedfile != null){
//                                     setState((){
//                                       otherDocs = File(pickedfile.files.single.path);
//                                     });
//                                   }
//                                 }
//                                 on PlatformException catch (e) {
//                                   print(" File not Picked ");
//                                 }
//                               },
//                               child: otherDocs == null
//                                   ? const Text("Choose File",style: TextStyle(color: Colors.white))
//                                   : const Text("File Picked",style: TextStyle(color: Colors.white))
//                           ),
//                         ),
//                         Padding(
//                             padding: const EdgeInsets.all(5),
//                             child: otherDocs == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(otherDocs.path.split('/').last,style: const TextStyle(fontSize: 9),))
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             InkWell(
//               onTap: (){},
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 10),
//                 child: Container(
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: PrimaryColorOne,
//                     borderRadius: const BorderRadius.all(Radius.circular(20)),
//                   ),
//                   child: const Text(
//                     "Submit Now",
//                     style: TextStyle(color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
