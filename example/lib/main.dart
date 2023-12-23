import 'package:basemind/client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BasemindExample());
}

class BasemindExample extends StatelessWidget {
  const BasemindExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BaseMind Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      home: const AIDJPage(),
    );
  }
}

class AIDJPage extends StatefulWidget {
  const AIDJPage({super.key});

  @override
  _AIDJPageState createState() => _AIDJPageState();
}

class _AIDJPageState extends State<AIDJPage> {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController responseController = TextEditingController();
  final BaseMindClient client = BaseMindClient('YOUR_API_KEY');

  void _sendToBaseMind(String userInput) {
    setState(() {
      responseController.text = '';
    });
    client.requestStream({'user_input': userInput}).listen((response) {
      setState(() {
        responseController.text += response.content;
      });
    }, onError: (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI DJ | Album Recommendations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            TextField(
              controller: inputController,
              decoration: const InputDecoration(
                labelText: 'Tell the DJ your favorite albums or artists',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _sendToBaseMind(inputController.text),
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: responseController,
                decoration: const InputDecoration(
                  labelText: 'AI DJ response',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}