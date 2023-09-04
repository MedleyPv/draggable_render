import 'package:custom_render/widgets/draggable_container/draggable_container.dart';
import 'package:custom_render/widgets/draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Draggable widgets'),
            backgroundColor: Colors.purple.shade100,
          ),
        ),
        const Positioned(
          top: 200,
          left: 120,
          child: DraggableContainer(
            width: 120.0,
            height: 60.0,
            color: Colors.red,
          ),
        ),
        Positioned(
          bottom: 200,
          left: 120,
          child: DraggableWidget(
            padding: const EdgeInsets.all(12.0),
            child: Material(
              child: Container(
                width: 120,
                height: 20,
                color: Colors.pink,
                alignment: Alignment.center,
                child: const Text(
                  'Draggable child',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
