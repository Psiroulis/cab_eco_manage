import 'package:flutter/material.dart';

class YesNoButtonsDialog extends StatelessWidget {
  final String message;
  final Function() yesCallback;
  final Function() noCallback;

  const YesNoButtonsDialog({
    required this.message,
    required this.yesCallback,
    required this.noCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: yesCallback,
                child: const Text('Yes'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: noCallback,
                child: const Text('No'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
