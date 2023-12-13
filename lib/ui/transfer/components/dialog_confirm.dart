import 'package:flutter/material.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

class DialogConfirm extends StatefulWidget {
  final String codigo;
  final String produto;
  final String quantidade;
  final String unidade;

  const DialogConfirm({
    Key? key,
    required this.produto,
    required this.quantidade,
    required this.codigo,
    required this.unidade,
  }) : super(key: key);

  @override
  State<DialogConfirm> createState() => _DialogConfirmState();
}

class _DialogConfirmState extends State<DialogConfirm> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Deseja Confirmar",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: markPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Código Produto: ${widget.codigo}"),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Descrição: ${widget.produto}"),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                            "Quantidade: ${widget.quantidade} ${widget.unidade}"),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Cancelar pressed');
                        Navigator.of(context).pop(false);
                      },
                      child: Text('Cancelar'),
                      style: ElevatedButton.styleFrom(
                        primary: redColor,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Confirmar pressed');
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Confirmar'),
                      style: ElevatedButton.styleFrom(
                        primary: markPrimaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
