import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../rendering/render_blend_mask.dart';

/// A widget that applies a [BlendMode] to its child with proper layer
/// compositing.
///
/// This widget solves the common issue where [BlendMode] effects don't work
/// properly when used within a [Stack] or other complex widget hierarchies.
/// It ensures that the blend mode is applied correctly by creating a proper
/// compositing layer.
///
/// Example usage:
/// ```dart
/// BlendMask(
///   blendMode: BlendMode.multiply,
///   opacity: 0.8,
///   child: Container(
///     width: 100,
///     height: 100,
///     color: Colors.red,
///   ),
/// )
/// ```
class BlendMask extends SingleChildRenderObjectWidget {
  /// Creates a [BlendMask] widget.
  ///
  /// The [blendMode] parameter is required and specifies how the child
  /// should be blended with the background.
  ///
  /// The [opacity] parameter defaults to 1.0 and must be between 0.0 and 1.0.
  const BlendMask({
    required this.blendMode,
    this.opacity = 1.0,
    super.key,
    super.child,
  }) : assert(
          opacity >= 0.0 && opacity <= 1.0,
          'Opacity must be between 0.0 and 1.0',
        );

  /// The blend mode to apply to the child.
  final BlendMode blendMode;

  /// The opacity to apply to the child.
  ///
  /// Must be between 0.0 (fully transparent) and 1.0 (fully opaque).
  /// Defaults to 1.0.
  final double opacity;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderBlendMask(blendMode: blendMode, opacity: opacity);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderBlendMask renderObject,
  ) {
    renderObject
      ..blendMode = blendMode
      ..opacity = opacity;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<BlendMode>('blendMode', blendMode))
      ..add(DoubleProperty('opacity', opacity));
  }
}
