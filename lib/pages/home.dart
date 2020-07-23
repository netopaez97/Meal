import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:meal/models/product_model.dart';
import 'package:meal/pages/order/buy_page.dart';
import 'package:meal/pages/order/detail_page.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/providers/products_provider.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/drawer.dart';

import '../routes/routes.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = UserPreferences();
  GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();
  final snackBarErrorCreacion = SnackBar(
    content: Text('This function has not been implemented.'),
    duration: Duration(seconds: 3),
  );

  @override
  Widget build(BuildContext context) {
    // prefs.send = false;
    // prefs.rol = host;
    // prefs.menu = guest;
    // prefs.pickup = guest;
    // prefs.payment = guest;
    // prefs.guest1 = '3172790113';
    // prefs.guest2 = '';
    // prefs.guest3 = '';
    // //prefs.guest = '';
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
        _welcomeImages(),
        Padding(padding: EdgeInsets.all(8), child: Text("Category")),
        _categories(),
        Padding(padding: EdgeInsets.all(8), child: Text("Suggested options")),
        _suggestedOptions(),
      ],
    );
  }

  Widget _welcomeImages() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Carousel(
            borderRadius: true,
            images: [
              Image.asset("assets/theBarKc.jpg"),
              Image.asset("assets/hamburguer.jpg"),
              Image.asset("assets/meeting.jpg"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categories() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: ListView(
        padding: EdgeInsets.only(left: 4, right: 4),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _categoryLogo("Drinks", "assets/drink.jpg"),
          _categoryLogo("Dinner", "assets/hamburguer.jpg"),
          _categoryLogo("COVID-19", "assets/theBarKc.jpg")
        ],
      ),
    );
  }

  Widget _categoryLogo(String _category, String _imageNetwork) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 4, right: 4),
      child: Material(
        color: Colors.transparent,
        elevation: 4,
        child: InkWell(
          onTap: () {
            _scaffolKey.currentState.showSnackBar(snackBarErrorCreacion);
          },
          child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Center(
                  child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image.asset(_imageNetwork),
                  ),
                  Text(_category)
                ],
              ))),
        ),
      ),
    );
  }

  ///This widget will use ProductoProvider.dart to get the elements in the Database with

  Widget _suggestedOptions() {
    final ProductsProvider _productProvider = ProductsProvider();

    return StreamBuilder<QuerySnapshot>(
        stream: _productProvider.getAllProductosAvaliable(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: LinearProgressIndicator());

          if (snapshot.data == null || snapshot.data.documents.length == 0)
            return Center(
                child: Text("There is no products avaliable in our store."));

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, productItem) {
                final temp = Map<String, dynamic>.from(
                    snapshot.data.documents[productItem].data);
                ProductModel _producto = ProductModel.fromJson(temp);
                _producto.idProduct =
                    snapshot.data.documents[productItem].documentID;

                return _option(_producto);
              },
            ),
          );
        });
  }

  Widget _option(ProductModel _producto) {
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          elevation: 2,
          child: ListTile(
            // onTap: () => _scaffolKey.currentState.showSnackBar(snackBarErrorCreacion),
            onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) =>
                    ProductDetailPage(_producto)),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: MediaQuery.of(context).size.width * 0.1,
              child: (_producto.image != null)
                  ? FadeInImage(
                      placeholder: AssetImage('assets/test.jpg'),
                      image: NetworkImage(_producto.image),
                      height: 300.0,
                      fit: BoxFit.cover,
                    )
                  : Image(image: AssetImage('assets/test.jpg')),
            ),
            title: Text(_producto.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text("Price: \$${roundDouble(_producto.currentPrice)}"),
                _producto.description.length > 40
                    ? Text(_producto.description.substring(0, 40) + "...")
                    : Text(_producto.description),
                SizedBox(height: 10),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => BuyPage(_producto),
                );
              },
              // onPressed: (prefs.send)
              //     ? null
              //     : () {
              //         showDialog(
              //           context: context,
              //           builder: (BuildContext context) => BuyPage(_producto),
              //         );
              //       },
            ),
          ),
        ),
        Divider(
          color: Colors.transparent,
        ),
      ],
    );
  }
}
