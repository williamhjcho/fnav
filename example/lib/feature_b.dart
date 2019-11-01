import 'package:flutter/material.dart';

class FeatureBNavigator extends Navigator {
  FeatureBNavigator({
    @required VoidCallback onClose,
  }) : super(
          initialRoute: Navigator.defaultRouteName,
          onGenerateRoute: (settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case Navigator.defaultRouteName:
                builder = (context) => _Home(
                      onBack: onClose,
                      onNext: () => Navigator.of(context).pushNamed('another'),
                    );
                break;
              case 'another':
                builder = (context) => _Home(
                      onBack: () => Navigator.of(context).pop(),
                      onNext: () => Navigator.of(context).pushNamed('another'),
                    );
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
    @required this.onBack,
    @required this.onNext,
  }) : super(key: key);

  final VoidCallback onBack, onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text('Feature B'),
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
          ],
        ),
      ),
    );
  }
}
