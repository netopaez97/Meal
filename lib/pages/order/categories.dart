import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/pages/order/buy_page.dart';
import 'package:meal/pages/order/detail_page.dart';
import 'package:meal/providers/products_provider.dart';

class CategoriesPage extends StatefulWidget {

  static const routeName = '/category';
  final String _category;

  CategoriesPage(this._category,{Key key}) : super(key:key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _barraSuperior(widget._category),
      body: _cuerpoPagina(widget._category),
    );
  }

  AppBar _barraSuperior(String _categoria){

    return AppBar(
      title: Text("${_categoria[0].toUpperCase()}${_categoria.substring(1).toLowerCase()}"),
    );
  }

  Widget _cuerpoPagina(String _categoria){


    ProductsProvider _productsProvider = ProductsProvider();

    return StreamBuilder(
      stream: _productsProvider.getProductsByCategory(widget._category),
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        if(snapshot.data.documents.length == 0)
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child:Text("There are no products available for the $_categoria category.", textAlign: TextAlign.center,)),
          );
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, item){

            final temp = Map<String, dynamic>.from(
                snapshot.data.documents[item].data);
            ProductModel _producto = ProductModel.fromJson(temp);
            _producto.idProduct =
                snapshot.data.documents[item].documentID;

            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                // onPressed: ()=>Navigator.pushNamedAndRemoveUntil(context, Routes.home, (Route routes)=>false),
                onPressed: () {
                  //Aquí debo llamar a lo de agregar producto al carrito
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        ProductDetailPage(_producto));
                    },
                child: GridTile(
                  child: _imagenRestaurante(_producto.image),
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => BuyPage(_producto),
                          );
                        },
                      ),
                      title: Text(_producto.name),
                    ),
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }

  Widget _imagenRestaurante(String urlImage){
    if(urlImage!=null && urlImage != "")
      return Image.network(urlImage);
    else
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: CircleAvatar(child: Image.asset("assets/default.png")),
      );
  }
}