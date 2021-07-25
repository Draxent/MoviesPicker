import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage(this.errorMessage, this.route);

  final String errorMessage;
  final String route;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(errorMessage),
                SharedWidgets.vSpace,
                ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed(route),
                  child: const Text('RETRY'),
                )
              ],
            ),
          ),
        ),
      );
}
