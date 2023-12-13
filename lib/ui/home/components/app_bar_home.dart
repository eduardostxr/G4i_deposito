import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

class AppBarWidget extends PreferredSize {
  final double height;
  final String title;

  AppBarWidget(this.height, this.title)
      : super(child: Text(""), preferredSize: Size.fromHeight(height / 8));

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[markPrimaryColor, markSecondaryColor],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    presetFontSizes: [17, 14],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Seja Bem-Vindo!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 90,
              width: 90,
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  "lib/assets/images/logo.png",
                ),
              ),
            ),
          ],
        ),
      ),
      preferredSize: Size.fromHeight(height / 8),
    );
  }
}
