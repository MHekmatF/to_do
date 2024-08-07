import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
 final Widget child;
  // voidCallback onPress;
  final void Function() onPress;
  const DefaultElevatedButton({Key? key, required this.child, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress, child: child);
  }
}
