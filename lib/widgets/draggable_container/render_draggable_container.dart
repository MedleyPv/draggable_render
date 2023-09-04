import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';

class RenderDraggableContainer extends RenderBox {
  RenderDraggableContainer({
    required double width,
    required double height,
    required Color color,
  })  : _width = width,
        _height = height,
        _color = color;

  Color _color;

  double _width;
  double _height;

  Offset? _position;

  Color get color => _color;

  double get width => _width;
  double get height => _height;

  set color(Color color) {
    if (color == _color) return;

    _color = color;

    markNeedsPaint();
  }

  set width(double width) {
    if (width == _width) return;

    _width = width;

    markNeedsLayout();
  }

  set height(double height) {
    if (height == _height) return;

    _height = height;

    markNeedsLayout();
  }

  set position(Offset offset) {
    if (offset == _position) return;

    _position = offset;

    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = Size(width, height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    _position ??= offset;

    final path = _drawPath(size);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    super.paint(context, offset);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final offset = globalToLocal(_position!);

    if (size.contains(position - offset)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }

    return false;
  }

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    super.handleEvent(event, entry);

    if (event is PointerMoveEvent) {
      position = _position! + event.delta;
    }
  }

  Path _drawPath(Size size) {
    return Path()
      ..moveTo(_position!.dx, _position!.dy)
      ..lineTo(_position!.dx + width, _position!.dy)
      ..lineTo(_position!.dx + width, _position!.dy + height)
      ..lineTo(_position!.dx, _position!.dy + height)
      ..lineTo(_position!.dx, _position!.dy);
  }
}
