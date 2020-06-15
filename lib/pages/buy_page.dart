import 'package:flutter/material.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/providers/shopping_cart_provider.dart';
import 'package:meal/utils/utils.dart';

class BuyPage extends StatefulWidget {
  final ProductModel product;
  BuyPage(this.product, {Key key}) : super(key: key);
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();

  int cantidad = 0;
  String descripcion = '';
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: media.width * 0.4),
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(
          vertical: media.width * 0.1,
          horizontal: media.width * 0.05,
        ),
        elevation: 20,
        backgroundColor: blackColors,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                widget.product.name,
                style: TextStyle(
                  color: orangeColors,
                  fontSize: media.width * 0.08,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: media.width * 0.08,
                  ),
                  onPressed: () {
                    if (cantidad > 0) {
                      setState(() {
                        cantidad--;
                      });
                    }
                  },
                ),
                Text(
                  'Add $cantidad to cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: media.width * 0.045,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: media.width * 0.08,
                  ),
                  onPressed: () {
                    setState(() {
                      cantidad++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 5),
            Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    enabled: false,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    maxLines: 4,
                    decoration: InputDecoration.collapsed(
                      hintText: "Comments about the purchase of the product",
                    ),
                    cursorColor: orangeColors,
                    cursorWidth: 1.0,
                    style: TextStyle(
                      color: blackColors,
                      fontSize: media.width * 0.04,
                    ),
                    onChanged: (value) => descripcion = value,
                  ),
                ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                color: orangeColors,
                fontSize: 12,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              "Ok",
              style: TextStyle(
                color: orangeColors,
                fontSize: 12,
              ),
            ),
            onPressed: () {
              final _shoppingCart = ShoppingCartModel(
                  idProduct: widget.product.idProduct,
                  quantityProducts: cantidad,
                  productComment: descripcion);
              _shoppingCartProvider.newShoppingCart(_shoppingCart);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
