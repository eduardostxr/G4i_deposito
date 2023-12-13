import 'package:flutter/material.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

class TransfereSnackBar extends StatelessWidget {
  const TransfereSnackBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: redColor),
      child: OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("SnackBar")));
          },
          child: Text("data")),
    );
  }
}
