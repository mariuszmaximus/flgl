import 'package:flutter/material.dart';

class ExamplesPage3d extends StatefulWidget {
  const ExamplesPage3d({Key? key}) : super(key: key);

  @override
  _ExamplesPage3dState createState() => _ExamplesPage3dState();
}

class _ExamplesPage3dState extends State<ExamplesPage3d> {
  final Map<String, dynamic> _pages = {
    '1': {"name": "Example 15", "description": "OpenGLES: Orthographic 3D 1", 'route': 'example_15'},
    '2': {"name": "Example 16", "description": "OpenGLES: Orthographic 3D 2", 'route': 'example_16'},
    '3': {"name": "Example 17", "description": "OpenGLES: Orthographic 3D 3", 'route': 'example_17'},
    '4': {"name": "Example 18", "description": "OpenGLES: Orthographic 3D 4", 'route': 'example_18'},
    '5': {"name": "Example 19", "description": "OpenGLES: Orthographic 3D 5", 'route': 'example_19'},
    '6': {"name": "Example 20", "description": "OpenGLES: Orthographic 3D 6", 'route': 'example_20'},
    '7': {"name": "Example 21", "description": "OpenGLES: 3D Perspective 1", 'route': 'example_21'},
    '8': {"name": "Example 22", "description": "OpenGLES: 3D Perspective 2", 'route': 'example_22'},
    '9': {"name": "Example 23", "description": "OpenGLES: 3D Perspective 3", 'route': 'example_23'},
    '10': {"name": "Example 24", "description": "OpenGLES: 3D Perspective 4", 'route': 'example_24'},
    '11': {"name": "Example 25", "description": "OpenGLES: 3D Cameras 1", 'route': 'example_25'},
    '12': {"name": "Example 26", "description": "OpenGLES: 3D Cameras 2", 'route': 'example_26'},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D examples'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: _pages.keys.length,
          separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade300),
          itemBuilder: (BuildContext context, int index) {
            String key = _pages.keys.elementAt(index);
            var name = _pages[key]['name'];
            var route = _pages[key]['route'];
            var description = _pages[key]['description'];

            return ListTile(
              title: Text(name),
              subtitle: Text(description),
              contentPadding: const EdgeInsets.all(5.0),
              onTap: () {
                Navigator.pushNamed(context, '/3d/$route');
              },
            );
          },
        ),
      ),
    );
  }
}