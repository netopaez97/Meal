import 'package:flutter/material.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/pages/order/buy_page.dart';
import 'package:meal/utils/utils.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  ProductDetailPage(this.product, {Key key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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
      // scrollable: true,
      elevation: 20,
      backgroundColor: blackColors,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: (widget.product.image != null)
                  ? FadeInImage(
                      placeholder: AssetImage('assets/test.jpg'),
                      image: NetworkImage(
                        widget.product.image,
                      ),
                      height: 300.0,
                      fit: BoxFit.cover,
                    )
                  : Image(image: AssetImage('assets/test.jpg')),
            ),
            SizedBox(height: 10),
            Text(
              widget.product.description,
              style: TextStyle(
                color: Colors.white,
                fontSize: media.width * 0.04,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              'Category: ${widget.product.category}',
              style: TextStyle(
                color: Colors.white,
                fontSize: media.width * 0.045,
              ),
            ),
            Text(
              'Price: \$${widget.product.currentPrice}',
              style: TextStyle(
                color: Colors.white,
                fontSize: media.width * 0.045,
              ),
            ),
            (widget.product.discount > 0)
                ? Text(
                    'Discount:  ${widget.product.discount} % ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: media.width * 0.045,
                    ),
                  )
                : Container(),
            // Text(
            //   'Rating: ${widget.product.rating}',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: media.width * 0.045,
            //   ),
            // ),
          ],
        ),
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
            "Next",
            style: TextStyle(
              color: orangeColors,
              fontSize: 12,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) => BuyPage(widget.product),
            );
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
