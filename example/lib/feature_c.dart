import 'package:basenav/basenav.dart';
import 'package:flutter/material.dart';

import 'simple_screen.dart';

// Simple named key -> Route<T> map
class FeatureCNavigator extends RouteNavigator {
  FeatureCNavigator({
    @required VoidCallback onClose,
    @required VoidCallback onNextFeature,
  }) : super(routes: {
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

// Simple named key -> Screen<dynamic> map
class FeatureC2Navigator extends ScreenRouteNavigator {
  FeatureC2Navigator({
    @required VoidCallback onClose,
    @required VoidCallback onNextFeature,
  }) : super(routes: {
          '/': (settings) {
            return ScreenRoute(
              builder: (context) => SimpleScreen(
                title: 'Feature C',
                backgroundColor: Colors.blue,
                onBack: onClose,
                onNext: () =>
                    Navigator.pushNamed(context, 'another', arguments: 1),
                onNextFeature: onNextFeature,
              ),
            );
          },
          'another': (settings) {
            return ScreenRoute(
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
            );
          },
        });
}
