import 'package:flutter/material.dart';

import 'feature_a.dart';
import 'feature_b.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      // simulating deep links
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'a':
            builder = (innerContext) => FeatureANavigator(
                  onClose: () => Navigator.of(innerContext).pop(),
                  onNextFeature: () => Navigator.pushNamed(innerContext, 'b'),
                );
            break;
          case 'b':
            builder = (innerContext) => FeatureBNavigator(
                  onClose: () => Navigator.of(innerContext).pop(),
                );
            break;
        }

        return MaterialPageRoute(
          builder: builder,
          settings: settings,
          fullscreenDialog: true,
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Base nav example')),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('A'),
              onPressed: () => Navigator.pushNamed(context, 'a'),
            ),
            const SizedBox(height: 8),
            RaisedButton(
              child: Text('B'),
              onPressed: () => Navigator.pushNamed(context, 'b'),
            ),
          ],
        ),
      ),
    );
  }
}
