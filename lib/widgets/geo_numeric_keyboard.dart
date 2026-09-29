import 'package:flutter/material.dart';

class GeoNumericKeyboard extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onDone;

  const GeoNumericKeyboard({
    super.key,
    required this.controller,
    this.onDone,
  });

  void _append(String value) {
    controller.text += value;

    controller.selection = TextSelection.fromPosition(
      TextPosition(
        offset: controller.text.length,
      ),
    );
  }

  void _backspace() {
    if (controller.text.isEmpty) {
      return;
    }

    controller.text = controller.text.substring(
      0,
      controller.text.length - 1,
    );

    controller.selection = TextSelection.fromPosition(
      TextPosition(
        offset: controller.text.length,
      ),
    );
  }

  void _clear() {
    controller.clear();
  }

  Widget _button(
    BuildContext context,
    String text,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _iconButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Icon(
          icon,
          size: 32,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                _button(
                  context,
                  '7',
                  () => _append('7'),
                ),
                _button(
                  context,
                  '8',
                  () => _append('8'),
                ),
                _button(
                  context,
                  '9',
                  () => _append('9'),
                ),
                _iconButton(
                  context,
                  Icons.clear,
                  _clear,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                _button(
                  context,
                  '4',
                  () => _append('4'),
                ),
                _button(
                  context,
                  '5',
                  () => _append('5'),
                ),
                _button(
                  context,
                  '6',
                  () => _append('6'),
                ),
                _button(
                  context,
                  '-',
                  () => _append('-'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                _button(
                  context,
                  '1',
                  () => _append('1'),
                ),
                _button(
                  context,
                  '2',
                  () => _append('2'),
                ),
                _button(
                  context,
                  '3',
                  () => _append('3'),
                ),
                _iconButton(
                  context,
                  Icons.backspace,
                  _backspace,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                _button(
                  context,
                  ',',
                  () => _append(','),
                ),
                _button(
                  context,
                  '0',
                  () => _append('0'),
                ),
                _button(
                  context,
                  '.',
                  () => _append('.'),
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: FilledButton(
                    onPressed: onDone,
                    child: const Icon(
                      Icons.check,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}