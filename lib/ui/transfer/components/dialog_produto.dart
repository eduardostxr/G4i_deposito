import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:g4i_deposito/manager/user_manager.dart';
import 'package:g4i_deposito/utilitys/app_config.dart';
import 'package:g4i_deposito/models/product_model.dart';

class DialogProdutos extends StatefulWidget {
  // List<Produto> produtos = [];

  // DialogProdutos({required this.produtos});

  @override
  _DialogProdutosState createState() => _DialogProdutosState();
}

class _DialogProdutosState extends State<DialogProdutos> {
  List<Produto> produtos = [];
  bool isLoading = false;
  int selectedIndex = -1;
  TextEditingController filterController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    isLoading = true;
    setState(() {});
    produtos = await UserManager().loadProducts();
    isLoading = false;
    setState(() {});
  }

  List<Produto> get produtosFiltrados {
    String filter = filterController.text.toLowerCase();
    // return widget.produtos
    return produtos
        .where((produto) =>
            produto.nome.toLowerCase().contains(filter) ||
            produto.codProduto.contains(filter))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: markPrimaryColor,
          ))
        : Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 5),
                    TextField(
                        controller: filterController,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.production_quantity_limits,
                            color: markPrimaryColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: "Cod - Nome",
                          labelStyle:
                              TextStyle(fontSize: 20, color: markPrimaryColor),
                          alignLabelWithHint: false,
                        )),
                    const SizedBox(height: 15),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 3,
                              child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: produtosFiltrados.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;

                                          Navigator.pop(
                                              context, produtos[index]);
                                        });
                                      },
                                      child: ListTile(
                                        title: AutoSizeText(
                                          produtosFiltrados[index].codProduto +
                                              " - " +
                                              produtosFiltrados[index].nome,
                                          style: TextStyle(
                                            color: selectedIndex == index
                                                ? markPrimaryColor
                                                : textDarkColor,
                                            fontWeight: selectedIndex == index
                                                ? FontWeight.bold
                                                : FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
