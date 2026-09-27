import 'package:flutter/material.dart';

class PrzeniesienieReperaScreen extends StatelessWidget {
  const PrzeniesienieReperaScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Przeniesienie repera'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: const [

            Text(
              'RG1\n29.336',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              ),
            ),

            SizedBox(height: 20),

            Text(
'''
      ▲
      │ 1.483
      │

  NIWELATOR

      │ 0.692
      ▼
''',
              textAlign: TextAlign.center,
            ),

            Text(
              'RR1\n30.127',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}