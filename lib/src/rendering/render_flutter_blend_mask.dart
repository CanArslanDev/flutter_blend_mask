import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A render object that applies a [BlendMode] to its child with proper
/// layer compositing.
///
/// This render object creates a compositing layer with the specified
/// [blendMode]
/// and [opacity], ensuring that blend mode effects work correctly even within
/// complex widget hierarchies like [Stack].
class RenderBlendMask extends RenderProxyBox {
  /// Creates a [RenderBlendMask] with the given [blendMode] and [opacity].
  RenderBlendMask({
    required BlendMode blendMode,
    required double opacity,
  })  : _blendMode = blendMode,
        _opacity = opacity;

  BlendMode _blendMode;
  double _opacity;

  /// The blend mode to apply to the child.
  BlendMode get blendMode => _blendMode;

  set blendMode(BlendMode value) {
    if (_blendMode == value) return;
    _blendMode = value;
    markNeedsPaint();
  }

  /// The opacity to apply to the child.
  ///
  /// Must be between 0.0 (fully transparent) and 1.0 (fully opaque).
  double get opacity => _opacity;

  set opacity(double value) {
    assert(
      value >= 0.0 && value <= 1.0,
      'Opacity must be between 0.0 and 1.0',
    );
    if (_opacity == value) return;
    _opacity = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;

    // Create a new compositing layer with the specified blend mode and opacity
    context.canvas.saveLayer(
      offset & size,
      Paint()
        ..blendMode = _blendMode
        ..color = Color.fromARGB((opacity * 255).round(), 255, 255, 255),
    );

    // Paint the child
    super.paint(context, offset);

    // Restore the canvas to composite the layer
    context.canvas.restore();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<BlendMode>('blendMode', blendMode))
      ..add(DoubleProperty('opacity', opacity));
  }
}
