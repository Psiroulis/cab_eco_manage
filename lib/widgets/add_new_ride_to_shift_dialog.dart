import 'package:flutter/material.dart';

class AddNewRideDialog extends StatelessWidget {
  const AddNewRideDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Form(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('dismiss'))
          ],
        ),
      ),
    );
  }
}
