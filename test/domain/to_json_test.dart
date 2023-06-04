import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/domain/to_json.dart';

void main() {
  test('func test', () async {
    var res = await convert2JsonFile("C:\\Users\\suhan\\Downloads", "./output");
    print(res);
  });
}
