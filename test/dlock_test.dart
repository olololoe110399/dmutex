import 'package:test/test.dart';
import 'package:dmutex/dmutex.dart';

void main() {
  group('DLock Tests', () {
    test('Lock and unlock', () async {
      final dLock = DLock();

      await dLock.lock();
      expect(dLock.isLocked, isTrue);

      dLock.unlock();
      expect(dLock.isLocked, isFalse);
    });

    test('Wait for lock release', () async {
      final dLock = DLock();

      Future<void> lockedTask() async {
        await dLock.lock();
        await Future.delayed(Duration(seconds: 1));
        dLock.unlock();
      }

      Future<void> waitingTask() async {
        await dLock.wait();
      }

      final locked = lockedTask();
      await Future.delayed(Duration(milliseconds: 500));
      final waiting = waitingTask();

      final results = await Future.wait([locked, waiting]);
      expect(results, [null, null]);
    });
  });
}
