import 'dart:mirrors';

import 'package:model_mixer/model_mixer.dart';
import 'package:test/test.dart';

void main() {
  ModelMixer modelMixer = ModelMixer();

  test("test build", () {
    TestObject testObject = modelMixer.build(TestObject);
    expect(String, testObject.stringValue.runtimeType);
  });

  group("test buildList", () {
    test("default", () {
      List<TestObject> list = modelMixer.buildList(TestObject);
      expect(10, list.length);
      list.forEach((element) {
        expect(String, element.stringValue.runtimeType);
      });
    });

    for (int i = 1; i < 100; i++) {
      test('given: $i expected: $i', () {
        List<TestObject> list = modelMixer.buildList(TestObject, i);
        expect(i, list.length);
        list.forEach((element) {
          expect(String, element.stringValue.runtimeType);
        });
      });
    }
  });

  group("test arguments", () {
    ClassMirror mirror = reflectClass(TestObject);

    test("test method", () {
      List<dynamic> arguments = ModelMixer.getArguments(mirror);
      expect(1, arguments.length);
      expect(String, arguments[0].runtimeType);
    });

    test("test extension", () {
      List<dynamic> arguments = mirror.arguments();
      expect(1, arguments.length);
      expect(String, arguments[0].runtimeType);
    });
  });
}

class TestObject {
  TestObject(this.stringValue);

  final String stringValue;
}
