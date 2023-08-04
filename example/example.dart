import 'package:dmutex/dmutex.dart';

void main() async {
  // Example usage of the DLock class
  final dLock = DLock();

  await dLock.withLock(() async {
    print("Acquired DLock");
    await Future.delayed(Duration(seconds: 2));
    print("Released DLock");
  });

  // Example usage of the ReentrantDLock class
  final reentrantDLock = ReentrantDLock();

  await reentrantDLock.withLock(() async {
    print("Acquired ReentrantDLock");

    await reentrantDLock.withLock(() async {
      print("Acquired Nested ReentrantDLock");
      await Future.delayed(Duration(seconds: 1));
      print("Released Nested ReentrantDLock");
    });

    await Future.delayed(Duration(seconds: 2));
    print("Released ReentrantDLock");
  });

  print("Example completed");
}
