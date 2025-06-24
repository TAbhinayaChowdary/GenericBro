import 'package:flutter/material.dart';
//generic_pharmacy_locator
class GenericPharmacyLocatorPage extends StatefulWidget {
  @override
  State<GenericPharmacyLocatorPage> createState() => _GenericPharmacyLocatorPageState();
}

class _GenericPharmacyLocatorPageState extends State<GenericPharmacyLocatorPage> {
  int _pharmacyType = 0; // 0: All, 1: Chain only, 2: Local only
  double _radius = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pharmacy Locator')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'PHARMACY LOCATOR',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[900],
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Choose your location',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 18),
              // Stacked input fields
              Text('Enter 6-digit PIN code', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 6),
              TextField(
                decoration: InputDecoration(
                  hintText: 'PIN code',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
              SizedBox(height: 14),
              Text('...or type an area / locality', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 6),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Area / Locality',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
              SizedBox(height: 14),
              Text('...or start typing a city', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 6),
              TextField(
                decoration: InputDecoration(
                  hintText: 'City',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
              SizedBox(height: 18),
              Center(child: Text('— or —', style: TextStyle(color: Colors.grey[700], fontSize: 16))),
              SizedBox(height: 18),
              Text('Pharmacy type', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Row(
                children: [
                  Radio<int>(
                    value: 0,
                    groupValue: _pharmacyType,
                    onChanged: (val) => setState(() => _pharmacyType = val!),
                    activeColor: Colors.red,
                  ),
                  Text('All'),
                  SizedBox(width: 12),
                  Radio<int>(
                    value: 1,
                    groupValue: _pharmacyType,
                    onChanged: (val) => setState(() => _pharmacyType = val!),
                    activeColor: Colors.red,
                  ),
                  Text('Chain only'),
                  SizedBox(width: 12),
                  Radio<int>(
                    value: 2,
                    groupValue: _pharmacyType,
                    onChanged: (val) => setState(() => _pharmacyType = val!),
                    activeColor: Colors.red,
                  ),
                  Text('Local only'),
                ],
              ),
              SizedBox(height: 18),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.my_location, size: 28),
                    onPressed: () {},
                  ),
                  SizedBox(width: 8),
                  Text('Use GPS'),
                ],
              ),
              SizedBox(height: 18),
              Text('Search radius (km)', style: TextStyle(fontWeight: FontWeight.w500)),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _radius,
                      min: 1,
                      max: 20,
                      divisions: 19,
                      label: _radius.round().toString(),
                      activeColor: Colors.red,
                      onChanged: (val) => setState(() => _radius = val),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(_radius.round().toString()),
                ],
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Enter city / PIN / locality or enable GPS.',
                  style: TextStyle(color: Colors.blue[900], fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
