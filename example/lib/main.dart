import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bridges_barcode/bridges_barcode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:barcode/barcode.dart' as bc;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _barcodeController = TextEditingController(text: '221234512345123452');

  late File _barcode;

  final _bc = bc.Barcode.dataMatrix();

  bool _isLoading = true;

  Future<void> createFile() async {
    _barcode = File('${await getTemporaryDirectory()}/barcode.svg');
  }

  Future<void> generateBarcode() async {
    setState(() {
      _isLoading = true;
    });

    final _svg = _bc.toSvg(_barcodeController.text);
    print('svg created');
    await _barcode.writeAsString(_svg);
    print('File barcode.svg has been wrote');

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    createFile().then((value) => generateBarcode());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Barcode example'),
        ),
        body: Column(
          children: [
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    flex: 2,
                    child: Image.file(_barcode),
                  ),
            Expanded(
              child: TextField(
                controller: _barcodeController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
