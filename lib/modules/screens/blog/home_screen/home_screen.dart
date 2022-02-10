import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mini_project/common/components/custom_elevated_button.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF343A40),
        title: const Text('Norse Mythology'),
        leading: const Icon(Icons.emoji_emotions),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomElevatedButton(
              selected: true,
                onPressed: () => {

                },
                child: const Text('Blog')
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
            child: CustomElevatedButton(
              selected: false,
                onPressed: () => {

                },
                child: const Text('GraphQL')
            ),
          )
        ],
      ),
    );
  }
}
