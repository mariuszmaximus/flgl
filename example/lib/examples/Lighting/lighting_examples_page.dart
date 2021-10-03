import 'package:flutter/material.dart';

class LightingExamplesPage extends StatefulWidget {
  const LightingExamplesPage({Key? key}) : super(key: key);

  @override
  _LightingExamplesPageState createState() => _LightingExamplesPageState();
}

class _LightingExamplesPageState extends State<LightingExamplesPage> {
  final Map<String, dynamic> _pages = {
    '1': {
      "name": "3D Directional Lighting 1",
      "description": "Example using directional lighting 1",
      "route": 'directional_lighting_1',
    },
    '2': {
      "name": "3D Directional Lighting 2",
      "description": "Example using directional lighting 2",
      "route": 'directional_lighting_2',
    },
    '3': {
      "name": "3D Directional Lighting 3",
      "description": "Example using directional lighting 3",
      "route": 'directional_lighting_3',
    },
    '4': {
      "name": "3D Point Lighting 1",
      "description": "Example using point lighting 1",
      "route": 'point_light_1',
    },
    '5': {
      "name": "3D Point Lighting 2",
      "description": "Example using point lighting with specular highlighting",
      "route": 'point_light_2',
    },
    '6': {
      "name": "3D Point Lighting 3",
      "description": "Example using point lighting with specular highlighting and shininess",
      "route": 'point_light_3',
    },
    '7': {
      "name": "3D Point Lighting 4",
      "description": "Example using point lighting with specular highlighting and shininess and light color",
      "route": 'point_light_4',
    },
    '8': {
      "name": "3D Spot Lighting 1",
      "description": "Example using spot lighting",
      "route": 'spot_light_1',
    },
    '9': {
      "name": "3D Spot Lighting 2",
      "description": "Example using spot lighting",
      "route": 'spot_light_2',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fundamentals examples'),
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
                Navigator.pushNamed(context, '/lighting/$route');
              },
            );
          },
        ),
      ),
    );
  }
}