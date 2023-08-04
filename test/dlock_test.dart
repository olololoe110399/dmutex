import 'package:test/test.dart';
import 'package:dmutex/dmutex.dart';

void main() {
  group('DLock', () {
    test('Lock and unlock', () async {
      final dLock = DLock();

      await dLock.lock();
      expect(dLock.isLocked, isTrue);

      dLock.unlock();
      expect(dLock.isLocked, isFalse);
    });

    // Add more test cases as needed
  });
}
