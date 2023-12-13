import 'package:flutter/material.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

class InfoField extends StatefulWidget {
  const InfoField({
    Key? key,
    required this.codigo,
    required this.descricao,
  }) : super(key: key);

  final String codigo;
  final String descricao;

  @override
  State<InfoField> createState() => _InfoFieldState();
}

class _InfoFieldState extends State<InfoField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 20,
                        color: markPrimaryColor,
                      ),
                  children: [
                    TextSpan(
                      text: "Codigo: ",
                    ),
                    TextSpan(
                      text: widget.codigo,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 20,
                        color: markPrimaryColor,
                      ),
                  children: [
                    TextSpan(
                      text: "Descrição: ",
                    ),
                    TextSpan(
                      text: widget.descricao,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
