import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/widgets/drawer.dart';

class HomePage extends StatefulWidget {

  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
      body:   _pageBody(),
    );
  }

  Widget _superiorNavBar() => AppBar(
    title: Text("The Bars KC",),
    actions: <Widget>[
      
    ],
  );

  Widget _pageBody(){
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

  Widget _welcomeImages(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        child: Container(
          height: MediaQuery.of(context).size.height*0.3,
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

  Widget _categories(){
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.1,
      child: ListView(
        padding: EdgeInsets.only(left: 4,right: 4),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _categoryLogo("Drinks","assets/drink.jpg"),
          _categoryLogo("Dinner","assets/hamburguer.jpg"),
          _categoryLogo("COVID-19", "assets/theBarKc.jpg")
        ],
      ),
    );
  }

  Widget _categoryLogo(String _category, String _imageNetwork){
    return Container(
      padding: EdgeInsets.only(top:8, bottom: 8, left: 4, right: 4),
      child: Material(
        color: Colors.transparent,
        elevation: 4,
        child: Container(
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.height*0.1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(child: Image.asset(_imageNetwork),),
                Text(_category)
              ],
            )
          )
        ),
      ),
    );
  }

  Widget _suggestedOptions(){
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.4,
      child: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          _option(),
          _option(),
          _option(),
          _option(),
          _option(),
          _option(),
        ],
      ),
    );
  }

  Widget _option(){
    return Column(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          elevation: 2,
          child: ListTile(
            // onTap: () => _scaffolKey.currentState.showSnackBar(snackBarErrorCreacion),
            onTap: () => Navigator.pushNamed(context, Routes.conference),
            leading: Image.asset("assets/hamburguer.jpg"),
            title: Text("Special hamburguer"),
            subtitle: Text("Price: \$12"),
            trailing: IconButton(icon: Icon(Icons.navigate_next), onPressed: ()=>_scaffolKey.currentState.showSnackBar(snackBarErrorCreacion)),
          ),
        ),
        Divider(
          color: Colors.transparent,
        ),
      ],
    );
  }
}