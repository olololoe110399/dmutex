# dmutex

[![Pub Version](https://img.shields.io/pub/v/dmutex)](https://pub.dev/packages/dmutex)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

`dmutex` is a Dart package that provides a smart locking mechanism to control concurrency in your Dart applications. It helps prevent chaotic execution and ensures orderly processing of tasks in a single-threaded environment.

## Overview

In a single-threaded programming world like Dart, managing concurrent execution can still be challenging, especially when dealing with asynchronous tasks. `dmutex` comes to the rescue by providing a specialized locking mechanism known as a "mutex" (short for "mutual exclusion"). Just like a special key ensures only one person (or "task") is allowed to access a particular resource at a time, `dmutex` helps ensure that only one task can access a critical section at a time.

`dmutex` helps you maintain order and prevent conflicts when working with asynchronous tasks, even in a single-threaded environment like Dart.

## Features

- Provides a smart locking mechanism for controlling concurrency.
- Prevents multiple asynchronous tasks from accessing critical sections simultaneously.
- Offers both basic locking (`DLock`) and reentrant locking (`ReentrantDLock`).
- Helps maintain execution order and synchronization.
- Easily integrates with your Dart applications.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  dmutex: ^1.0.0
```

Then, run `dart pub get` to install the package.

## Usage

Here's how you can use the classes provided by this package.

## DLock

An asynchronous lock implementation that provides exclusive access control.

```dart
import 'package:dmutex/dmutex.dart';

void main() async {
  final dLock = DLock();

  await dLock.withLock(() async {
    // Critical section
  });
}
```

## ReentrantDLock

A reentrant lock that allows nested synchronized blocks.

```dart
import 'package:dmutex/dmutex.dart';

void main() async {
  final reentrantDLock = ReentrantDLock();

  await reentrantDLock.withLock(() async {
    // Outer synchronized block

    await reentrantDLock.withLock(() async {
      // Inner synchronized block
    });
  });
}
```

## Examples

For more examples, check out the [example](example) directory.

## Testing

To run the tests for this package, use the following command:

```bash
dart test
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Note

 This is a basic overview of `dmutex`. For more detailed information and advanced usage, refer to the package documentation on [pub.dev](https://pub.dev/).

Maintained with ❤️ by olololoe110399
