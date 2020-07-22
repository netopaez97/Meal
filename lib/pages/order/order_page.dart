import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meal/models/order_model.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/models/shopping_cart_model.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/providers/order_provider.dart';
import 'package:meal/providers/products_provider.dart';
import 'package:meal/providers/push_nofitications_provider.dart';
import 'package:meal/providers/shopping_cart_provider.dart';
import 'package:meal/providers/user_provider.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/services/dynamic_link_service.dart';
import 'package:meal/utils/utils.dart';
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
  final ProductsProvider _productProvider = ProductsProvider();
  final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
  final UserPreferences prefs = UserPreferences();
  GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();
  final snackBarErrorCreacion = SnackBar(
    content: Text('There are products that are not avilable.'),
    duration: Duration(seconds: 5),
  );

  String deliveryType = 'Carry out';
  String paymentType = 'Pay now';
  String address;
  String comments;
  bool valida = true;
  bool order = false;
  List<ShoppingCartModel> list = [];

  List _listaProductosCarrito;
  double total = 0.0;
  bool availability = true;
  List<String> phones = [];


  //Loading to show or hide the ORDER NOW buttom:
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (prefs.rol == host && prefs.menu == host) {
      if (prefs.guest1 != null && prefs.guest1 != '') {
        phones.add(prefs.uidguest1);
      }
      if (prefs.guest2 != null && prefs.guest2 != '') {
        phones.add(prefs.uidguest2);
      }
      if (prefs.guest3 != null && prefs.guest3 != '') {
        phones.add(prefs.uidguest3);
      }
    }
    state();
  }

  void state() async {
    print(prefs.guest);
    _listaProductosCarrito = [];
    availability = true;
    total = 0.0;
    if ((prefs.rol == host && prefs.payment == host) || (prefs.rol == noguests)) {
      await _shoppingCartProvider.getShoppingCart().then((res) {
        if (res != null) {
          total = 0.0;
          availability = true;
          _listaProductosCarrito = res;
          _listaProductosCarrito.forEach((e) async {
            final res = await _productProvider.getProduct(e.idProduct);
            final _product = ProductModel.fromJson(res.data);

            double price;
            if (_product.discount != null) {
              price = roundDouble((_product.currentPrice -
                  (_product.currentPrice * _product.discount / 100)));
            } else {
              price = roundDouble(_product.currentPrice);
            }
            e.price = price;
            _shoppingCartProvider.newShoppingCart(e);
            if (_product.availability == false) {
              availability = false;
            }
            setState(() {
              total = total + (price * e.quantityProducts);
            });
          });
        }
      });
    } else if (prefs.rol == host) {
      await _shoppingCartProvider
          .getShoppingCartMealFor(prefs.host)
          .then((res) {
        if (res != null) {
          total = 0.0;
          availability = true;
          _listaProductosCarrito = res;
          _listaProductosCarrito.forEach((e) async {
            final res = await _productProvider.getProduct(e.idProduct);
            final _product = ProductModel.fromJson(res.data);

            double price;
            if (_product.discount != null) {
              price = roundDouble((_product.currentPrice -
                  (_product.currentPrice * _product.discount / 100)));
            } else {
              price = roundDouble(_product.currentPrice);
            }
            e.price = price;
            _shoppingCartProvider.newShoppingCart(e);
            if (_product.availability == false) {
              availability = false;
            }
            setState(() {
              total = total + (price * e.quantityProducts);
            });
          });
        }
      });
    } else if (prefs.rol == guest) {
      await _shoppingCartProvider
          .getShoppingCartMealFor(prefs.guest)
          .then((res) {
        if (res != null) {
          total = 0.0;
          availability = true;
          _listaProductosCarrito = res;
          _listaProductosCarrito.forEach((e) async {
            final res = await _productProvider.getProduct(e.idProduct);
            final _product = ProductModel.fromJson(res.data);

            double price;
            if (_product.discount != null) {
              price = roundDouble((_product.currentPrice -
                  (_product.currentPrice * _product.discount / 100)));
            } else {
              price = roundDouble(_product.currentPrice);
            }
            e.price = price;
            _shoppingCartProvider.newShoppingCart(e);
            if (_product.availability == false) {
              availability = false;
            }
            setState(() {
              total = total + (price * e.quantityProducts);
            });
          });
        }
      });
    }

    print(_listaProductosCarrito);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolKey,
      appBar: AppBar(
        title: Text(
          "Order",
        ),
      ),
      body: _body(),
      bottomNavigationBar: _totalBuy(),
    );
  }

  Widget _body() {
    final media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10),
          (prefs.rol == host ||
                  prefs.rol == noguests ||
                  (prefs.rol == host &&
                      prefs.menu == guest &&
                      prefs.pickup == guest &&
                      prefs.payment == guest) ||
                  (prefs.rol == guest &&
                      prefs.menu == guest &&
                      prefs.pickup == guest &&
                      prefs.payment == guest))
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Delivery type',
                          style: TextStyle(
                            color: blackColors,
                            fontSize: media.width * 0.05,
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          child: DropdownButton<String>(
                            value: deliveryType,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: blackColors),
                            onChanged: (String newValue) {
                              setState(() {
                                deliveryType = newValue;
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
                    (deliveryType == 'Delivery')
                        ? TextField(
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Address',
                              errorText:
                                  (valida) ? '' : 'Please complete this field',
                              errorStyle: TextStyle(
                                color: (valida)
                                    ? blackColors.withOpacity(0.5)
                                    : orangeColors.withOpacity(0.5),
                                fontSize: media.width * 0.05,
                              ),
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
                    (prefs.rol == host ||
                            prefs.rol == noguests ||
                            (prefs.rol == guest && prefs.payment == guest))
                        ? Row(
                            children: <Widget>[
                              Text(
                                'Payment type',
                                style: TextStyle(
                                  color: blackColors,
                                  fontSize: media.width * 0.05,
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                child: DropdownButton<String>(
                                  value: paymentType,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: blackColors),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      paymentType = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Pay now',
                                    'Pay on receipt',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
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
                            hintText:
                                "Comments about the purchase of the products",
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
                    Divider(),
                    (prefs.rol == noguests ||
                            prefs.payment == host ||
                            (prefs.menu == guest &&
                                prefs.pickup == guest &&
                                prefs.payment == guest))
                        ? _suggestedOptions()
                        : _suggestedOptionsHostAndGuest(prefs.host),
                    Divider(),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Text('Products to buy',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: blackColors,
                          fontSize: media.width * 0.05,
                        )),
                    Divider(),
                    _suggestedOptionsHostAndGuest(prefs.guest),
                    Divider()
                  ],
                ),
        ],
      ),
    );
  }

  Widget _suggestedOptionsHostAndGuest(String mealFor) {
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
    return FutureBuilder(
      future: _shoppingCartProvider.getShoppingCartMealFor(mealFor),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return Center(child: LinearProgressIndicator());
        if (snapshot.data == null || snapshot.data.length == 0)
          return Center(child: Text("You don't have a Meal in your Cart :'(."));

        list = [];
        final shoppingCart = snapshot.data;
        return SizedBox(
          height: shoppingCart.length * 120.0,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: shoppingCart.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, i) => _option(shoppingCart[i]),
          ),
        );
      },
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
          height: shoppingCart.length * 120.0,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
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
                  child: (_product.image != null)
                      ? FadeInImage(
                          placeholder: AssetImage('assets/test.jpg'),
                          image: NetworkImage(_product.image),
                          height: 300.0,
                          fit: BoxFit.cover,
                        )
                      : Image(image: AssetImage('assets/test.jpg')),
                ),
                title: Text(_product.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5),
                    (prefs.rol == host && prefs.menu == host)
                        ? Text(
                            "To: ${_shoppingCart.mealFor.split(' - ')[0]}",
                          )
                        : SizedBox(width: 0, height: 0),
                    Text(
                      "Price: \$${_product.currentPrice * _shoppingCart.quantityProducts}",
                    ),
                    Text("Quantity: ${_shoppingCart.quantityProducts}"),
                    (_shoppingCart.productComment.length != 0)
                        ? (_shoppingCart.productComment.length > 16)
                            ? Text(
                                _shoppingCart.productComment.substring(0, 16) +
                                    "...")
                            : Text(_shoppingCart.productComment)
                        : SizedBox(width: 0, height: 0),
                    SizedBox(height: 5),
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

  Widget _totalBuy() {
    final media = MediaQuery.of(context).size;

    return Card(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: media.width * 0.03,
            height: media.width * 0.1,
          ),
          Expanded(
              child: Text(
            'Total: \$${roundDouble(total)}',
            style: TextStyle(color: blackColors),
            textScaleFactor: media.width * 0.004,
          )),
          _loading == true
          ? Center(child: CircularProgressIndicator())
          : InkWell(
            onTap: (order) ? null : orderNow,
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
                    "Order now",
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
    );
  }

  orderNow() async {
    setState(() {
      _loading = true;
      order = true;
    });
    final prefs = new UserPreferences();
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
    final OrderProvider _orderProvider = OrderProvider();
    final DynamicLinkService _dynamicLinkService = DynamicLinkService();
    final pushProvider = new PushNotificationProvider();

    
    ///pay: Si una persona quiere pagar con tarjeta de crétido esta variable revisa si en realidad ha pagado.
    ///Puede ser true o false.
    ///Si decide pagar cuando reciba el pedido a domicilio, va a ser true siempre.
    bool pay = false;

    if (prefs.rol == host ||
        (prefs.rol == host &&
            prefs.menu == guest &&
            prefs.pickup == guest &&
            prefs.payment == guest) ||


        (prefs.rol == guest &&
            prefs.menu == guest &&
            prefs.pickup == guest &&
            prefs.payment == guest) ||


         prefs.rol == noguests) {
      valida = true;
      if (deliveryType == 'Delivery') {
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
        // Primero se realiza el pago, _pay() debe devolver true
        if (paymentType == 'Pay now') {
          await _pay();
        } else {
          orderDone(
            context,
            prefs,
            total,
            deliveryType,
            address,
            list,
            comments,
            paymentType,
            _orderProvider,
            pushProvider,
            _shoppingCartProvider,
            _dynamicLinkService,
            phones,
          );
        }
      }

    ///Este caso sucede cuando un invitado va a pagar su pedido pero el host recoge el pedido o lo recibe en su casa.
    } else if (prefs.rol == guest && prefs.payment == guest) {
      if (paymentType == 'Pay now') {
        await _pay();
      } else {
       final userProvider = UserProvider();
        await userProvider.readyUser(prefs.uid, true);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (Route routes) => false);
      }
    }
    else{
      _scaffolKey.currentState.showSnackBar(snackBarErrorCreacion);
    }
    setState(() {
      order = false;
    });
  }

  _pay() async {
    await InAppPayments.setSquareApplicationId(
        'sandbox-sq0idb-nqLe4yTCaxfrdjoAJVz6og');
    await InAppPayments.startCardEntryFlow(
      onCardEntryCancel: _cardEntryCancel,
      onCardNonceRequestSuccess: _cardNonceRequestSuccess,
    );
  }

  void _cardEntryCancel() async {
    await showDialog(
      context: context,
      builder: (BuildContext context ) =>AlertDialog(
        title: Text("Card entry canceled")
      )
    );
  }

  Future _cardNonceRequestSuccess(cardModel.CardDetails result) async {

    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
    final OrderProvider _orderProvider = OrderProvider();
    final DynamicLinkService _dynamicLinkService = DynamicLinkService();
    final _pushProvider = new PushNotificationProvider();

    // Use this nonce from your backend to pay via Square API
    print("Resultado al hacer click ${result.nonce}");

    final bool _invalidZipCode = false;

    if (_invalidZipCode) {
      // Stay in the card flow and show an error:
      InAppPayments.showCardNonceProcessingError('Invalid ZipCode');
    }

    InAppPayments.completeCardEntry(
      onCardEntryComplete: () async {
        await chargeCard(result, context, total);
        
        ///1. Validar que entre como host
        ///o que entre como guest y deba hacer todo el pedido
        ///o que entre como host y los invitados deban hacer todo el pedio
        if (prefs.rol == host ||
        (prefs.rol == host &&
            prefs.menu == guest &&
            prefs.pickup == guest &&
            prefs.payment == guest) ||


        (prefs.rol == guest &&
            prefs.menu == guest &&
            prefs.pickup == guest &&
            prefs.payment == guest) ||


         prefs.rol == noguests)
         
         {
           orderDone(context, prefs, total, deliveryType, address, list, comments, paymentType, _orderProvider, _pushProvider, _shoppingCartProvider, _dynamicLinkService, phones);
         }

        ///2. Validar que el rol sea guest y que el pago lo haga el guest.
         else if (prefs.rol == guest && prefs.payment == guest) {
          final userProvider = UserProvider();
            await userProvider.readyUser(prefs.uid, true);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.home, (Route routes) => false);
        }
      },
    );
  }
}

