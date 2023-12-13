import 'package:flutter/material.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

class ProductButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ProductButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: markPrimaryColor,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 80, 80, 80).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.search, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Selecionar Produto',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:g4i_deposito/utilitys/app_config.dart';

// class ProdutoInputCard extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode nextFocusNode;
//   final String labelText;
//   final IconData prefixIcon;
//   final IconData suffixIcon;
//   final Function? dialog;

//   const ProdutoInputCard(
//       {Key? key,
//       required this.controller,
//       required this.nextFocusNode,
//       required this.labelText,
//       required this.prefixIcon,
//       required this.suffixIcon,
//       this.dialog})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       width: MediaQuery.of(context).size.width * 0.9,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         elevation: 6,
//         child: TextFormField(
//           onTap: dialog != null ? () => dialog!() : null,
//           readOnly: true,
//           controller: controller,
//           keyboardType: TextInputType.none,
//           style: TextStyle(
//             fontSize: 20,
//             color: textDarkColor,
//           ),
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(bottom: 20),
//             border: InputBorder.none,
//             focusedBorder: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             errorBorder: InputBorder.none,
//             disabledBorder: InputBorder.none,
//             prefixIcon: Icon(
//               prefixIcon,
//               color: markPrimaryColor,
//             ),
//             suffixIcon: IconButton(
//               icon: Icon(suffixIcon, color: markPrimaryColor),
//               onPressed: dialog != null ? () => dialog!() : null,
//             ),
//             labelText: labelText,
//             labelStyle: TextStyle(fontSize: 20, color: markPrimaryColor),
//             alignLabelWithHint: false,
//           ),
//           onFieldSubmitted: (string) {
//             nextFocusNode.requestFocus();
//           },
//         ),
//       ),
//     );
//   }
// }
