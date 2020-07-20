import 'package:flutter/material.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/models/shopping_cart_model.dart';
import 'package:meal/models/user_model.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/providers/products_provider.dart';
import 'package:meal/providers/shopping_cart_provider.dart';
import 'package:meal/providers/user_provider.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/services/dynamic_link_service.dart';
import 'package:meal/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ShoppingCartPage extends StatefulWidget {
  static const routeName = 'ShoppingCartPage';

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final ProductsProvider _productProvider = ProductsProvider();
  final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
  GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();
  final prefs = UserPreferences();
  final snackBarErrorCreacion = SnackBar(
    content: Text('There are products that are not avilable.'),
    duration: Duration(seconds: 5),
  );

  List _listaProductosCarrito;
  double total = 0.0;
  bool availability = true;
  List<String> phones = [];

  @override
  void initState() {
    super.initState();
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
    }
    state();
  }

  void state() async {
    setState(() {
      _listaProductosCarrito = [];
      total = 0.0;
      availability = true;
    });
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
      print(_listaProductosCarrito);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();

    return Scaffold(
      key: _scaffolKey,
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (prefs.send)
                ? null
                : () async {
                    await _shoppingCartProvider.deleteAll();
                    state();
                  },
          )
        ],
      ),
      body: (prefs.rol == host && prefs.menu == host)
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: phones.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, i) =>
                  _suggestedOptionsHostAndGuest(phones[i]),
            )
          : _suggestedOptions(),
      bottomNavigationBar: _totalBuy(),
    );
  }

  Widget _suggestedOptionsHostAndGuest(String mealFor) {
    print(mealFor);
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
    return FutureBuilder(
      future: _shoppingCartProvider.getShoppingCartMealFor(mealFor),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return Center(child: LinearProgressIndicator());

        final shoppingCart = snapshot.data;

        return Column(
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(child: Divider(color: orangeColors.withOpacity(0.5))),
              Text(
                mealFor.split(' - ')[0],
                textScaleFactor: MediaQuery.of(context).size.width * 0.005,
                style: TextStyle(color: orangeColors.withOpacity(0.8)),
              ),
              Expanded(child: Divider(color: orangeColors.withOpacity(0.5))),
            ]),
            SizedBox(height: 5),
            (snapshot.data == null || snapshot.data.length == 0)
                ? Center(child: Text("You don't have a Meal in your Cart :'(."))
                : SizedBox(
                    height: shoppingCart.length * 100.0,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: shoppingCart.length,
                      padding: EdgeInsets.all(8),
                      itemBuilder: (context, i) => _option(shoppingCart[i]),
                    ),
                  ),
          ],
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

        final shoppingCart = snapshot.data;

        return SizedBox(
          height: MediaQuery.of(context).size.height,
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

    return FutureBuilder(
      future: _productProvider.getProduct(_shoppingCart.idProduct),
      builder: (BuildContext context, AsyncSnapshot snapProduct) {
        if (!snapProduct.hasData)
          return Center(child: LinearProgressIndicator());

        if (snapProduct.data == null || snapProduct.data.data == null)
          return Center(child: Text("You don't have a Meal in your Cart :'(."));

        ProductModel _product = ProductModel.fromJson(snapProduct.data.data);
        _product.idProduct = snapProduct.data.documentID;

        return Column(
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              elevation: 2,
              child: ListTile(
                // onTap: () {
                //   showDialog(
                //     context: context,
                //     builder: (BuildContext context) => BuyPage(_product),
                //   );
                // },
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
                    Text(
                      "Price: \$${roundDouble(_shoppingCart.price * _shoppingCart.quantityProducts)}",
                    ),
                    Text("Quantity: ${_shoppingCart.quantityProducts}"),
                    (_shoppingCart.productComment.length != 0)
                        ? (_shoppingCart.productComment.length > 16)
                            ? Text(
                                _shoppingCart.productComment.substring(0, 16) +
                                    "...")
                            : Text(_shoppingCart.productComment)
                        : SizedBox(width: 0, height: 0),
                    (_product.availability == false)
                        ? Text(
                            'Not available',
                            style: TextStyle(color: orangeColors),
                          )
                        : SizedBox(width: 0, height: 0),
                    SizedBox(height: 5),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: (prefs.send)
                      ? null
                      : () {
                          _shoppingCartProvider
                              .deleteShoppingCart(_shoppingCart.idCar);
                          state();
                        },
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
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
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
            'Total price = \$${roundDouble(total)}',
            style: TextStyle(color: blackColors),
            textScaleFactor: media.width * 0.004,
          )),
          FutureBuilder(
            future: _shoppingCartProvider.getShoppingCart(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              if (snapshot.data == null || snapshot.data.length == 0) {
                return SizedBox();
              }

              return InkWell(
                onTap: () async {
                  state();
                  if (availability) {
                    if (prefs.rol == host &&
                        prefs.menu == host &&
                        prefs.pickup == host &&
                        prefs.payment == host) {
                      Navigator.pushNamed(context, Routes.order);
                    } else if (prefs.rol == host &&
                        prefs.menu == host &&
                        prefs.pickup == host &&
                        prefs.payment == guest) {
                      final userProvider = UserProvider();
                      bool valida1 = true;
                      bool valida2 = true;
                      bool valida3 = true;
                      UserModel user1;
                      UserModel user2;
                      UserModel user3;
                      if (prefs.guest1 != null && prefs.guest1 != '') {
                        user1 = await userProvider.getUser(prefs.guest1);
                        valida1 = user1.ready;
                      }
                      if (prefs.guest2 != null && prefs.guest2 != '') {
                        user2 = userProvider.getUser(prefs.guest1);
                        valida2 = user2.ready;
                      }
                      if (prefs.guest3 != null && prefs.guest3 != '') {
                        user3 = userProvider.getUser(prefs.guest1);
                        valida3 = user3.ready;
                      }
                      if (valida1 && valida2 && valida3) {
                        prefs.send = false;
                        if (prefs.guest1 != null && prefs.guest1 != '') {
                          userProvider.readyUser(user1.idUser, false);
                        }
                        if (prefs.guest2 != null && prefs.guest2 != '') {
                          userProvider.readyUser(user2.idUser, false);
                        }
                        if (prefs.guest3 != null && prefs.guest3 != '') {
                          userProvider.readyUser(user3.idUser, false);
                        }
                        Navigator.pushNamed(context, Routes.order);
                      } else {
                        if (!prefs.send) {
                          prefs.send = true;
                          final DynamicLinkService _dynamicLinkService =
                              DynamicLinkService();
                          final url = await _dynamicLinkService
                              .createDynamicLinkOrder();
                          List<String> phonesList = [];
                          phones.forEach((element) {
                            phonesList.add(element.split(' - ')[1]);
                          });
                          Uri _launchSms;
                          _launchSms = Uri(
                              scheme: 'sms',
                              path: phonesList.toString(),
                              queryParameters: {
                                'body': 'Unete a mi videollamada $url'
                              });
                          launch(_launchSms.toString());
                        } else {
                          prefs.send = false;
                          _scaffolKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'There are products that are not avilable.'),
                            duration: Duration(seconds: 5),
                          ));
                        }
                      }
                    }
                  } else {
                    _scaffolKey.currentState
                        .showSnackBar(snackBarErrorCreacion);
                  }
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
              );
            },
          ),
          SizedBox(
            width: media.width * 0.03,
            height: media.width * 0.1,
          ),
        ],
      ),
    );
  }
}
