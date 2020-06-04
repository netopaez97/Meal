import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart' as utils;

class MainDrawer extends StatelessWidget {

  final String _userName  = "Ian Gonsher";
  final String _userEmail = "ian_gonsher@brown.edu";

  @override
  Widget build(BuildContext context) {


    return Drawer(
      child: ListView(
        children: <Widget>[
          _userAccount(context),
          _home(context),
          _orders(context),
          _friends(context),
          _signOut(context),
        ],
      ),
    );
  }

  Widget _userAccount(BuildContext context){


    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      currentAccountPicture: CircleAvatar(
        child: Text(_userEmail[0].toUpperCase(), style: TextStyle(color: utils.blackColor,))
      ),
      accountName: Text(_userName, style: TextStyle(color: Colors.black),),
      accountEmail: Text(_userEmail, style: TextStyle(color: Colors.black),),
    );
  }

  Widget _home(BuildContext context){
    return ListTile(
      leading: Icon(Icons.home),
      title: Text("Home"),
      trailing: Icon(Icons.navigate_next),
      onTap: (){
        Navigator.pushNamedAndRemoveUntil(
          context, 
          Routes.home, 
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  Widget _orders(BuildContext context){
    return ListTile(
      title: Text("Orders"),
      leading: Icon(Icons.shopping_basket),
      trailing: Icon(Icons.navigate_next),
      onTap: (){
        // Navigator.pushNamed(context, Routes.pending);
      },
    );
  }

  Widget _friends(BuildContext context){
    return ListTile(
      leading: Icon(Icons.people),
      title: Text("Friends"),
      trailing: Icon(Icons.navigate_next),
      onTap: (){
        
      },
    );
  }

  Widget _signOut(BuildContext context){
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Divider(height: 10,),
          Container(
            alignment: Alignment.bottomLeft,
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sign out"),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, Routes.phone ,(Route<dynamic> route) => false);
              },
            ),
          ),
        ],
    );
  }
}