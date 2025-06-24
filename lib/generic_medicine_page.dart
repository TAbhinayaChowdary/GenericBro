// lib/generic_medicine_page.dart

import 'package:flutter/material.dart';

class GenericMedicineFinderPage extends StatefulWidget {
  @override
  State<GenericMedicineFinderPage> createState() => _GenericMedicineFinderPageState();
}

class _GenericMedicineFinderPageState extends State<GenericMedicineFinderPage> {
  // Sample static data for frontend display
  final List<List<String>> _nameData = [
    ['Paracetamol', '500mg', '10', '30', '66', 'Analgesic', 'Crocin'],
    ['Ibuprofen', '400mg', '15', '45', '66', 'Anti-inflammatory', 'Brufen'],
    ['Cetirizine', '10mg', '8', '25', '68', 'Antihistamine', 'Cetzine'],
  ];
  final List<List<String>> _formulationData = [
    ['Tablet', 'Analgesic', '500mg', '10', '30', '66'],
    ['Tablet', 'Anti-inflammatory', '400mg', '15', '45', '66'],
    ['Tablet', 'Antihistamine', '10mg', '8', '25', '68'],
  ];

  int _toggleIndex = 0; // 0: Name, 1: Formulation

  @override
  Widget build(BuildContext context) {
    final isName = _toggleIndex == 0;
    final data = isName ? _nameData : _formulationData;
    return Scaffold(
      appBar: AppBar(title: Text('Generic Medicine Finder')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'GENERIC MEDICINE FINDER',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.teal[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Divider(thickness: 1.2),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ToggleButtons(
                        isSelected: [_toggleIndex == 0, _toggleIndex == 1],
                        onPressed: (index) {
                          setState(() {
                            _toggleIndex = index;
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        selectedColor: Colors.white,
                        fillColor: Colors.teal,
                        color: Colors.teal,
                        borderColor: Colors.teal,
                        selectedBorderColor: Colors.teal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                            child: Text('Name', style: TextStyle(fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                            child: Text('Formulation', style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  // Filter UI (non-functional)
                  Column(
                    children: [
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: 'All',
                        decoration: InputDecoration(
                          labelText: 'Therapeutic Type',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        items: ['All', 'Analgesic', 'Anti-inflammatory', 'Antihistamine'].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: 'All',
                        decoration: InputDecoration(
                          labelText: 'Dosage Filter',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        items: ['All', '500mg', '400mg', '10mg'].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                        onChanged: (val) {},
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: 'Generic price',
                        decoration: InputDecoration(
                          labelText: 'Sort by',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        items: ['Generic price', 'Branded price'].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                        onChanged: (val) {},
                      ),
                      if (isName) ...[
                        SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: 'Crocin',
                          decoration: InputDecoration(
                            labelText: 'Branded Medicine',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          ),
                          items: ['Crocin', 'Brufen', 'Cetzine'].map((form) => DropdownMenuItem(value: form, child: Text(form))).toList(),
                          onChanged: (val) {},
                        ),
                      ],
                      if (!isName) ...[
                        SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: 'Tablet',
                          decoration: InputDecoration(
                            labelText: 'Choose Formulation',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          ),
                          items: ['Tablet', 'Capsule', 'Syrup'].map((form) => DropdownMenuItem(value: form, child: Text(form))).toList(),
                          onChanged: (val) {},
                        ),
                      ],
                      SizedBox(height: 12),
                      // Order row
                      SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: 'Low -> High',
                                groupValue: 'Low -> High',
                                onChanged: (val) {},
                              ),
                              Text('Low → High'),
                              Radio<String>(
                                value: 'High -> Low',
                                groupValue: 'Low -> High',
                                onChanged: (val) {},
                              ),
                              Text('High → Low'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            side: BorderSide(color: Colors.teal),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.teal,
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          child: Text('Search'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Results Table
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 16,
                      headingRowColor: MaterialStateProperty.all(Colors.teal[50]),
                      columns: isName
                          ? [
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)))),
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Dosage', style: TextStyle(fontWeight: FontWeight.bold)))),
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Generic ₹', style: TextStyle(fontWeight: FontWeight.bold)))),
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Branded ₹', style: TextStyle(fontWeight: FontWeight.bold)))),
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Savings %', style: TextStyle(fontWeight: FontWeight.bold)))),
                            ]
                          : [
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Formulation', style: TextStyle(fontWeight: FontWeight.bold)))),
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Therapeutic Type', style: TextStyle(fontWeight: FontWeight.bold)))),
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Dosage', style: TextStyle(fontWeight: FontWeight.bold)))),
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Generic ₹', style: TextStyle(fontWeight: FontWeight.bold)))),
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Branded ₹', style: TextStyle(fontWeight: FontWeight.bold)))),
                              DataColumn(label: Padding(padding: EdgeInsets.all(8), child: Text('Savings %', style: TextStyle(fontWeight: FontWeight.bold)))),
                            ],
                      rows: data
                          .map(
                            (row) => DataRow(
                              cells: row
                                  .take(isName ? 5 : 6)
                                  .map(
                                    (cell) => DataCell(
                                      Container(
                                        width: 80,
                                        child: Text(
                                          cell,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
