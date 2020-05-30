import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart' as utils;

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
              NetworkImage('https://popmenucloud.com/cdn-cgi/image/width=1920,height=1920,fit=scale-down,format=auto/coqsgvki/5cc4e080-5243-47c0-a9f5-ed4f7d6dfdc2.jpg'),
              NetworkImage('https://popmenucloud.com/cdn-cgi/image/width=1920,height=1920,fit=scale-down,format=auto/coqsgvki/b4f5aba0-4546-46ee-b7f8-4d7e34a4e582.jpg'),
              NetworkImage('https://popmenucloud.com/cdn-cgi/image/width=1920,height=1920,fit=scale-down,format=auto/coqsgvki/047ac5fc-52aa-4ab3-aa90-40d611d66101.jpg'),
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
          _categoryLogo("Drinks","https://popmenucloud.com/cdn-cgi/image/width=1920,height=1920,fit=scale-down,format=auto/coqsgvki/4e2d6631-d316-45a8-b75c-cd51340c65bb.jpg"),
          _categoryLogo("Dinner","https://popmenucloud.com/cdn-cgi/image/width=1920,height=1920,fit=scale-down,format=auto/coqsgvki/b4f5aba0-4546-46ee-b7f8-4d7e34a4e582.jpg"),
          _categoryLogo("COVID-19", "https://popmenucloud.com/cdn-cgi/image/width=960,height=960,fit=scale-down,format=auto/coqsgvki/5cc4e080-5243-47c0-a9f5-ed4f7d6dfdc2.jpg")
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
                Expanded(child: Image.network(_imageNetwork),),
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
            onTap: () => _scaffolKey.currentState.showSnackBar(snackBarErrorCreacion),
            leading: Image.network("https://popmenucloud.com/cdn-cgi/image/width=1920,height=1920,fit=scale-down,format=auto/coqsgvki/b4f5aba0-4546-46ee-b7f8-4d7e34a4e582.jpg"),
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