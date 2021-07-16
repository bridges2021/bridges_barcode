library bridges_barcode;

class Barcode {
  /// Name for this barcode setting
  String name;

  String mustStartWith, mustEndWith;

  /// Length of Barcode
  int length;

  List<Value> values;

  Barcode({required this.name, required this.length, required this.values, required this.mustStartWith, required this.mustEndWith});

  List<String> get getKeySuggestion => [
    'ID', 'Weight', 'QTY', 'Price'
  ];
}

class Value {
  /// Key for the value
  String key;

  /// Position of the barcode to get value
  int from, to;

  /// Value of the key
  dynamic value;

  Value({required this.key, required this.value, required this.from, required this.to});
}