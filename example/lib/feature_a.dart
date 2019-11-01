import 'package:flutter/material.dart';

import 'simple_screen.dart';

class FeatureANavigator extends Navigator {
  FeatureANavigator({
    @required VoidCallback onClose,
    @required VoidCallback onNextFeature,
  }) : super(
          initialRoute: Navigator.defaultRouteName,
          onGenerateRoute: (settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case Navigator.defaultRouteName:
                builder = (context) => SimpleScreen(
                      title: 'Feture A',
                      backgroundColor: Colors.red,
                      onBack: onClose,
                      onNext: () =>
                          Navigator.pushNamed(context, 'another', arguments: 1),
                      onNextFeature: onNextFeature,
                    );
                break;
              case 'another':
                builder = (context) {
                  final int count = settings.arguments;

                  return SimpleScreen(
                    title: 'Feture A',
                    backgroundColor: Colors.red,
                    count: count,
                    onBack: () => Navigator.pop(context),
                    onNext: () => Navigator.pushNamed(context, 'another',
                        arguments: count + 1),
                    onNextFeature: onNextFeature,
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
