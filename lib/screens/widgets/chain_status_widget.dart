import 'package:flutter/material.dart';

class ChainStatusWidget extends StatelessWidget {
  final String status;
  const ChainStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    switch (status) {
      case 'Online':
        color = Colors.green;
        label = 'Online';
        break;
      case 'Delayed':
        color = Colors.amber;
        label = 'Delayed';
        break;
      case 'Congested':
        color = Colors.red;
        label = 'Congested';
        break;
      default:
        color = Colors.grey;
        label = status;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.circle, color: color, size: 12),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
