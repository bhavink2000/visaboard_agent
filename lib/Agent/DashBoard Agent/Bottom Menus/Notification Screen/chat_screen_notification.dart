//@dart=2.9
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../App Helper/Ui Helper/ui_helper.dart';
import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class ChatScreenNotification extends StatefulWidget {
  const ChatScreenNotification({Key key}) : super(key: key);

  @override
  State<ChatScreenNotification> createState() => _ChatScreenNotification();
}

class _ChatScreenNotification extends State<ChatScreenNotification> {

  File file;
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
                  child: Text("Inbox & Messages"),
                )
              ],
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Client Id  :"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("49"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Client Name  :"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("One Two Tr"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Service Type :"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Apostile"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Letter :"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Apostile"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Country:"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Australia"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Order Price  :"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("2000.00"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 2)]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sop Form",style: TextStyle(fontSize: 20,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,letterSpacing: 1)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.width / 7,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: 'University Name',
                                              hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.width / 7,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: 'Course Name',
                                              hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(7),
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width / 1.8,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: PrimaryColorOne
                                                  ),
                                                  onPressed: ()async {
                                                    try{
                                                      FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
                                                      if(pickedfile != null){
                                                        setState((){
                                                          file = File(pickedfile.files.single.path);
                                                        });
                                                      }
                                                    }
                                                    on PlatformException catch (e) {
                                                      print(" File not Picked ");
                                                    }
                                                  },
                                                  child: file == null
                                                      ? Text("Choose File",style: TextStyle(color: Colors.white))
                                                      : Text("File Picked",style: TextStyle(color: Colors.white))
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(5),
                                                child: file == null ? Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(file.path.split('/').last,style: TextStyle(fontSize: 9),))
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){},
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 80,vertical: 10),
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: PrimaryColorOne,
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                        ),
                                        child: Text(
                                          "Submit Now",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: PrimaryColorOne.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 3.8,
                                      height: MediaQuery.of(context).size.height / 6,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset("assets/image/icon.png",width: 50),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("VisaBoard \nTeam",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne,letterSpacing: 1),),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      height: MediaQuery.of(context).size.height / 6,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            color: PrimaryColorOne,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(" December 9th, 2022 10:17 AM ",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,fontSize: 10),),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("New client added in VisaBoard via Visa Board Student, University SOP of client Visa Demo Test",style: TextStyle(fontFamily: Constants.OPEN_SANS,color: PrimaryColorOne,fontSize: 12),),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  openNewMessage();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(1),
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),color: PrimaryColorOne,),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Icon(Icons.edit,color: Colors.white,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text("New Message",style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS),),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextEditingController subject = TextEditingController();
  TextEditingController descrption = TextEditingController();
  String _selectedValue;
  List<String> listOfValue = ['Complete Email', 'Query Email'];
  openNewMessage() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                      child: Text("New Message",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),),
                    ),
                    Divider(thickness: 1.5,color: PrimaryColorOne,),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: subject,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Subject',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: TextField(
                            controller: descrption,
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Description',
                                hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: MediaQuery.of(context).size.width / 6.5,
                            child: DropdownButtonFormField(
                              dropdownColor: Colors.white,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Select Email Type',
                                  hintStyle: TextStyle(fontSize: 10)
                              ),
                              value: _selectedValue,
                              style: TextStyle(fontSize: 18,fontFamily: Constants.OPEN_SANS,color: Colors.black),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              items: listOfValue.map((String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(val,style: TextStyle(fontSize: 12,fontFamily: Constants.OPEN_SANS,color: Colors.black),),
                                );
                              }).toList(),
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: PrimaryColorOne
                                    ),
                                    onPressed: ()async {
                                      try{
                                        FilePickerResult pickedfile = await FilePicker.platform.pickFiles(type: FileType.any);
                                        if(pickedfile != null){
                                          setState((){
                                            file = File(pickedfile.files.single.path);
                                          });
                                        }
                                      }
                                      on PlatformException catch (e) {
                                        print(" File not Picked ");
                                      }
                                    },
                                    child: file == null
                                        ? const Text("Choose File",style: TextStyle(color: Colors.white))
                                        : const Text("File Picked",style: TextStyle(color: Colors.white))
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: file == null ? const Text("No File Chosen",style: TextStyle(fontSize: 12),) : Expanded(child: Text(file.path.split('/').last,style: const TextStyle(fontSize: 9),))
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(32),
                            bottomLeft: Radius.circular(30),
                          ),color: PrimaryColorOne
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                  file = null;
                                  subject.text = "";
                                  descrption.text = "";
                                  _selectedValue = null;
                                },
                                child: Text(
                                  "Discard",
                                  style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const VerticalDivider(thickness: 1.5,color: Colors.white,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                              child: InkWell(
                                onTap: (){},
                                child: Text(
                                  "Send",
                                  style: TextStyle(color: Colors.white,fontFamily: Constants.OPEN_SANS,letterSpacing: 1.5),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
    ).then((value){
    });
  }
}
