import 'package:flutter/material.dart';
import 'package:visaboard_agent/Agent/App%20Helper/Ui%20Helper/ui_helper.dart';

class EditSTextField extends StatelessWidget {

  final TextEditingController controller;
  final String labelName;
  final bool? readOnly;
  final TextInputType keyboardType;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const EditSTextField({super.key,required this.controller,required this.labelName,this.readOnly = false,this.onTap,this.onChanged,this.validator,this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: TextFormField(
        controller: controller,
        decoration: editFormsInputDecoration('$labelName'),
        readOnly: readOnly!,
        onTap: onTap,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
      ),
    );
  }
}