class ChargeException implements Exception {
  String errorMessage;
  ChargeException(this.errorMessage);
}

Future<void> chargeCard(

    cardModel.CardDetails result, BuildContext context, double total) async {
  String chargeServerHost = "https://mealkc.herokuapp.com";
  String chargeUrl = "$chargeServerHost/payment";


  var body = jsonEncode({"nonce": result.nonce, "price": total});
  http.Response response;

  response = await http.post(chargeUrl, body: body, headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });

  var responseBody = json.decode(response.body);
  if (response.statusCode == 200) {

    ///HERE WE CAN SHOW OR DO SOMETHING FOR THE FUTURE

  } else {
    throw ChargeException(responseBody["errorMessage"]);
  }
}


orderDone(BuildContext context, UserPreferences prefs, double total, String deliveryType, String address,
          List<ShoppingCartModel> list, String comments, String paymentType, OrderProvider _orderProvider,
          PushNotificationProvider pushProvider, ShoppingCartProvider _shoppingCartProvider,
          DynamicLinkService _dynamicLinkService, List<String> phones
) async {
  final order = OrderModel(
    idUser: prefs.uid,
    price: total,
    contactNumber: int.parse(prefs.phone),
    //date: DateTime.now().toString(),
    date: prefs.date,
    typeDelivery: deliveryType,
    direction: address,
    productsInCartList: list,
    comments: comments,
    status: 'pending',
    paymentType: paymentType,
    channelName: prefs.channelName,
    tokenClient: prefs.tokenFCM);

final resOrder = await _orderProvider.insertOrder(order);
if (resOrder) {
  pushProvider.sendAndRetrieveMessage();

  _shoppingCartProvider.deleteAll();
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text("Successful order"),
          content: SingleChildScrollView(
            child: Text("Your order has been successfuly created."),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () async {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.home, (Route routes) => false);
                if (prefs.rol == host && prefs.menu == host) {
                  Uri _launchSms;
                  final url = await _dynamicLinkService
                      .createDynamicLinkConference(prefs.channelName);

                  List<String> phonesList = [];
                  phones.forEach((element) {
                    phonesList.add(element.split(' - ')[1]);
                  });
                  _launchSms = Uri(
                      scheme: 'sms',
                      path: phonesList.toString(),
                      queryParameters: {
                        'body': 'Unete a mi videollamada $url'
                      });
                  launch(_launchSms.toString());
                }
              },
            ),
          ],
        );
      });
} else {
  print('Error');
}
}
