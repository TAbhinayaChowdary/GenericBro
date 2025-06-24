// lib/generic_medicine_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class GenericMedicineFinderPage extends StatefulWidget {
  @override
  State<GenericMedicineFinderPage> createState() => _GenericMedicineFinderPageState();
}

class _GenericMedicineFinderPageState extends State<GenericMedicineFinderPage> {
  List<List<dynamic>> _data = [];
  List<List<dynamic>> _filteredData = [];
  String _search = '';
  int _toggleIndex = 0; // 0: Name, 1: Formulation
  String _therapeuticType = 'All';
  String _dosageFilter = 'All';
  String _sortBy = 'Generic price';
  String _formulation = '';
  String _order = 'Low -> High';

  List<String> _therapeuticTypes = ['All'];
  List<String> _dosageFilters = ['All'];
  List<String> _brandedMedicines = ['— select —'];
  List<String> _formulations = ['— select —'];

  final List<String> _sortOptions = ['Generic price', 'Branded price'];

  @override
  void initState() {
    super.initState();
    loadCSV();
  }

  Future<void> loadCSV() async {
    final rawData = await rootBundle.loadString('assets/test.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData, eol: '\n');
    setState(() {
      _data = listData;
      _filteredData = listData.sublist(1); // skip header

      // Assuming columns: 0=Name, 1=Therapeutic Type, 2=Dosage, 3=Formulation, 4=Generic Price, 5=Branded Price, 6=Saving, 7=Uses, 8=Side Effects, 9=Branded Medicine
      final Set<String> therapeuticTypes = {'All'};
      final Set<String> dosageFilters = {'All'};
      final Set<String> brandedMedicines = {'— select —'};
      final Set<String> formulations = {'— select —'};

      for (var row in listData.skip(1)) {
        if (row.length > 1) therapeuticTypes.add(row[1].toString());
        if (row.length > 2) dosageFilters.add(row[2].toString());
        if (row.length > 3) formulations.add(row[3].toString());
        if (row.length > 9) brandedMedicines.add(row[9].toString());
      }

      _therapeuticTypes = therapeuticTypes.toList();
      _dosageFilters = dosageFilters.toList();
      _formulations = formulations.toList();
      _brandedMedicines = brandedMedicines.toList();
    });
  }

  void filterData() {
    List<List<dynamic>> filtered = _data.sublist(1); // skip header

    // Apply filters
    if (_therapeuticType != 'All') {
      filtered = filtered.where((row) => row[1].toString() == _therapeuticType).toList();
    }
    if (_dosageFilter != 'All') {
      filtered = filtered.where((row) => row[2].toString() == _dosageFilter).toList();
    }
    if (_toggleIndex == 0 && _formulation != '— select —') {
      filtered = filtered.where((row) => row.length > 9 && row[9].toString() == _formulation).toList();
    }
    if (_toggleIndex == 1 && _formulation != '— select —') {
      filtered = filtered.where((row) => row[3].toString() == _formulation).toList();
    }

    // Sort
    int priceCol = _sortBy == 'Generic price' ? 4 : 5;
    filtered.sort((a, b) {
      double aVal = double.tryParse(a[priceCol].toString()) ?? 0;
      double bVal = double.tryParse(b[priceCol].toString()) ?? 0;
      return _order == 'Low -> High' ? aVal.compareTo(bVal) : bVal.compareTo(aVal);
    });

    setState(() {
      _filteredData = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headers = _data.isNotEmpty ? _data.first : [];

    return Scaffold(
      appBar: AppBar(title: Text('Generic Medicine Finder')),
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Column(
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
                    SizedBox(height: 8),
                    Text(
                      'Search & Filters',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[700],
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
                    // Responsive filter layout
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: _therapeuticType,
                            decoration: InputDecoration(labelText: 'Therapeutic Type', border: OutlineInputBorder()),
                            items: _therapeuticTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                            onChanged: (val) => setState(() => _therapeuticType = val!),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: _dosageFilter,
                            decoration: InputDecoration(labelText: 'Dosage Filter', border: OutlineInputBorder()),
                            items: _dosageFilters.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                            onChanged: (val) => setState(() => _dosageFilter = val!),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: _sortBy,
                            decoration: InputDecoration(labelText: 'Sort by', border: OutlineInputBorder()),
                            items: _sortOptions.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                            onChanged: (val) => setState(() => _sortBy = val!),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: _toggleIndex == 0
                              ? DropdownButtonFormField<String>(
                                  value: _brandedMedicines[0],
                                  decoration: InputDecoration(labelText: 'Branded Medicine', border: OutlineInputBorder()),
                                  items: _brandedMedicines.map((form) => DropdownMenuItem(value: form, child: Text(form))).toList(),
                                  onChanged: (val) => setState(() => _formulation = val!),
                                )
                              : DropdownButtonFormField<String>(
                                  value: _formulations[0],
                                  decoration: InputDecoration(labelText: 'Choose Formulation', border: OutlineInputBorder()),
                                  items: _formulations.map((form) => DropdownMenuItem(value: form, child: Text(form))).toList(),
                                  onChanged: (val) => setState(() => _formulation = val!),
                                ),
                        ),
                        SizedBox(
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order', style: TextStyle(fontWeight: FontWeight.w500)),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    value: 'Low -> High',
                                    groupValue: _order,
                                    onChanged: (val) => setState(() => _order = val!),
                                  ),
                                  Text('Low → High'),
                                  Radio<String>(
                                    value: 'High -> Low',
                                    groupValue: _order,
                                    onChanged: (val) => setState(() => _order = val!),
                                  ),
                                  Text('High → Low'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: filterData,
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
                    if (_filteredData.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Text('Dosage', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Text('Generic ₹', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Text('Branded ₹', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Text('Savings %', style: TextStyle(fontWeight: FontWeight.bold))),
                            ],
                          ),
                          Divider(),
                          ..._filteredData.map((row) => Row(
                            children: [
                              Expanded(child: Text(row[0]?.toString() ?? '')),
                              Expanded(child: Text(row[2]?.toString() ?? '')),
                              Expanded(child: Text(row[4]?.toString() ?? '')),
                              Expanded(child: Text(row[5]?.toString() ?? '')),
                              Expanded(child: Text(row[6]?.toString() ?? '')),
                            ],
                          )),
                        ],
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('No results found.'),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}