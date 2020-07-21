import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';

class DynamicLinkService {
  void initDynamicLinks(GlobalKey<NavigatorState> navigatorKey) async {
    final prefs = new UserPreferences();
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      var isPost = deepLink.pathSegments.contains('post');

      if (isPost) {
        var channelName = deepLink.queryParameters['channelName'];
        var menu = deepLink.queryParameters['menu'];
        if (menu != null) {
          prefs.rol = guest;
          prefs.menu = deepLink.queryParameters['menu'];
          prefs.pickup = deepLink.queryParameters['pickup'];
          prefs.payment = deepLink.queryParameters['payment'];
          prefs.host = deepLink.queryParameters['host'];
          prefs.uidguest1 = deepLink.queryParameters['uidguest1'];
          prefs.uidguest2 = deepLink.queryParameters['uidguest2'];
          prefs.uidguest3 = deepLink.queryParameters['uidguest3'];
          prefs.date = deepLink.queryParameters['date'];

          if (prefs.phone == prefs.uidguest1.split(' - ')[1]) {
            prefs.guest = prefs.uidguest1;
          }
          if (prefs.phone == prefs.guest2.split(' - ')[1]) {
            prefs.guest = prefs.uidguest2;
          }
          if (prefs.phone == prefs.guest3.split(' - ')[1]) {
            prefs.guest = prefs.uidguest3;
          }
          if (prefs.menu == host &&
              prefs.pickup == host &&
              prefs.payment == guest) {
            navigatorKey.currentState.pushNamed(Routes.order);
          } else if (prefs.menu == guest &&
              prefs.pickup == guest &&
              prefs.payment == guest) {
            navigatorKey.currentState.pushNamed(Routes.home);
          }
        } else if (channelName != null) {
          prefs.channelName = channelName;
          navigatorKey.currentState.pushNamed(Routes.indexConference);
        }
      }
      deepLink = null;
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print('_handleDeepLink | deeplink: $deepLink');

        var isPost = deepLink.pathSegments.contains('post');

        if (isPost) {
          var channelName = deepLink.queryParameters['channelName'];
          var menu = deepLink.queryParameters['menu'];
          if (menu != null) {
            prefs.rol = guest;
            prefs.menu = deepLink.queryParameters['menu'];
            prefs.pickup = deepLink.queryParameters['pickup'];
            prefs.payment = deepLink.queryParameters['payment'];
            prefs.host = deepLink.queryParameters['host'];
            prefs.uidguest1 = deepLink.queryParameters['uidguest1'];
            prefs.uidguest2 = deepLink.queryParameters['uidguest2'];
            prefs.uidguest3 = deepLink.queryParameters['uidguest3'];
            prefs.date = deepLink.queryParameters['date'];
            if (prefs.uidguest1 != '') {
              if (prefs.phone == prefs.uidguest1.split(' - ')[1]) {
                prefs.guest = prefs.uidguest1;
              }
            }
            if (prefs.uidguest2 != '') {
              if (prefs.phone == prefs.guest2.split(' - ')[1]) {
                prefs.guest = prefs.uidguest2;
              }
            }
            if (prefs.uidguest3 != '') {
              if (prefs.phone == prefs.guest3.split(' - ')[1]) {
                prefs.guest = prefs.uidguest3;
              }
            }
            if (prefs.menu == host &&
                prefs.pickup == host &&
                prefs.payment == guest) {
              navigatorKey.currentState.pushNamed(Routes.order);
            } else if (prefs.menu == guest &&
                prefs.pickup == guest &&
                prefs.payment == guest) {
              navigatorKey.currentState.pushNamed(Routes.home);
            }
          } else if (channelName != null) {
            prefs.channelName = channelName;
            navigatorKey.currentState.pushNamed(Routes.indexConference);
          }
        }
        deepLink = null;
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  createDynamicLinkConference(String channelName) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://mealkc.page.link',
      link: Uri.parse('https://www.mealkc.com/post?channelName=$channelName'),
      androidParameters: AndroidParameters(
        packageName: 'com.netopaez.meal',
        minimumVersion: 0,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.netopaez.meal',
        minimumVersion: '0',
      ),
    );

    Uri url;

    url = await parameters.buildUrl();

    return url.toString();
  }

  createDynamicLinkOrder() async {
    final prefs = new UserPreferences();
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://mealkc.page.link',
      link: Uri.parse(
          'https://www.mealkc.com/post?channelName=${prefs.channelName}&menu=${prefs.menu}&pickup=${prefs.pickup}&payment=${prefs.payment}&host=${prefs.host}&uidguest1=${prefs.uidguest1}&uidguest2=${prefs.uidguest2}&uidguest3=${prefs.uidguest3}&date=${prefs.date}'),
      androidParameters: AndroidParameters(
        packageName: 'com.netopaez.meal',
        minimumVersion: 0,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.netopaez.meal',
        minimumVersion: '0',
      ),
    );

    Uri url;

    url = await parameters.buildUrl();

    return url.toString();
  }
}
