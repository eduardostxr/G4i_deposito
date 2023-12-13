import 'package:flutter/material.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

class ObservacaoInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final String labelText;
  final IconData prefixIcon;

  ObservacaoInput({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.nextFocusNode,
    required this.labelText,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 6,
        child: TextFormField(
          maxLines: 5,
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.text,
          style: const TextStyle(
              fontSize: 20,
              // fontFamily: primaryFont,
              color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.production_quantity_limits,
              color: markPrimaryColor,
            ),
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 20, color: markPrimaryColor),
            alignLabelWithHint: false,
          ),
        ),
      ),
    );
  }
}
