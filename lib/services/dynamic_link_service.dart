import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';

class DynamicLinkService {
  void initDynamicLinks(GlobalKey<NavigatorState> navigatorKey) async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      var isPost = deepLink.pathSegments.contains('post');

      if (isPost) {
        var channelName = deepLink.queryParameters['channelName'];

        if (channelName != null) {
          navigatorKey.currentState
              .pushNamed(Routes.conference, arguments: channelName);
        }
      }
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print('_handleDeepLink | deeplink: $deepLink');

        var isPost = deepLink.pathSegments.contains('post');

        if (isPost) {
          var channelName = deepLink.queryParameters['channelName'];

          if (channelName != null) {
            print('Yes');
            navigatorKey.currentState
                .pushNamed(Routes.conference, arguments: channelName);
          }
        }
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  createDynamicLink(String channelName) async {
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
}
