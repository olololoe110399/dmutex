import 'package:test/test.dart';
import 'package:dmutex/dmutex.dart';

void main() {
  group('ReentrantDLock', () {
    test('Lock and unlock', () async {
      final reentrantDLock = ReentrantDLock();

      await reentrantDLock.withLock(() async {
        expect(reentrantDLock.innerLevel, 1);

        await reentrantDLock.withLock(() async {
          expect(reentrantDLock.innerLevel, 2);
        });

        expect(reentrantDLock.innerLevel, 1);
      });
    });

    // Add more test cases as needed
  });
}
