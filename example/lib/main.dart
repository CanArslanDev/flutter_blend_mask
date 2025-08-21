import 'package:flutter_blend_mask/flutter_blend_mask.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BlendMaskExampleApp());
}

class BlendMaskExampleApp extends StatelessWidget {
  const BlendMaskExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlendMask Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const BlendMaskExamplePage(),
    );
  }
}

class BlendMaskExamplePage extends StatefulWidget {
  const BlendMaskExamplePage({super.key});

  @override
  State<BlendMaskExamplePage> createState() => _BlendMaskExamplePageState();
}

class _BlendMaskExamplePageState extends State<BlendMaskExamplePage> {
  BlendMode _selectedBlendMode = BlendMode.multiply;
  double _opacity = 1;

  final List<BlendMode> _blendModes = [
    BlendMode.multiply,
    BlendMode.screen,
    BlendMode.overlay,
    BlendMode.darken,
    BlendMode.lighten,
    BlendMode.colorDodge,
    BlendMode.colorBurn,
    BlendMode.hardLight,
    BlendMode.softLight,
    BlendMode.difference,
    BlendMode.exclusion,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlendMask Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BlendMask Widget Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'This example demonstrates how BlendMask enables proper '
              'BlendMode effects in Stack widgets.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),

            // Controls
            const Text(
              'Controls:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Blend Mode Selector
            const Text('Blend Mode:'),
            DropdownButton<BlendMode>(
              value: _selectedBlendMode,
              isExpanded: true,
              onChanged: (BlendMode? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedBlendMode = newValue;
                  });
                }
              },
              items: _blendModes.map<DropdownMenuItem<BlendMode>>(
                (BlendMode blendMode) {
                  return DropdownMenuItem<BlendMode>(
                    value: blendMode,
                    child: Text(blendMode.toString().split('.').last),
                  );
                },
              ).toList(),
            ),

            const SizedBox(height: 16),

            // Opacity Slider
            Text('Opacity: ${_opacity.toStringAsFixed(2)}'),
            Slider(
              value: _opacity,
              min: 0,
              max: 1,
              divisions: 20,
              onChanged: (double value) {
                setState(() {
                  _opacity = value;
                });
              },
            ),

            const SizedBox(height: 32),

            // Demo Section
            const Text(
              'Demo:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Example 1: Basic Usage
            _buildExample(
              title: 'Basic BlendMask Usage',
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    children: [
                      // Background
                      Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.purple],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      // BlendMask overlay
                      BlendMask(
                        blendMode: _selectedBlendMode,
                        opacity: _opacity,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.yellow],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Example 2: Multiple BlendMasks
            _buildExample(
              title: 'Multiple BlendMasks',
              child: Center(
                child: SizedBox(
                  width: 250,
                  height: 150,
                  child: Stack(
                    children: [
                      // Background
                      Container(
                        width: 250,
                        height: 150,
                        color: Colors.grey[300],
                      ),
                      // First circle
                      Positioned(
                        left: 50,
                        top: 25,
                        child: BlendMask(
                          blendMode: BlendMode.multiply,
                          opacity: 0.8,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      // Second circle
                      Positioned(
                        left: 100,
                        top: 25,
                        child: BlendMask(
                          blendMode: BlendMode.screen,
                          opacity: 0.8,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExample({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ],
    );
  }
}
