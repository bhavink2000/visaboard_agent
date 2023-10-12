// ignore_for_file: missing_return, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

import '../../App Helper/Api Repository/api_urls.dart';
import '../../App Helper/Enums/enums_status.dart';
import '../../App Helper/Get Access Token/get_access_token.dart';
import '../../App Helper/Models/Drawer Menus Model/upload_docs_model.dart';
import '../../App Helper/Providers/Drawer Data Provider/drawer_menu_provider.dart';
import '../../App Helper/Routes/App Routes/drawer_menus_routes_names.dart';
import '../../App Helper/Ui Helper/error_helper.dart';
import '../../App Helper/Ui Helper/loading_always.dart';
import '../../App Helper/Ui Helper/snackbar_msg_show.dart';
import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';

class UploadDocs extends StatefulWidget {
  var user_sop_id,user_id;
  UploadDocs({Key? key,this.user_sop_id,this.user_id}) : super(key: key);

  @override
  State<UploadDocs> createState() => _UploadDocsState();
}

class _UploadDocsState extends State<UploadDocs> {

  File? documents;
  Map<Docs, List<File>> selectedDocumentsMap = {};

  GetAccessToken getAccessToken = GetAccessToken();
  AgentDrawerMenuProvider agentDrawerMenuProvider = AgentDrawerMenuProvider();

  final GlobalKey<ScaffoldState> key = GlobalKey();
  String search = '';
  int curentindex = 0;

