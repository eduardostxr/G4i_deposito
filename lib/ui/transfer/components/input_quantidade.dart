import 'package:flutter/material.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

class QuantidadeInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final String labelText;
  final IconData prefixIcon;
  final Function(String) onChanged;

  QuantidadeInput({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.nextFocusNode,
    required this.labelText,
    required this.prefixIcon,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextFormField(
          onChanged: (value) {
            onChanged(value);
          },
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 5),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixIcon: Icon(
              prefixIcon,
              color: markPrimaryColor,
            ),
            labelText: 'Quantidade',
            labelStyle: TextStyle(fontSize: 20, color: markPrimaryColor),
          ),
        ),
      ),
    );
  }
}
