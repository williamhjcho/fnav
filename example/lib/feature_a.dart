import 'package:flutter/material.dart';

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
                builder = (context) => _Home(
                      onBack: onClose,
                      onNext: () =>
                          Navigator.pushNamed(context, 'another', arguments: 1),
                      onNextFeature: onNextFeature,
                    );
                break;
              case 'another':
                builder = (context) {
                  final int count = settings.arguments;

                  return _Home(
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
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text('Feature A' + (count == 0 ? '' : '($count)')),
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
