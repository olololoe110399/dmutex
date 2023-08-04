# DMUTEX

**dmutex** is a Dart package that provides asynchronous locks and reentrant locks for effective concurrency control in your Dart applications. With `DLock`, you can ensure exclusive access to critical sections of your code, preventing race conditions and conflicts. Additionally, the `ReentrantDLock` class allows nested synchronized blocks, providing a more flexible locking mechanism for complex scenarios.

[![Pub Version](https://img.shields.io/pub/v/dmutex)](https://pub.dev/packages/dmutex)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Brief description of your package.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  dmutex: ^1.0.0
```

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

For more examples, check out the example directory.

## Testing

To run the tests for this package, use the following command:

```bash
dart test
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
