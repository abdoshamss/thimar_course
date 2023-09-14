 import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final result = await FilePicker.platform.pickFiles(
          //   allowMultiple: true,
          //   type: FileType.any,
          // );
        },
        child: const Text("Pick"),
      ),
    );
  }
}
