import 'package:flutter/material.dart';
import 'package:bridges_barcode/bridges_barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:barcode/barcode.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String _barcode;

  late BarcodeSetting _barcodeSetting;

  final _formKey = GlobalKey<FormState>();

  void init() {
    setState(() {
      _barcode = '22id001weighprice2';
      _barcodeSetting = BarcodeSetting(
          name: 'default',
          length: 18,
          values: [
            Value(
              key: 'ID',
              start: 2,
              end: 7,
            ),
            Value(key: 'price', start: 7, end: 12),
            Value(
              key: 'weight',
              start: 12,
            )
          ],
          startWith: '22',
          endWith: '2');
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Map<String, dynamic> getDecodedMap() {
    try {
      return _barcodeSetting.decode(_barcode);
    } catch (e) {
      print(e);
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Barcode example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ListTile(
                  leading: Text('Barcode settings name:'),
                  title: Text(_barcodeSetting.name),
                ),
                ListTile(
                  leading: Text('Barcode length:'),
                  title: Text('${_barcodeSetting.length}'),
                ),
                Expanded(
                  flex: 2,
                  child: SvgPicture.string(Barcode.code128().toSvg(_barcode)),
                ),
                Text('You will get: ${getDecodedMap()}'),
                Expanded(
                  child: TextFormField(
                    initialValue: _barcode,
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: (string) {
                      setState(() {
                        _barcode = string;
                        _barcodeSetting.length = _barcode.length;
                      });
                    },
                    validator: (string) {
                      try {
                        _barcodeSetting.decode(_barcode);
                        return null;
                      } catch (e) {
                        return e.toString();
                      }
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.refresh), onPressed: init)),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _barcodeSetting.startWith,
                        onChanged: (string) {
                          _barcodeSetting.startWith = string;
                        },
                        decoration: InputDecoration(labelText: 'Start with'),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(
                            text: _barcodeSetting.endWith),
                        onChanged: (string) {
                          setState(() {
                            _barcodeSetting.endWith = string;
                          });
                        },
                        decoration: InputDecoration(labelText: 'End with'),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 7,
                  child: ListView(
                    children: [
                      ..._barcodeSetting.values.map((e) => Stack(
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      TextField(
                                        onChanged: (string) {
                                          setState(() {
                                            e.key = string;
                                          });
                                        },
                                        decoration:
                                            InputDecoration(labelText: 'Key'),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              onChanged: (string) {
                                                if (int.tryParse(string) !=
                                                    null) {
                                                  setState(() {
                                                    e.start = int.parse(string);
                                                  });
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  labelText: 'From'),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextField(
                                              onChanged: (string) {
                                                if (int.tryParse(string) !=
                                                    null) {
                                                  setState(() {
                                                    e.end = int.parse(string);
                                                  });
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  labelText: 'To'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () {
                                    setState(() {
                                      _barcodeSetting.values.remove(e);
                                    });
                                  },
                                ),
                              )
                            ],
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _barcodeSetting.values
                                  .add(Value(key: '', start: 0, end: 0));
                            });
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
