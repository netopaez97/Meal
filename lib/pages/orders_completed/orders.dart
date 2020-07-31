import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/models/order_model.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/pages/orders_completed/detail_order_page.dart';
import 'package:meal/preferences/userpreferences.dart';

import 'package:meal/providers/order_provider.dart';
import 'package:meal/providers/products_provider.dart';
import 'package:meal/utils/utils.dart' as utils;
import 'package:meal/widgets/drawer.dart';
import 'package:meal/widgets/survey.dart';

import '../../routes/routes.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = 'Orders';

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();
  final snackBarErrorCreacion = SnackBar(
    content: Text('This function has not been implemented.'),
    duration: Duration(seconds: 3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      key: _scaffolKey,
      appBar: _superiorNavBar(),
      body: _pageBody(),
    );
  }

  Widget _superiorNavBar() => AppBar(
        title: Text(
          "The Bars KC",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, Routes.car);
            },
          ),
        ],
      );

  Widget _pageBody() {
    return ListView(
      children: <Widget>[
        _suggestedOptions(),
      ],
    );
  }

  Widget _suggestedOptions() {
    final OrderProvider _productProvider = OrderProvider();

    return StreamBuilder<QuerySnapshot>(
        stream: _productProvider.getOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: LinearProgressIndicator());

          if (snapshot.data == null || snapshot.data.documents.length == 0)
            return Center(
                child:
                    Text("You haven't ordered products before. Go to Meal!"));

          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, orderItem) {
                final temp = Map<String, dynamic>.from(
                    snapshot.data.documents[orderItem].data);
                OrderModel _order = OrderModel.fromJson(temp);
                _order.idOrder = snapshot.data.documents[orderItem].documentID;

                return _option(_order);
              },
            ),
          );
        });
  }

  Widget _option(OrderModel _order) {
    final ProductsProvider _productProvider = ProductsProvider();

    List<ProductModel> list = List();

    double total = 0;

    _order.productsInCartList.forEach((element) async {
      total = (element.price * element.quantityProducts) + total;
      final res = await _productProvider.getProduct(element.idProduct);
      final product = ProductModel.fromJson(res.data);
      product.numberRatings = element.quantityProducts;
      product.rating = (element.price * element.quantityProducts);
      list.add(product);
    });
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          elevation: 2,
          child: ListTile(
            // onTap: () => _scaffolKey.currentState.showSnackBar(snackBarErrorCreacion),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      OrderDetailPage(list, _order.productsInCartList));
            },
            leading: CircleAvatar(
              backgroundColor: (_order.status == utils.pending)
              ? utils.orangeColors
              : (_order.status == utils.canceled)
                ? Colors.red
                : (_order.status == utils.delivered)
                  ? Colors.amber
                  : Colors.green
            ),
            title: Text('Your order at ${_order.date}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text("Status: ${_order.status}"),
                SizedBox(height: 10),
                Text("Quantity products: ${_order.productsInCartList.length}"),
                SizedBox(height: 10),
                Text("Total price: ${total.toStringAsFixed(2)}"),
                SizedBox(height: 10),
                _buttonToMeasureTheService(_order.status, _order),
                SizedBox(height: 10),

              ],
            ),
            trailing: (_order.channelName == '' || _order.channelName == null)
              ? SizedBox()
              : IconButton(
                icon: Icon(
                  Icons.video_call,
                ),
                onPressed: () {
                  final prefs = new UserPreferences();
                  prefs.channelName = _order.channelName;
                  Navigator.pushNamed(context, Routes.indexConference);
                },
              ),
          ),
        ),
        Divider(
          color: Colors.transparent,
        ),
      ],
    );
  }

  Widget _buttonToMeasureTheService(String _status, OrderModel _order){

    if(_status == utils.finished && _order.tookSurvey == false)
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context)=>SurveyDialog(_order)
          );
        },
        child: Text("Tell us your thoughts!")
      );
    else{
      return SizedBox();
    }
  }
}
