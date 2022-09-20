import 'package:flutter/material.dart';

import 'service_calls.dart';

class UrlPage extends StatefulWidget {
  const UrlPage({Key? key}) : super(key: key);

  @override
  State<UrlPage> createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  @override
  Widget build(BuildContext context) {
    final urlTextInputController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Set valid API base URL in order to continue')),
              TextField(
                controller: urlTextInputController,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.swap_horiz_outlined,
                    color: Colors.blue,
                  ),
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your url',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ServiceCalls( urlString: urlTextInputController.text,)));
                },
                child: const Text("Start counting process"),
              ),
            ],
          )),
    );
  }
}
