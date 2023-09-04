import 'package:custom_render/widgets/draggable_widget/render_draggable_widget.dart';
import 'package:flutter/material.dart';

class DraggableWidget extends SingleChildRenderObjectWidget {
  const DraggableWidget({
    super.key,
    this.padding,
    Widget? child,
  }) : super(child: child);

  final EdgeInsets? padding;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderDraggableWidget(
      padding: padding ?? EdgeInsets.zero,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderDraggableWidget renderObject,
  ) {
    renderObject.padding = padding ?? EdgeInsets.zero;
  }
}
