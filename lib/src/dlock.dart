import 'dart:async';

/// A simple asynchronous lock implementation.
class DLock {
  bool isLocked = false;
  Completer<void> completer = Completer<void>();

  /// Waits for the lock to be released, with an optional timeout.
  ///
  /// If [timeout] is provided, the method will return a [Future] that completes
  /// with an error if the lock is not released within the specified duration.
  Future<void>? wait({
    Duration? timeout,
  }) {
    if (timeout != null) {
      return completer.future.timeout(timeout);
    } else {
      return completer.future;
    }
  }

  /// Notifies any waiting futures that the lock is available.
  void notify() {
    if (!completer.isCompleted) {
      completer.complete();
    }
  }

  Future<void> firstLockOr<T>(
    FutureOr<void> Function() computation, {
    Duration? timeout,
  }) async {
    if (isLocked) {
      await wait(timeout: timeout);
    } else {
      try {
        completer = Completer<void>();
        isLocked = true;
        final result = computation();
        if (result is Future) {
          if (timeout != null) {
            // This could throw a timeout error
            await result.timeout(timeout);
          } else {
            await result;
          }
        }
      } finally {
        unlock();
      }
    }
  }

  /// Locks the resource for exclusive access until unlocked.
  ///
  /// If [timeout] is provided, this method will wait for the lock with an
  /// optional timeout.
  Future<void> lock({Duration? timeout}) async {
    while (isLocked) {
      await wait(timeout: timeout);
    }
    completer = Completer<void>();
    isLocked = true;
  }

  /// Executes [computation] while holding the lock, ensuring exclusive access.
  ///
  /// If [timeout] is provided, [computation] will be run with a timeout.
  /// The lock will be released after [computation] completes, regardless of
  /// success or failure.
  Future<T> withLock<T>(
    FutureOr<T> Function() computation, {
    Duration? timeout,
  }) async {
    try {
      await lock(timeout: timeout);
      final result = computation();
      if (result is Future) {
        if (timeout != null) {
          // This could throw a timeout error
          return await (result as Future).timeout(timeout);
        } else {
          return await result;
        }
      } else {
        return result;
      }
    } finally {
      unlock();
    }
  }

  /// Releases the lock, allowing other operations to proceed.
  void unlock() {
    isLocked = false;
    notify();
  }

  @override
  String toString() {
    return 'Lock[${identityHashCode(this)}]';
  }
}
