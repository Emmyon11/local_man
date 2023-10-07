import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_man/theme/pallete.dart';

class InfoText extends ConsumerStatefulWidget {
  final String name;
  final String value;
  const InfoText({required this.name, required this.value, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoTextState();
}

class _InfoTextState extends ConsumerState<InfoText> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: '${widget.name}: ',
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w600, color: Pallete.color4),
          children: [
            TextSpan(
                text: widget.value,
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.grey[800]))
          ]),
    );
  }
}
