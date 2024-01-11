import 'package:flutter/material.dart';
import 'package:g4i_deposito/manager/user_manager.dart';
import 'package:g4i_deposito/models/product_model.dart';
import 'package:g4i_deposito/models/movement_model.dart';
import 'package:g4i_deposito/services/querys/ws_movement.dart';
import 'package:g4i_deposito/services/ws_controller.dart';
import 'package:g4i_deposito/ui/transfer/components/dialog_confirm.dart';
import 'package:g4i_deposito/ui/transfer/components/dialog_produto.dart';
import 'package:g4i_deposito/ui/transfer/components/input_observacao.dart';
import 'package:g4i_deposito/ui/transfer/components/info_produto.dart';
import 'package:g4i_deposito/ui/transfer/components/btn_produto.dart';
import 'package:g4i_deposito/ui/transfer/components/input_quantidade.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';

class PageTranfereProduto extends StatefulWidget {
  const PageTranfereProduto(
      {Key? key,
      required this.userName,
      required this.transferType,
      required this.userId})
      : super(key: key);

  final String userName;
  final String transferType;
  final String userId;

  @override
  State<PageTranfereProduto> createState() => _PageTranfereProdutoState();
}

class _PageTranfereProdutoState extends State<PageTranfereProduto> {
  // List<Produto> produtos = [];
  Produto objetoProduto =
      Produto(codProduto: "", nome: "", grupo: "", unidade: "");
  final TextEditingController controllerProduto = TextEditingController();
  final TextEditingController controllerQuantidade = TextEditingController();
  final TextEditingController controllerObservacao = TextEditingController();

  String textCodigo = "";
  String textProduto = "";

  final focusProduto = FocusNode();
  final focusQuantidade = FocusNode();
  final focusObservacao = FocusNode();

  MovimentoModel movimento = MovimentoModel(
      produto: "", tipo: "", quantidade: 0, date: DateTime.now(), usuario: "");

  bool enableBtn = false;
  bool isLoading = false;
  bool execConfirmationBtn = false;

  String tipo = "";
  String usuario = "";
  String produto = "";
  String quantidade = '';
  String descricao = '';
  String descricaoUltimo = '';
  DateTime data = DateTime.now();

  bool isEnabled() {
    return textCodigo.isNotEmpty &&
        textProduto.isNotEmpty &&
        controllerQuantidade.text.isNotEmpty;
  }

  Future<void> _produtosBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DialogProdutos();
      },
    ).then((value) {
      objetoProduto = value as Produto;
      textCodigo = objetoProduto.codProduto;
      textProduto = objetoProduto.nome;
      focusQuantidade.requestFocus();
      setState(() => {});
    });
  }

  Future<void> _confirmarBuilder(BuildContext context, String produto,
      String quantidade, String codigo, String unidade) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DialogConfirm(
            produto: produto,
            quantidade: quantidade,
            codigo: codigo,
            unidade: unidade);
      },
    ).then((value) {
      execConfirmationBtn = value as bool;
      if (execConfirmationBtn) {
        movimento.produto = objetoProduto.codProduto;
        movimento.tipo = widget.transferType;
        movimento.quantidade = double.parse(controllerQuantidade.text);
        movimento.observacao = controllerObservacao.text;
        movimento.date = DateTime.now();
        movimento.usuario = widget.userId;

        print(movimento.produto);

        WsController().postMovementOnWs(movimento);

        textCodigo = "";
        textProduto = "";
        controllerQuantidade.text = '';
        controllerObservacao.text = '';
        focusProduto.requestFocus();

        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Produto Enviado com Sucesso',
            textAlign: TextAlign.center,
          ),
          backgroundColor: markPrimaryColor,
        ));

        setState(() {});
      }
    });
  }

  void _updateEnableBtn() {
    if (controllerProduto.text.isNotEmpty &&
        controllerQuantidade.text.isNotEmpty) {
      setState(() {
        enableBtn = true;
      });
    } else {
      setState(() {
        enableBtn = false;
      });
    }
  }

  @override
  void initState() {
    // loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: markPrimaryColor,
        title: Text(
          'Transferência de ${widget.transferType}',
          textAlign: TextAlign.center,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: markPrimaryColor,
            ))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ProductButton(
                          onPressed: () => {_produtosBuilder(context)}),
                      SizedBox(
                        height: 16,
                      ),
                      InfoField(
                        codigo: textCodigo,
                        descricao: textProduto,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      QuantidadeInput(
                        controller: controllerQuantidade,
                        focusNode: focusQuantidade,
                        nextFocusNode: focusObservacao,
                        labelText: "Quantidade",
                        prefixIcon: Icons.add_box_outlined,
                        unidade: objetoProduto.unidade,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ObservacaoInput(
                        controller: controllerObservacao,
                        focusNode: focusObservacao,
                        nextFocusNode: focusQuantidade,
                        labelText: 'Observação',
                        prefixIcon: Icons.abc,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Ink(
                        decoration: BoxDecoration(
                          color: isEnabled() ? markPrimaryColor : inactiveColor,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 107, 107, 107)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25.0),
                          onTap: () {
                            if (isEnabled()) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                produto = controllerProduto.text;
                                quantidade = controllerQuantidade.text;
                                descricaoUltimo = descricao;
                                descricao = '';
                              });
                              _confirmarBuilder(
                                  context,
                                  objetoProduto.nome,
                                  quantidade,
                                  objetoProduto.codProduto,
                                  objetoProduto.unidade);
                              // movimento.tipo = widget.transferType;
                              // movimento.usuario = widget.userName;
                              // movimento.produto = controllerProduto.text;
                              // movimento.quantidade =
                              //     double.parse(controllerQuantidade.text);
                              // movimento.date = DateTime.now();
                              // movimento.observacao = controllerObservacao.text;
                              // print(
                              //     MovimentoModel.toJson(movimento).toString());
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 60,
                            child: Center(
                              child: Text(
                                'Confirmar ${widget.transferType}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
