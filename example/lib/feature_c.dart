import 'package:flutter/material.dart';

import 'simple_screen.dart';

class FeatureCNavigator extends Navigator {
  FeatureCNavigator({
    String initialRoute,
    @required VoidCallback onClose,
  }) : super(
          initialRoute: initialRoute,
          onGenerateRoute: (settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case Navigator.defaultRouteName:
                builder = (context) {
                  return SimpleScreen(
                    title: 'Feature B',
                    backgroundColor: Colors.yellow,
                    onBack: onClose,
                    onNext: () => Navigator.of(context).pushNamed('another'),
                  );
                };
                break;
              case 'another':
                builder = (context) {
                  return SimpleScreen(
                    title: 'Feature B',
                    backgroundColor: Colors.yellow,
                    onBack: () => Navigator.of(context).pop(),
                    onNext: () => Navigator.of(context).pushNamed('another'),
                  );
                };
                break;
              default:
                break;
            }

            return MaterialPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        );
}
