import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/pages/detail_page.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';

class InitialPage extends StatelessWidget {
  static const routeName = 'InitialPage';
  @override
  Widget build(BuildContext context) {
    final product = new ProductModel();
    product.name = 'Burger';

    product.currentPrice = 10000;
    product.category = 'fast food';
    product.discount = 0.3;
    product.description =
        'Una hamburguesa es un tipo de sándwich hecho a base de carne molida aglutinada en forma de filete cocinado a la parrilla o a la plancha, aunque también puede freírse u hornearse. Fuera del ámbito de habla hispana, es más común encontrar la denominación inglesa burger, acortamiento de hamburger.';
    product.amount = 10;
    product.image =
        'https://cocina-casera.com/wp-content/uploads/2016/11/hamburguesa-queso-receta.jpg';
    product.rating = 4.8;
    product.numberRatings = 143;
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: Padding(
        padding: EdgeInsets.only(
          left: media.width * 0.1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: media.width * 0.16,
              width: media.width * 0.8,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  'meal',
                  style: TextStyle(
                    color: orangeColors,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: media.width * 0.05,
              ),
              height: media.width * 0.7,
              width: media.width * 0.8,
              child: Text(
                'Thank you for using MEAL! This is a pilot version of the app, which we are working to improve. Please let us know what you think!\nShare your suggestions for ways we can improve! you can participate in a short survey at the end of your order. Enjoy your MEAL!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
                textScaleFactor: media.width * 0.004,
              ),
            ),
            Row(
              children: <Widget>[
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.add,
                      size: media.width * 0.15, color: orangeColor),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    showDetail(context, product);
                  },
                  child: Container(
                    height: media.width * 0.1,
                    width: media.width * 0.6,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "Go to meal",
                        style: TextStyle(
                          color: orangeColor,
                          fontWeight: FontWeight.normal,
                        ),
                        textScaleFactor: media.width * 0.0055,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
