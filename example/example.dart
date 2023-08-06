import 'package:dmutex/dmutex.dart';

void main() async {
  final dLock = DLock(); // Create a DLock object

  // Example 1: Use DLock to ensure only one task executes at a time
  await dLock.withLock(() async {
    print('Job 1 is executing...');
    await Future.delayed(Duration(seconds: 2));
    print('Job 1 has completed.');
  });

  // Example 2: Use ReentrantDLock to control concurrency across multiple levels
  final reentrantDLock = ReentrantDLock();
  await reentrantDLock.withLock(() async {
    print('Outer-level Job 2 is executing...');
    await reentrantDLock.withLock(() async {
      print('Inner-level Job 2 is executing...');
      await Future.delayed(Duration(seconds: 1));
      print('Inner-level Job 2 has completed.');
    });
    print('Outer-level Job 2 has completed.');
  });

  // Example 3: Use DLock to control synchronization of API calls
  await Future.wait([
    dLock.withLock(() async {
      print('Calling API 1...');
      await Future.delayed(Duration(seconds: 2));
      print('API 1 call has completed.');
    }),
    dLock.withLock(() async {
      print('Calling API 2...');
      await Future.delayed(Duration(seconds: 1));
      print('API 2 call has completed.');
    }),
  ]);
}
