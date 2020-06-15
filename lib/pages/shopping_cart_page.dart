import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/pages/purchase/order_page.dart';
import 'package:meal/providers/products_provider.dart';
import 'package:meal/providers/shopping_cart_provider.dart';
import 'package:meal/utils/utils.dart';

class ShoppingCartPage extends StatefulWidget {
  static const routeName = 'ShoppingCartPage';

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  double total = 0;
  @override
  Widget build(BuildContext context) {
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();

    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              setState(() {
                _shoppingCartProvider.deleteAll();
              });
            },
          )
        ],
      ),
      body: _suggestedOptions(),
      bottomNavigationBar: Card(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: media.width * 0.03,
              height: media.width * 0.1,
            ),
            Expanded(
                child: Text(
              'Total price = \$$total',
              style: TextStyle(color: blackColors),
              textScaleFactor: media.width * 0.004,
            )),
            InkWell(
              onTap: () {
                setState(() {
                  total = 0;
                  _shoppingCartProvider.deleteAll();
                });
                showDialog(
                  context: context,
                  builder: (BuildContext context) => OrderPage(),
                );
              },
              child: Card(
                elevation: 5,
                color: orangeColors,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                      height: media.width * 0.1,
                    ),
                    Text(
                      "Buy",
                      style: TextStyle(color: Colors.white),
                      textScaleFactor: media.width * 0.005,
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.shopping_cart,
                      size: media.width * 0.07,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: media.width * 0.03,
              height: media.width * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _suggestedOptions() {
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();

    return FutureBuilder(
      future: _shoppingCartProvider.getShoppingCart(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if(!snapshot.hasData)
          return Center(child: LinearProgressIndicator());
        if(snapshot.data == null || snapshot.data.length == 0)
          return Center(child: Text("You don't have a Meal in your Cart :'(."));

        final shoppingCart = snapshot.data;
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            itemCount: shoppingCart.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, i) => _option(shoppingCart[i]),
          ),
        );
      },
    );
  }

  Widget _option(ShoppingCartModel _shoppingCart) {
    final ProductsProvider _productProvider = ProductsProvider();
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();

    print(_shoppingCart.idProduct);
    return FutureBuilder(
        future: _productProvider.getProduct(_shoppingCart.idProduct),
        builder:(BuildContext context, AsyncSnapshot snapProduct) {

          if (!snapProduct.hasData)
            return Center(child: LinearProgressIndicator());

          if (snapProduct.data == null || snapProduct.data.data == null)
            return Center(
                child: Text("You don't have a Meal in your Cart :'(."));
          
          total = total + snapProduct.data.data["currentPrice"]*_shoppingCart.quantityProducts;

          ProductModel _product = ProductModel.fromJson(snapProduct.data.data);



          return Column(
            children: <Widget>[
              Material(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                elevation: 2,
                child: ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: MediaQuery.of(context).size.width * 0.1,
                      child: Image.network(
                        _product.image,
                      )),
                  title: Text(_product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        "Price: \$${_product.currentPrice * _shoppingCart.quantityProducts}",
                      ),
                      Text("Quantity: ${_shoppingCart.quantityProducts}"),
                      _shoppingCart.productComment.length > 40
                          ? Text(_shoppingCart.productComment.substring(0, 40) +
                              "...")
                          : Text(_shoppingCart.productComment),
                      SizedBox(height: 10),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      setState(() {
                        _shoppingCartProvider
                            .deleteShoppingCart(_shoppingCart.idCar);
                      });
                    },
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
            ],
          );
        });
  }
}
