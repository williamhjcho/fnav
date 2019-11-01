import 'package:basenav/basenav.dart';
import 'package:flutter/material.dart';

import 'simple_screen.dart';

class FeatureCNavigator extends RouteNavigator {
  FeatureCNavigator({
    @required VoidCallback onClose,
    @required VoidCallback onNextFeature,
  }) : super(initialRoute: Navigator.defaultRouteName, routes: {
          '/': (settings) {
            return MaterialPageRoute(
              builder: (context) => SimpleScreen(
                title: 'Feature C',
                backgroundColor: Colors.blue,
                onBack: onClose,
                onNext: () =>
                    Navigator.pushNamed(context, 'another', arguments: 1),
                onNextFeature: onNextFeature,
              ),
              settings: settings,
            );
          },
          'another': (settings) {
            return MaterialPageRoute(
              builder: (context) {
                final int count = settings.arguments;

                return SimpleScreen(
                  title: 'Feature C',
                  backgroundColor: Colors.blue,
                  count: count,
                  onBack: () => Navigator.pop(context),
                  onNext: () => Navigator.pushNamed(context, 'another',
                      arguments: count + 1),
                  onNextFeature: onNextFeature,
                );
              },
              settings: settings,
            );
          },
        });
}
