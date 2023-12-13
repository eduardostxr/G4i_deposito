import 'package:flutter/material.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

class CardHomeEnabled extends StatelessWidget {
  IconData icon;
  String title;
  VoidCallback function;

  CardHomeEnabled(this.icon, this.title, this.function);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: InkWell(
          onTap: function,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          child:
                              Icon(icon, size: 32, color: markPrimaryColor))),
                  SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: textDarkColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ))),
    );
  }
}
