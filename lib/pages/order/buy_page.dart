import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/models/shopping_cart_model.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/providers/shopping_cart_provider.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';

class BuyPage extends StatefulWidget {
  final ProductModel product;
  BuyPage(this.product, {Key key}) : super(key: key);
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
  final prefs = UserPreferences();

  int cantidad;
  String comment;
  String dropdownValue;
  List<String> phones = [];
  bool change = false;
  @override
  void initState() {
    super.initState();
    cantidad = 0;
    comment = '';
    if (prefs.rol == host && prefs.menu == host) {
      phones.add(prefs.host);
      if (prefs.guest1 != null && prefs.guest1 != '') {
        phones.add(prefs.uidguest1);
      }
      if (prefs.guest2 != null && prefs.guest2 != '') {
        phones.add(prefs.uidguest2);
      }
      if (prefs.guest3 != null && prefs.guest3 != '') {
        phones.add(prefs.uidguest3);
      }
      dropdownValue = phones[0];
    } else if ((prefs.rol == host && prefs.menu == guest) ||
        prefs.rol == noguests) {
      dropdownValue = prefs.host;
    } else if (prefs.rol == guest) {
      dropdownValue = prefs.guest;
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return AlertDialog(
      title: Center(
        child: Text(
          widget.product.name,
          style: TextStyle(
            color: orangeColors,
            fontSize: media.width * 0.08,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      elevation: 20,
      backgroundColor: blackColors,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: FutureBuilder(
        future: _shoppingCartProvider.getProductShoppingCart(
            widget.product, dropdownValue),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          if (snapshot.data.idCar == null) {
            if (change) {
              cantidad = 0;
              comment = '';
              change = false;
            } else {
              cantidad = cantidad;
              comment = comment;
            }
          } else {
            if (!change) {
              cantidad = snapshot.data.quantityProducts;
              change = true;
            }

            comment = snapshot.data.productComment;
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView(
              children: <Widget>[
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
                (prefs.rol == host && prefs.menu == host)
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: DropdownButton<String>(
                          underline: DropdownButtonHideUnderline(child: Container()),
                          value: dropdownValue,
                          elevation: 16,
                          style: TextStyle(color: blackColors),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value;
                            });

                            print(dropdownValue);
                            print(comment);
                          },
                          items: phones
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
                SizedBox(height: 5),
                Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        initialValue: comment,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        maxLines: 4,
                        decoration: InputDecoration.collapsed(
                          hintText:
                              "Comments about the purchase of the product",
                        ),
                        cursorColor: orangeColors,
                        cursorWidth: 1.0,
                        style: TextStyle(
                          color: blackColors,
                          fontSize: media.width * 0.04,
                        ),
                        onChanged: (value) {
                          comment = value;
                        },
                      ),
                    ))
              ],
            ),
          );
        },
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
            "Buy",
            style: TextStyle(
              color: orangeColors,
              fontSize: 12,
            ),
          ),
          onPressed: () async {
            double price;
            if (widget.product.discount != null) {
              price = roundDouble((widget.product.currentPrice -
                  (widget.product.currentPrice *
                      (widget.product.discount / 100))));
            } else {
              price = roundDouble(widget.product.currentPrice);
            }

            final _shoppingCart = ShoppingCartModel(
                idProduct: widget.product.idProduct,
                quantityProducts: cantidad,
                price: price,
                productComment: comment,
                mealFor: dropdownValue);
            await _shoppingCartProvider.newShoppingCart(_shoppingCart);
            Navigator.pop(context);
            Navigator.of(context).pushNamed(Routes.car);
          },
        ),
      ],
    );
  }
}
