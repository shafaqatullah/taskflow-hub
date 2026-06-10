import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow_hub/core/errors/failures.dart';
import 'package:taskflow_hub/core/utils/validators.dart';

void main() {
  group('Validators', () {
    test('rejects empty titles', () {
      expect(Validators.validateTitle(''), isNotNull);
      expect(Validators.validateTitle('   '), isNotNull);
    });

    test('accepts valid titles', () {
      expect(Validators.validateTitle('Ship feature'), isNull);
    });

    test('ensureValidTaskInput throws ValidationFailure', () {
      expect(
        () => Validators.ensureValidTaskInput(title: '', description: ''),
        throwsA(isA<ValidationFailure>()),
      );
    });
  });
}
