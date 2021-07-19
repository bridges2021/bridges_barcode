# bridges_barcode
 Get value from barcode by settings
## Installation
1. Add this lines to your pubspec.yaml
```yaml
bridges_barcode:
  git:
    url: https://github.com/bridges2021/bridges_barcode.git
    ref: main
```
## How to use
1. Create BarcodeSetting class
```dart
final _barcodeSetting = BarcodeSetting();
```
2. Modify values in BarcodeSetting
```dart
_barcodeSetting.name = 'New barcode setting';
_barcodeSetting.length = 18;
_barcodeSetting.startWith = '2';
_barcodeSetting.endWith = '3';
```
3. Add Values to BarcodeSetting
```dart
_barcodeSetting.values = [
  Value(
    key: 'ID',
    start: 2,
    end: 7,
  ),
  Value(
    key: 'price',
    start: 7,
    end: 12
  ),
  Value(
    key: 'weight',
    start: 12,
    end: 17
  )
];
```
4. Get result by decode()
```dart
try {
  return _barcodeSetting.decode(_barcode);
} catch (e) {
  print(e);
}
```
