import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _isLoading = false;
  String _data = '';

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://raw.githubusercontent.com/Ritika457/ritka_17/main/ritika.json'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _data = jsonData['name'];
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conditional Visibility and API Call'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !_isLoading && _data.isNotEmpty,
              child: Text(_data),
            ),
            if (_isLoading)
              CircularProgressIndicator(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: Text('Show required data'),
            ),
          ],
        ),
      ),
    );
  }
}
