import 'package:flutter/material.dart';

String version = "1.0.0";

typedef MapSD = Map<String, dynamic>;

MaterialColor? materialMarkPrimaryColor =  const Color(0xFF479A47) as MaterialColor?;
const Color markPrimaryColor = Color(0xFF479A47);
const Color markSecondaryColor = Colors.green;
final Color markTertiaryColor = Colors.yellow[400]!;
final Color backgroundColor = Colors.grey[200]!;
const Color inativeColor = Color(0xFFE0E0E0);
final Color redColor = Colors.red[700]!;

final Color textDarkColor = Colors.grey[800]!;
final Color colorCard = Colors.grey[350]!;
const Color inactiveColor = Color(0xFFE0DDDD);
const Color blackText = Colors.black54;

const String companyLogo = "assets/images/logo.jpeg";

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;

String getSaudacaoText({required String user}) {
  DateTime now = DateTime.now();
  if (user != "") {
    if (now.hour < 12 && now.hour >= 6) return "Bom dia, $user";
    if (now.hour >= 12 && now.hour <= 18) return "Boa tarde, $user";
    if (now.hour >= 19 || now.hour < 6) return "Boa noite, $user";
  }
  return "Bem vindo";
}

String formatWordToLower(String word, {int? maxWords}) {
  List<String> words = word.trim().split(" ");
  if (maxWords == null) maxWords = words.length;
  String newDescricao = "";

  int count = 1;
  words.forEach((w) {
    if (w.length > 0 && maxWords! >= count) {
      newDescricao += w.substring(0, 1).toUpperCase();
      newDescricao += w.substring(1).toLowerCase();
      newDescricao += " ";
      count++;
    }
  });

  return newDescricao.trim();
}
