# BlendMask

A Flutter widget that applies BlendMode effects to its child widgets with proper layer compositing.

[![pub package](https://img.shields.io/pub/v/blend_mask.svg)](https://pub.dev/packages/blend_mask)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

## Problem

When using `BlendMode` in Flutter, especially within complex widget hierarchies like `Stack`, the blend mode effects often don't work as expected. This is because Flutter requires proper layer compositing for blend modes to function correctly.

## Solution

`BlendMask` solves this problem by creating a proper compositing layer that ensures blend mode effects work correctly in any widget hierarchy.

## Features

- ✅ Proper BlendMode support in Stack widgets
- ✅ Configurable opacity control
- ✅ Clean and simple API
- ✅ Optimized rendering performance
- ✅ Full Flutter widget lifecycle support
- ✅ Comprehensive documentation and examples

## Getting started

Add `blend_mask` to your `pubspec.yaml`:

```yaml
dependencies:
  blend_mask: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:blend_mask/blend_mask.dart';
import 'package:flutter/material.dart';

BlendMask(
  blendMode: BlendMode.multiply,
  child: Container(
    width: 100,
    height: 100,
    color: Colors.red,
  ),
)
```

### With Opacity

```dart
BlendMask(
  blendMode: BlendMode.overlay,
  opacity: 0.7,
  child: Image.asset('assets/my_image.png'),
)
```

### In a Stack (Common Use Case)

```dart
Stack(
  children: [
    // Background
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),
    // Blend mode overlay
    BlendMask(
      blendMode: BlendMode.screen,
      opacity: 0.8,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
      ),
    ),
  ],
)
```

## BlendMode Options

All Flutter `BlendMode` values are supported:
- `BlendMode.multiply`
- `BlendMode.screen`
- `BlendMode.overlay`
- `BlendMode.darken`
- `BlendMode.lighten`
- And many more...

## API Reference

### BlendMask

| Parameter | Type | Description | Required | Default |
|-----------|------|-------------|----------|---------|
| `blendMode` | `BlendMode` | The blend mode to apply | Yes | - |
| `opacity` | `double` | Opacity value (0.0 to 1.0) | No | `1.0` |
| `child` | `Widget?` | The child widget to apply blend mode to | No | `null` |
| `key` | `Key?` | Widget key | No | `null` |

## References
	•	[How to use BlendMode in Stack correctly – StackOverflow](https://stackoverflow.com/a/64737622/21099631)


## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
