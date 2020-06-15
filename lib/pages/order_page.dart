import 'package:flutter/material.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/models/shopping_cart_model.dart';
import 'package:meal/providers/products_provider.dart';
import 'package:meal/providers/shopping_cart_provider.dart';
import 'package:meal/providers/variables_providers.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<OrderPage> {
  String dropdownValue = 'Carry on';
  @override
  Widget build(BuildContext context) {
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
    final variablesProvider = Provider.of<VariablesProvider>(context);
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order",
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.delete_forever),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 5),
            TextField(
              textAlign: TextAlign.left,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Contact Number',
                hintStyle: TextStyle(
                  color: blackColors.withOpacity(0.5),
                  fontSize: media.width * 0.05,
                ),
              ),
              cursorColor: blackColors,
              cursorWidth: 1.0,
              style: TextStyle(
                color: blackColors,
                fontSize: media.width * 0.05,
              ),
              onChanged: (value) => {},
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text(
                  'Type Delivery',
                  style: TextStyle(
                    color: blackColors,
                    fontSize: media.width * 0.05,
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: blackColors),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Carry on',
                      'Delivery',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            (dropdownValue == 'Delivery')
                ? TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Direction',
                      hintStyle: TextStyle(
                        color: blackColors.withOpacity(0.5),
                        fontSize: media.width * 0.05,
                      ),
                    ),
                    cursorColor: blackColors,
                    cursorWidth: 1.0,
                    style: TextStyle(
                      color: blackColors,
                      fontSize: media.width * 0.05,
                    ),
                    onChanged: (value) => {},
                  )
                : SizedBox(height: 0),
            SizedBox(height: 10),
            Text('Comments',
                style: TextStyle(
                  color: blackColors,
                  fontSize: media.width * 0.05,
                )),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                  decoration: InputDecoration.collapsed(
                    hintText: "Comments about the purchase of the products",
                  ),
                  cursorColor: orangeColors,
                  cursorWidth: 1.0,
                  style: TextStyle(
                    color: blackColors,
                    fontSize: media.width * 0.05,
                  ),
                  onChanged: (value) => {},
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Products to buy',
                style: TextStyle(
                  color: blackColors,
                  fontSize: media.width * 0.05,
                )),
            _suggestedOptions(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blackColors,
        onPressed: () {
          setState(() {
            variablesProvider.total = 0;
            _shoppingCartProvider.deleteAll();

             Navigator.pushNamedAndRemoveUntil(context, Routes.home, (Route routes) => false);
          });
        },
        child: Icon(Icons.send, color: Colors.white),
      ),
    );
  }

  Widget _suggestedOptions() {
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();

    return FutureBuilder(
      future: _shoppingCartProvider.getShoppingCart(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return Center(child: LinearProgressIndicator());
        if (snapshot.data == null || snapshot.data.length == 0)
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
    final variablesProvider =
        Provider.of<VariablesProvider>(context, listen: false);
    print(_shoppingCart.idProduct);
    return FutureBuilder(
        future: _productProvider.getProduct(_shoppingCart.idProduct),
        builder: (BuildContext context, AsyncSnapshot snapProduct) {
          if (!snapProduct.hasData)
            return Center(child: LinearProgressIndicator());

          if (snapProduct.data == null || snapProduct.data.data == null)
            return Center(
                child: Text("You don't have a Meal in your Cart :'(."));

          ProductModel _product = ProductModel.fromJson(snapProduct.data.data);
          if (_product.availability == false)
            return Center(
                child: Text("You don't have a Meal in your Cart :'(."));

          return Column(
            children: <Widget>[
              Material(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                elevation: 2,
                child: ListTile(
                  title: Text(_product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        "Price: \$${_product.currentPrice * _shoppingCart.quantityProducts}",
                      ),
                      Text("Quantity: ${_shoppingCart.quantityProducts}"),
                      SizedBox(height: 10),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      setState(() {
                        variablesProvider.total = variablesProvider.total -
                            _product.currentPrice *
                                _shoppingCart.quantityProducts;
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
