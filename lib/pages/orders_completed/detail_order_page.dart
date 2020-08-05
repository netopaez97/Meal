import 'package:flutter/material.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/models/shopping_cart_model.dart';
import 'package:meal/utils/utils.dart';

class OrderDetailPage extends StatefulWidget {
  final List<ProductModel> products;
  final List<ShoppingCartModel> _productsInShopinCart;
  OrderDetailPage(this.products, this._productsInShopinCart, {Key key})
      : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return AlertDialog(
      title: Center(
        child: Text(
          'Products for this order',
          style: TextStyle(
            color: orangeColors,
            fontSize: media.width * 0.08,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      // scrollable: true,
      elevation: 20,
      backgroundColor: blackColors,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.2,
        child: ListView.builder(
          itemCount: widget.products.length,
          itemBuilder: (BuildContext context, int index) {
            final product = widget.products[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'You have ordered ${widget._productsInShopinCart[index].quantityProducts} ${product.name != null ? product.name : "products which are not available in the restaurant now"}',
                  style: TextStyle(color: Colors.white),
                ),
                Divider(
                  color: Colors.white12,
                ),
              ],
            );
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Exit",
            style: TextStyle(
              color: orangeColors,
              fontSize: 12,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

// showDetail(BuildContext context, ProductModel product) {
//   final media = MediaQuery.of(context).size;
//   int cantidad = 0;
//   showDialog(
//     context: context,
//     child: AlertDialog(
//       // scrollable: true,
//       contentPadding: EdgeInsets.symmetric(
//         vertical: media.width * 0.1,
//         horizontal: media.width * 0.1,
//       ),
//       elevation: 20,
//       backgroundColor: blackColors,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       content: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Center(
//             child: Text(
//               product.name,
//               style: TextStyle(
//                 color: orangeColors,
//                 fontSize: media.width * 0.08,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(height: 20),
//           Container(
//             width: double.infinity,
//             child: Image.network(
//               product.image,
//               fit: BoxFit.contain,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             product.description,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: media.width * 0.04,
//             ),
//             textAlign: TextAlign.justify,
//           ),
//           SizedBox(height: 10),
//           Text(
//             'Category: ${product.category}',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: media.width * 0.045,
//             ),
//           ),
//           Text(
//             'Price: \$${product.currentPrice}',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: media.width * 0.045,
//             ),
//           ),
//           (product.discount > 0)
//               ? Text(
//                   'Discount:  ${product.discount} % ',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: media.width * 0.045,
//                   ),
//                 )
//               : Container(),
//           Text(
//             'Rating: ${product.rating}',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: media.width * 0.045,
//             ),
//           ),
//           SizedBox(height: 5),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               IconButton(
//                 icon: Icon(
//                   Icons.remove,
//                   color: Colors.white,
//                   size: media.width * 0.08,
//                 ),
//                 onPressed: () {
//                   if (cantidad > 0) {
//                     cantidad--;
//                   }
//                 },
//               ),
//               Text(
//                 'Add $cantidad to cart',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: media.width * 0.045,
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(
//                   Icons.add,
//                   color: Colors.white,
//                   size: media.width * 0.08,
//                 ),
//                 onPressed: () {
//
//                     cantidad++;
//                 },
//               ),
//             ],
//           )
//         ],
//       ),
//       actions: <Widget>[
//         FlatButton(
//           child: Text(
//             "Cancelar",
//             style: TextStyle(
//               color: orangeColors,
//               fontSize: 12,
//             ),
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         FlatButton(
//           child: Text(
//             "Comprar",
//             style: TextStyle(
//               color: orangeColors,
//               fontSize: 12,
//             ),
//           ),
//           onPressed: () {
//             //Navigator.of(context).pop();
//           },
//         ),
//       ],
//     ),
//   );
// }
