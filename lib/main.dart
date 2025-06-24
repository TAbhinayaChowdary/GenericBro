import 'package:flutter/material.dart';
import 'generic_medicine_page.dart';

void main() => runApp(GenericBroApp());

class GenericBroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenericBro',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to GenericBro')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenericMedicineFinderPage(),
                  ),
                ),
                child: Text('Generic Medicine Finder'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Generic Pharmacy Locator - Coming Soon!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Generic Pharmacy Locator'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
