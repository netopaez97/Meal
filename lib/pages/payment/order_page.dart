import 'package:flutter/material.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/models/shopping_cart_model.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/providers/products_provider.dart';
import 'package:meal/providers/shopping_cart_provider.dart';
import 'package:meal/providers/variables_providers.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<OrderPage> {
  String dropdownValue = 'Carry on';
  String phone;
  String address;
  String comment;
  bool valida = true;
  @override
  Widget build(BuildContext context) {
    final prefs = new UserPreferences();
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 5),
            TextFormField(
              initialValue: prefs.phone,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Phone number',
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
              onChanged: (value) => {phone = value},
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
                      hintText: 'Address',
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
                    onChanged: (value) => {address = value},
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
                  onChanged: (value) => {comment = value},
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
      floatingActionButton: order(),
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

    return FutureBuilder(
      future: _productProvider.getProduct(_shoppingCart.idProduct),
      builder: (BuildContext context, AsyncSnapshot snapProduct) {
        if (!snapProduct.hasData)
          return Center(child: LinearProgressIndicator());

        if (snapProduct.data == null || snapProduct.data.data == null)
          return Center(child: Text("You don't have a Meal in your Cart :'(."));

        ProductModel _product = ProductModel.fromJson(snapProduct.data.data);
        if (_product.availability == false)
          return Center(child: Text("You don't have a Meal in your Cart :'(."));

        return Column(
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: MediaQuery.of(context).size.width * 0.1,
                  child: Image.network(
                    _product.image,
                  ),
                ),
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
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
          ],
        );
      },
    );
  }

  order() {
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
    return FloatingActionButton(
      backgroundColor: blackColors,
      onPressed: () {
        valida=true;
        if (phone == null || phone == '') {
          valida = false;
        } else if (dropdownValue == 'Delivery') {
          if (address == null || address == '') {
            valida = false;
          }
        }
        if (valida) {
          email();

          _shoppingCartProvider.deleteAll();

          Navigator.pushNamedAndRemoveUntil(
              context, Routes.home, (Route routes) => false);
        }
      },
      child: Icon(Icons.send, color: Colors.white),
    );
  }
}

email() async {
  String username = 'up872094@gmail.com';
  String password = 'up872094up872094';

  final smtpServer = gmail(username, password);
  // Creating the Gmail server

  // Create our email message.
  final message = Message()
    ..from = Address(username)
    ..recipients.add('netopaez97@hotmail.com') //recipent email
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
    // ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
    ..subject = 'Enviando desde flutter ' //subject of the email
    ..text =
        'Este es un correo de prueba enviado desde flutter'; //body of the email

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent. \n' + e.toString());
  }
}