  @override
  void initState() {
    super.initState();
    getAccessToken.checkAuthentication(context, setState);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        agentDrawerMenuProvider.fetchUploadDocs(widget.user_sop_id, getAccessToken.access_token);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                  child: Text("Documents Upload"),
                )
              ],
            ),
            Expanded(
              child: ChangeNotifierProvider<AgentDrawerMenuProvider>(
                create: (BuildContext context)=>agentDrawerMenuProvider,
                child: Consumer<AgentDrawerMenuProvider>(
                  builder: (context, value, __){
                    switch(value.uploadDOcsData.status!){
                      case Status.loading:
                        return CenterLoading();
                      case Status.error:
                        return const ErrorHelper();
                      case Status.completed:
                        return ListView.builder(
                          itemCount: value.uploadDOcsData.data!.data.docs.length,
                          itemBuilder: (context, index){
                            String key = value.uploadDOcsData.data!.data.docs.keys.elementAt(index);
                            List<Docs>? docsList = value.uploadDOcsData.data!.data.docs[key];
                            var sID = value.uploadDOcsData.data!.data.serviceTypeId;
                            var lID = value.uploadDOcsData.data!.data.letterTypeId;
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: ExpansionTile(
                                    title: Text(key,style: TextStyle(fontFamily: Constants.OPEN_SANS)),
                                    backgroundColor: Colors.white,
                                    collapsedBackgroundColor: PrimaryColorOne,
                                    collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    collapsedIconColor: Colors.white,
                                    collapsedTextColor: Colors.white,
                                    children: docsList!.map((Docs docs) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                        child: ExpansionTile(
                                          title: Text(docs.documentTitle,style: TextStyle(fontFamily: Constants.OPEN_SANS)),
                                          collapsedBackgroundColor: PrimaryColorOne,
                                          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          collapsedIconColor: Colors.white,
                                          collapsedTextColor: Colors.white,
                                          backgroundColor: Colors.white,
                                          trailing: InkWell(
                                            onTap: ()async{
                                              try {
                                                FilePickerResult? pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
                                                if (pickedfile != null) {
                                                  setState(() {
                                                    documents = File(pickedfile.files.single.path!);
                                                    if (selectedDocumentsMap.containsKey(docs)) {
                                                      selectedDocumentsMap[docs]!.add(documents!);
                                                    } else {
                                                      selectedDocumentsMap[docs] = [documents!];
                                                    }
                                                  });
                                                }
                                              } on PlatformException catch (e) {
                                                print("e -> $e");
                                                print("File not Picked");
                                              }
                                            },
                                            child: const Icon(Icons.add_circle_rounded),
                                          ),
                                          subtitle: selectedDocumentsMap.containsKey(docs)
                                              ? Column(
                                            children: selectedDocumentsMap[docs]!.map((file) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: PrimaryColorOne.withOpacity(0.8)),
                                                    child: Text(file.path.split('/').last,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ) : Container(),
                                          children: docs.uploadedDocs.map((doc) {
                                            return Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                              child: Card(
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                child: Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                  padding: const EdgeInsets.all(5),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width / 1.5,
                                                        child: Text(
                                                          "${doc['doc_name']}",
                                                          style: TextStyle(fontFamily: Constants.OPEN_SANS),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5,),
                                                      InkWell(
                                                        onTap: (){
                                                          deleteDocs(doc['id']);
                                                        },
                                                        child: Icon(Icons.delete_forever_rounded,color: PrimaryColorOne,size: 20)
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                index + 1 == value.uploadDOcsData.data!.data.docs.length ? Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 20, 20, 10),
                                  child: InkWell(
                                    onTap: (){
                                      uploadSelectedDocuments(sID, lID);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: PrimaryColorOne),
                                      child: Text("Upload",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: Colors.white),),
                                    ),
                                  ),
                                ) : Container(),
                              ],
                            );
                          },
                        );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteDocs(var docsId) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${getAccessToken.access_token}',
    };
    try {
      final response = await http.post(
        Uri.parse("https://visaboard.in/api/vb-agent/user/upload-document/delete"),
        body: {'id': docsId.toString()},
        headers: headers,
      );
      final responseData = json.decode(response.body);
      final bodyStatus = responseData['status'];
      final bodyMSG = responseData['message'];

      if (bodyStatus == 200) {
        SnackBarMessageShow.successsMSG('$bodyMSG', context);
        Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
      } else {
        print("e->$bodyMSG");
        SnackBarMessageShow.errorMSG('$bodyMSG', context);
      }
    } catch (error) {
      print('Error: $error');
      SnackBarMessageShow.errorMSG('Something went wrong', context);
    }
  }

  Future<void> uploadSelectedDocuments(var sId, var lId) async {

    int totalDocuments = 0;
    int uploadedDocuments = 0;

    for (var entry in selectedDocumentsMap.entries) {
      Docs docs = entry.key;
      List<File> selectedFiles = entry.value;
      totalDocuments += selectedFiles.length;

      for (var file in selectedFiles) {
        try {
          final dio = Dio(BaseOptions(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${getAccessToken.access_token}',
              'Accept': 'application/json',
            },
          ));

          final formData = FormData.fromMap({
            'user_id': widget.user_id,
            'user_sop_id': widget.user_sop_id,
            'current_country_doc[${docs.serviceTypeDocumentId}][0][id]': docs.serviceTypeDocumentId,
            'current_country_doc[${docs.serviceTypeDocumentId}][0][doc][]': await MultipartFile.fromFile(file.path),
            'current_country_doc[${docs.serviceTypeDocumentId}][0][doc_name]': docs.documentTitle,
            'service_type_id': sId,
            'letter_type_id': lId,
          });

          print("Form Data -> ${formData.fields}");
          final response = await dio.post(
            ApiConstants.getUploadDocs,
            data: formData,
            onSendProgress: (sent, total) {
              print('$sent $total');
            },
          );

          print("Response D -> ${response.data}");
          print("Response C-> ${response.statusCode}");
          print("Response M-> ${response.statusMessage}");

          if (response.statusCode == 200) {
            uploadedDocuments++;

            if(uploadedDocuments == totalDocuments){
              final jsonResponse = response.data;
              final status = jsonResponse['status'];
              final message = jsonResponse['message'];

              if (status == 200) {
                SnackBarMessageShow.successsMSG('$message', context);
                Navigator.pushNamed(context, DrawerMenusName.order_visa_file);
              } else {
                SnackBarMessageShow.errorMSG('$message', context);
                Navigator.pop(context);
              }
            }
          } else {
            SnackBarMessageShow.errorMSG('Something went wrong', context);
            Navigator.pop(context);
          }
        } on DioError catch (error) {
          if (error.type == error.response) {
            final response = error.response;
            final message = response?.data['message'] ?? 'Something went wrong';
            SnackBarMessageShow.errorMSG('$message', context);
          } else {
            SnackBarMessageShow.errorMSG('Something went wrong', context);
          }
          Navigator.pop(context);
        } catch (error) {
          SnackBarMessageShow.errorMSG('Something went wrong', context);
          Navigator.pop(context);
        }
      }
    }
  }
}
