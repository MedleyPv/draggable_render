import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/gestures/hit_test.dart';

class RenderDraggableWidget extends RenderProxyBox {
  RenderDraggableWidget({
    required EdgeInsets padding,
    RenderBox? child,
  })  : _padding = padding,
        _position = null,
        super(child);

  EdgeInsets _padding;
  Offset? _position;

  set position(Offset offset) {
    if (offset == _position) return;

    _position = offset;
    child?.markNeedsLayout();
  }

  EdgeInsets get padding => _padding;
  set padding(EdgeInsets padding) {
    if (padding == _padding) return;

    _padding = padding;
    markNeedsLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final path = _drawPath(offset);
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    context.canvas.drawPath(
      path,
      paint,
    );

    _position ??= offset + Offset(padding.left, padding.top);
    if (child != null) {
      context.paintChild(child!, _position!);
    }
  }

  @override
  void performLayout() {
    size = _computeSize(
      constraints: constraints,
      childLayouter: (child, constraints) {
        child.layout(constraints, parentUsesSize: true);

        return child.size;
      },
    );
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return hitTestChildren(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final childSize = child?.size ?? Size.zero;
    final offset = child?.globalToLocal(_position!);

    final rect = Rect.fromPoints(
      offset!,
      Offset(offset.dx + childSize.width, offset.dy + childSize.height),
    );

    if (rect.contains(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }

    return false;
  }

  @override
  void handleEvent(
    PointerEvent event,
    covariant HitTestEntry<HitTestTarget> entry,
  ) {
    if (event is PointerMoveEvent) {
      position = _position! + event.delta;
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(
      constraints: constraints,
      childLayouter: (child, constraints) {
        return child.getDryLayout(constraints);
      },
    );
  }

  Size _computeSize({
    required BoxConstraints constraints,
    required ChildLayouter childLayouter,
  }) {
    if (child != null) {
      final childConstraints = constraints.deflate(padding);

      final childSize = childLayouter(child!, childConstraints);

      return Size(
        childSize.width + padding.horizontal,
        childSize.height + padding.vertical,
      );
    }

    return const Size(20, 20);
  }

  Path _drawPath(Offset offset) {
    return Path()
      ..moveTo(offset.dx, offset.dy)
      ..lineTo(offset.dx + size.width, offset.dy)
      ..lineTo(offset.dx + size.width, offset.dy + size.height)
      ..lineTo(offset.dx, offset.dy + size.height)
      ..lineTo(offset.dx, offset.dy);
  }
}
