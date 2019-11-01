import 'package:basenav/basenav.dart';
import 'package:flutter/material.dart';

class FeatureCNavigator extends RouteNavigator {
  FeatureCNavigator({
    @required VoidCallback onClose,
    @required VoidCallback onNextFeature,
  }) : super(initialRoute: Navigator.defaultRouteName, routes: {
          '/': (settings) {
            return MaterialPageRoute(
              builder: (context) => _Home(
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

                return _Home(
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

class _Home extends StatelessWidget {
  const _Home({
    Key key,
    this.count = 0,
    @required this.onBack,
    @required this.onNext,
    @required this.onNextFeature,
  }) : super(key: key);

  final int count;
  final VoidCallback onBack, onNext, onNextFeature;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Feature C' + (count == 0 ? '' : '($count)')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('NEXT'),
              onPressed: onNext,
            ),
            RaisedButton(
              child: Text('FEATURE B'),
              onPressed: onNextFeature,
            ),
          ],
        ),
      ),
    );
  }
}
