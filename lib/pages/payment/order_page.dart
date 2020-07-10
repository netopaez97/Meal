import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meal/models/order_model.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/models/shopping_cart_model.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/providers/guest_provider.dart';
import 'package:meal/providers/order_provider.dart';
import 'package:meal/providers/products_provider.dart';
import 'package:meal/providers/push_nofitications_provider.dart';
import 'package:meal/providers/shopping_cart_provider.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/services/dynamic_link_service.dart';
import 'package:meal/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart' as cardModel;
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  static const routeName = 'order';
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<OrderPage> {
  String dropdownValue = 'Carry out';

  String address;
  String comments;
  bool valida = true;
  List<ShoppingCartModel> list = [];

  final UserPreferences _userPreferences = UserPreferences();

  @override
  Widget build(BuildContext context) {
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
                      'Carry out',
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
                        color: (valida)
                            ? blackColors.withOpacity(0.5)
                            : orangeColors.withOpacity(0.5),
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
                  onChanged: (value) => {comments = value},
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
        list = [];
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
    list.add(_shoppingCart);
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
    final prefs = new UserPreferences();
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
    final OrderProvider _orderProvider = OrderProvider();
    final _guestProvider = Provider.of<GuestProvider>(context);
    final DynamicLinkService _dynamicLinkService = DynamicLinkService();
    final pushProvider = new PushNotificationProvider();
    return FloatingActionButton(
      backgroundColor: blackColors,
      child: Icon(Icons.send, color: Colors.white),
      //onPressed: _pay,
      onPressed: () async {
        // return _pay();
        valida = true;
        if (dropdownValue == 'Delivery') {
          if (address == null || address == '') {
            valida = false;
            setState(() {});
          }
        } else {
          address = '';
        }
        if (comments == null || comments == '') {
          comments = '';
        }
        if (valida) {
          // Uri _emailLaunchUri;
          // final url = await _dynamicLinkService
          //     .createDynamicLink(DateTime.now().toString());
          // // _guestProvider.guests.forEach((num) => {
          // //       _emailLaunchUri = Uri(
          // //           scheme: 'sms',
          // //           path: '$num',
          // //           queryParameters: {'body': 'Unete a mi videollamada $url'}),
          // //       launch(_emailLaunchUri.toString()),
          // //     });

          // print(_guestProvider.guests.toList().toString());
          // _emailLaunchUri = Uri(
          //     scheme: 'sms',
          //     path: _guestProvider.guests.toList().toString(),
          //     queryParameters: {'body': 'Unete a mi videollamada $url'});

          //Send text message.
          if (_guestProvider.guests.toList() != [null])
            //launch(_emailLaunchUri.toString());
            _pay();
          // //Send push notification to admin
          // pushProvider.sendAndRetrieveMessage();

          // //Save a temp uis to the database
          // if (prefs.uid.isEmpty) {
          //   prefs.uid = DateTime.now().toString();
          // }

          // //Create the order
          // final order = OrderModel(
          //     idUser: prefs.uid,
          //     contactNumber: int.parse(prefs.phone),
          //     date: DateTime.now().toString(),
          //     typeDelivery: dropdownValue,
          //     direction: address,
          //     productsInCartList: list,
          //     comments: comments,
          //     status: 'pending',
          //     paymentType: '',
          //     tokenClient: _userPreferences.tokenFCM);

          // _orderProvider.insertOrder(order);

          // _shoppingCartProvider.deleteAll();

          // Navigator.pushNamedAndRemoveUntil(
          //     context, Routes.home, (Route routes) => false);
        }
      },
    );
  }

  // sms() {
  //   SmsSender sender = SmsSender();
  //   String address = "+573172790113";

  //   SmsMessage message = SmsMessage(
  //       address, 'Este es un mensaje automatico enviado desde flutter!');
  //   message.onStateChanged.listen((state) {
  //     if (state == SmsMessageState.Sent) {
  //       print("SMS is sent!");
  //     } else if (state == SmsMessageState.Delivered) {
  //       print("SMS is delivered!");
  //     }
  //   });
  //   sender.sendSms(message);
  // }

  void _pay() async {
    await InAppPayments.setSquareApplicationId(
        'sandbox-sq0idb-nqLe4yTCaxfrdjoAJVz6og');
    InAppPayments.startCardEntryFlow(
      onCardEntryCancel: _cardEntryCancel,
      onCardNonceRequestSuccess: _cardNonceRequestSuccess,
    );
  }

  void _cardEntryCancel() {
    // Cancel
  }

  void _cardNonceRequestSuccess(cardModel.CardDetails result) async {
    // Use this nonce from your backend to pay via Square API
    print("Resultado al hacer click ${result.nonce}");

    final bool _invalidZipCode = false;

    if (_invalidZipCode) {
      // Stay in the card flow and show an error:
      InAppPayments.showCardNonceProcessingError('Invalid ZipCode');
    }

    InAppPayments.completeCardEntry(
      onCardEntryComplete: () {
        chargeCard(result, context);
      },
    );
  }

  void _cardEntryComplete(String _details) async {
    Response response =
        await get("https://mealkc.herokuapp.com/payment?nonce=" + _details);

    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text("Square Payments API Response"),
            content: SingleChildScrollView(
              child: Text(response.body.toString()),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              ),
            ],
          );
        });
  }
}

String chargeServerHost = "https://mealkc.herokuapp.com";
String chargeUrl = "$chargeServerHost/payment";

class ChargeException implements Exception {
  String errorMessage;
  ChargeException(this.errorMessage);
}

Future<void> chargeCard(
    cardModel.CardDetails result, BuildContext context) async {
  var body = jsonEncode({"nonce": result.nonce});
  http.Response response;

  response = await http.post(chargeUrl, body: body, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  var responseBody = json.decode(response.body);
  if (response.statusCode == 200) {
    return await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text("Square Payments API Response"),
            content: SingleChildScrollView(
              child: Text(response.body.toString()),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              ),
            ],
          );
        });
  } else {
    throw ChargeException(responseBody["errorMessage"]);
  }
}

// email() async {
//   String username = 'up872094@gmail.com';
//   String password = 'up872094up872094';

//   final smtpServer = gmail(username, password);

//   final prefs = new UserPreferences();
//   // Creating the Gmail server

//   // Create our email message.
//   final message = Message()
//     ..from = Address(username)
//     ..recipients.add(prefs.email) //recipent email
//     // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
//     // ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
//     ..subject = 'Welcome to your MEAL dream.' //subject of the email
//     ..text =
//         'This email tests the functionality of Meal 3.0. This is a test email and will be changed with te right email. By the moment, enjoy te progress of this app. This email was sent by ${prefs.email} to invite you to take a diner at ${prefs.date}'; //body of the email

//   try {
//     final sendReport = await send(message, smtpServer);
//     print('Message sent: ' + sendReport.toString());
//   } on MailerException catch (e) {
//     print('Message not sent. \n' + e.toString());
//   }
// }
