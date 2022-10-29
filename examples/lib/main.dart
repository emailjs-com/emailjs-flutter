import 'package:flutter/material.dart';
import 'package:emailjs/emailjs.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo EmailJS',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(title: 'Flutter Demo EmailJS'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _sendEmail() async {
    try {
      await EmailJS.send(
        '<YOUR_SERVICE_ID>',
        '<YOUR_TEMPLATE_ID>',
        {
          'user_email': 'hi@example.com',
          'message': 'Hi',
        },
        '<YOUR_PUBLIC_KEY>',
      );
      print('SUCCESS!');
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Press "Send Email" to send email',
            ),
            ElevatedButton(
                onPressed: _sendEmail, child: const Text('Send Email')),
          ],
        ),
      ),
    );
  }
}
