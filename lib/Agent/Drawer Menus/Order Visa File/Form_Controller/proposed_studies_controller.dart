import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProposedController extends GetxController{

  var pageController;
  BuildContext? context;
  ProposedController({this.pageController,this.context});

  List<TextEditingController> eName = [TextEditingController()];
  List<TextEditingController> cName = [TextEditingController()];
  List<TextEditingController> campus = [TextEditingController()];
  List<TextEditingController> cInTake = [TextEditingController()];
  List<TextEditingController> eDate = [TextEditingController()];
  List<TextEditingController> eFees = [TextEditingController()];
  List<String?> offerLetter = ['no'];

  RxInt numberOfField = 1.obs;

}