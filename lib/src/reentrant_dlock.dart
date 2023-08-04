import 'dart:async';
import 'dlock.dart';

/// A reentrant lock that allows nesting of synchronized blocks.
class ReentrantDLock {
  final List<DLock> innerLocks = [DLock()];

  int get innerLevel => (Zone.current[this] as int?) ?? 0;

  /// Executes [func] while holding the reentrant lock.
  ///
  /// If [timeout] is provided, [func] will be run with a timeout.
  ///
  /// Supports nested synchronized blocks by maintaining an inner level count.
  Future<T> withLock<T>(
    FutureOr<T> Function() func, {
    Duration? timeout,
  }) async {
    final level = innerLevel;

    if (level >= innerLocks.length) {
      throw StateError(
          'This can happen if an inner synchronized block is spawned outside the block it was started from. Make sure the inner synchronized blocks are properly awaited');
    }
    final lock = innerLocks[level];

    return lock.withLock(() async {
      innerLocks.add(DLock());
      try {
        final result = runZoned(() {
          return func();
        }, zoneValues: {this: level + 1});
        if (result is Future) {
          return await result;
        } else {
          return result;
        }
      } finally {
        innerLocks.removeLast();
      }
    }, timeout: timeout);
  }

  @override
  String toString() => 'ReentrantLock[${identityHashCode(this)}]';
}
