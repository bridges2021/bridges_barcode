library bridges_barcode;

class BarcodeSetting {
  /// Name for this [BarcodeSetting]
  String name;

  /// Barcode must start with and must end with
  String startWith, endWith;

  /// Length of barcode
  int length;

  List<Value> values;

  BarcodeSetting(
      {this.name = '',
      this.length = 0,
      this.values = const [],
      this.startWith = '',
      this.endWith = ''});

  List<String> get getKeySuggestion => ['ID', 'Weight', 'QTY', 'Price'];

  Map<String, dynamic> decode(String barcode) {
    print('Start decoding $barcode');
    if (barcode.length != length) {
      throw 'Length not match';
    } else if (barcode.startsWith(startWith) && barcode.endsWith(endWith)) {
      /// Decode
      Map<String, dynamic> map = {};
      try {
        values.forEach((value) => map[value.key] = value.decode(barcode));
        return map;
      } catch (e) {
        throw e;
      }
    } else {
      throw 'Starting character or ending character not match';
    }
  }
}

class Value {
  /// Key for the value
  String key;

  /// Position of the barcode to get value
  int start, end;

  /// Value of the key
  String decode(String barcode) {
    try {
      return barcode.substring(start, end);
    } catch (e) {
      throw '$key decode fail';
    }
  }

  Value({this.key = '', this.start = 0, this.end = 0});
}
