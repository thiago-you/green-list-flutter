import 'package:flutter/cupertino.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const InfoRow({super.key, required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold
          )
        ),
        Flexible(
          child: Text(
            value ?? "",
            style: const TextStyle(fontSize: 16.0)
          ),
        ),
      ],
    );
  }
}