import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../App Helper/Ui Helper/ui_helper.dart';
import '../../Authentication Pages/OnBoarding/constants/constants.dart';

class LeadManageEdit extends StatefulWidget {
  const LeadManageEdit({Key? key}) : super(key: key);

  @override
  State<LeadManageEdit> createState() => _LeadManageEditState();
}

class _LeadManageEditState extends State<LeadManageEdit> {
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  String yesno = "";
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
                    icon: Icon(Icons.arrow_back)
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("446"),
                )
              ],
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 15, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Personal Details",style: TextStyle(fontSize: 20,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,letterSpacing: 1),),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Name Of Applicant',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: universityNM,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Email Id',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: universityEmail,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Mobile Number',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: agencyNM,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Date of Birth',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: agencyEmail,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'City',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: contactPerson,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Country',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: contactNumber,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Category',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("English Language Test",style: TextStyle(fontSize: 20,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,letterSpacing: 1)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Have you taken any English Language Proficiency Test?",style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 10),)
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: RadioListTile(
                                          title: Text("Yes",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
                                          value: "Yes",
                                          groupValue: yesno,
                                          onChanged: (value){
                                            setState(() {
                                              yesno = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: RadioListTile(
                                          title: Text("No",style: TextStyle(fontFamily: Constants.OPEN_SANS,letterSpacing: 0.5,fontSize: 10),),
                                          value: "No",
                                          groupValue: yesno,
                                          onChanged: (value){
                                            setState(() {
                                              yesno = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'English Test Type',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: universityNM,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Test Date',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: universityEmail,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Test Certificate Number',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.width / 7,
                                      child: TextField(
                                        //controller: universityNM,
                                        style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                        decoration: InputDecoration(
                                            hintText: 'Listening',
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
                                        //controller: universityEmail,
                                        style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                        decoration: InputDecoration(
                                            hintText: 'Reading',
                                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.width / 7,
                                      child: TextField(
                                        //controller: universityNM,
                                        style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                        decoration: InputDecoration(
                                            hintText: 'Writing',
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
                                        //controller: universityEmail,
                                        style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                        decoration: InputDecoration(
                                            hintText: 'Speaking',
                                            hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: universityEmail,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Over all',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Latest Academics",style: TextStyle(fontSize: 20,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,letterSpacing: 1)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Level of Study',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: universityNM,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Name of Institution',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: universityEmail,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Name of Course',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: agencyNM,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Percentage/CGPA/GPA',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: agencyEmail,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Primary Language of Instruction',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 2,
                                      height: MediaQuery.of(context).size.width / 6,
                                      child: TextField(
                                        controller: fromDate,
                                        decoration: InputDecoration(
                                            labelText: "From Date"
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2101)
                                          );
                                          if(pickedDate != null ){
                                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                            setState(() {
                                              fromDate.text = formattedDate;
                                            });
                                          }else{
                                            Fluttertoast.showToast(msg: "Date is not selected",);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 2,
                                      height: MediaQuery.of(context).size.width / 6,
                                      child: TextField(
                                        controller: toDate,
                                        decoration: InputDecoration(
                                            labelText: "To Date"
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime.now(),
                                          );
                                          if(pickedDate != null ){
                                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                            setState(() {
                                              toDate.text = formattedDate;
                                            });
                                          }else{
                                            Fluttertoast.showToast(msg: "Date is not selected",);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Others Detials",style: TextStyle(fontSize: 20,fontFamily: Constants.OPEN_SANS,fontWeight: FontWeight.bold,letterSpacing: 1)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Gap in No. of years',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: universityNM,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Do you want to apply Single or With Spouse?',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: universityEmail,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Reference (Referred By)',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 7,
                                child: TextField(
                                  //controller: agencyNM,
                                  style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Comment',
                                      hintStyle: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 12)
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
