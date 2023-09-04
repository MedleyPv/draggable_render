import 'package:custom_render/widgets/draggable_container/render_draggable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

class DraggableContainer extends LeafRenderObjectWidget {
  const DraggableContainer({
    super.key,
    required this.color,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  final Color color;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderDraggableContainer(
      width: width,
      height: height,
      color: color,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderDraggableContainer renderObject,
  ) {
    renderObject
      ..color = color
      ..width = width
      ..height = height;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('width', width))
      ..add(DoubleProperty('height', height));
  }
}
