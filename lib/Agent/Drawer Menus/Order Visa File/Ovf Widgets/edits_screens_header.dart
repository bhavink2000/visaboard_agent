// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../Authentication Pages/OnBoarding/constants/constants.dart';

class EditScreenHeader extends StatelessWidget {

  String? tabName, tabMessage;
  var tabStatus, tabIndex;

  EditScreenHeader({super.key,this.tabName,this.tabIndex,this.tabStatus,this.tabMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("$tabName",
                        style: TextStyle(fontFamily: Constants.OPEN_SANS,fontSize: 18,letterSpacing: 1),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("[ $tabIndex / 10 ]",
                            style: TextStyle(fontFamily: Constants.OPEN_SANS,color: tabStatus == 1 ? Colors.green : Colors.red,),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 2,
                            color: tabStatus == 1 ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                    ],
                  )
              )
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black45.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)]
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$tabMessage",style: TextStyle(fontSize: 13,fontFamily: Constants.OPEN_SANS,color: Colors.green),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
