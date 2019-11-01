import 'package:flutter/material.dart';

class SimpleScreen extends StatelessWidget {
  const SimpleScreen({
    Key key,
    @required this.title,
    this.count = 0,
    @required this.backgroundColor,
    @required this.onBack,
    @required this.onNext,
    this.onNextFeature,
  }) : super(key: key);

  final int count;
  final String title;
  final Color backgroundColor;
  final VoidCallback onBack, onNext, onNextFeature;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(title + (count == 0 ? '' : ' ($count)')),
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
            if (onNextFeature != null)
              RaisedButton(
                child: Text('OTHER FEATURE'),
                onPressed: onNextFeature,
              ),
          ],
        ),
      ),
    );
  }
}
