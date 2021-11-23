import 'dart:async';

import 'package:flgl/flgl.dart';
import 'package:flgl/flgl_3d.dart';
import 'package:flgl/flgl_viewport.dart';
import 'package:flgl/openGL/contexts/open_gl_context_es.dart';
import 'package:flgl_example/examples/controls/flgl_controls.dart';
import 'package:flutter/material.dart';

class NeonQuadExample2 extends StatefulWidget {
  const NeonQuadExample2({Key? key}) : super(key: key);

  @override
  _NeonQuadExample2State createState() => _NeonQuadExample2State();
}

class _NeonQuadExample2State extends State<NeonQuadExample2> {
  /// Set this to true when the FLGLViewport initialized.
  bool initialized = false;

  /// The flutter graphics library instance.
  late Flgl flgl;

  /// The OpenGL context.
  late OpenGLContextES gl;

  /// The viewport width.
  double width = 0.0;

  /// The viewport height.
  double height = 0.0;

  /// The device pixel ratio.
  double dpr = 1.0;

  /// The timer for the render loop.
  Timer? timer;

  /// dummy var for red color.
  double r = 0;

  // new stuff
  // late VertexArray va;
  // late VertexBuffer vb;
  // late BufferLayout layout;
  // late IndexBuffer ib;
  // late Shader shader;

  late NeonMesh mesh;
  late NeonRenderer neonRenderer;

  NeonScene scene = NeonScene();
  late PerspectiveCamera perspectiveCamera;
  late OrthographicCamera orthographicCamera;
  Camera? activeCamera;


  List<bool> isSelected = [false, true];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Draw 50 frames per second.
  void startRenderLoop() {
    timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (Timer t) => {
        if (!flgl.isDisposed)
          {
            render(),
          }
      },
    );
  }

  Widget cameraToggleButtonMenu(List<bool> isSelected) {
    return ToggleButtons(
      color: Colors.red,
      children: const <Widget>[
        // Icon(Icons.videocam_outlined),
        TextButton(
          child: Text('Orthographic', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          onPressed: null,
        ),
        TextButton(
          child: Text('Perspective', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          onPressed: null,
        )
      ],
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = !isSelected[buttonIndex];
            } else {
              isSelected[buttonIndex] = false;
            }
          }

          // set camera
          if (isSelected[0]) {
            activeCamera = orthographicCamera;
          } else {
            activeCamera = perspectiveCamera;
          }
        });
      },
      isSelected: isSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    dpr = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Neon: Quad 2"),
      ),
      body: Stack(
        children: [
          FLGLViewport(
            width: width.toInt() + 1,
            height: height.toInt(),
            onInit: (Flgl _flgl) {
              setState(() {
                initialized = true;
                flgl = _flgl;
                gl = flgl.gl;

                initScene();
                startRenderLoop();
              });
            },
          ),
          if (activeCamera != null && scene != null)
            Positioned(
              width: 420,
              top: 10,
              right: 10,
              child: FLGLControls(camera: activeCamera!, scene: scene),
            ),

          // Positioned(
          //   top: 10,
          //   child: TextButton(
          //     child: const Text('2D'),
          //     onPressed: () {/* ... */},
          //   ),
          // ),
          // Positioned(
          //   top: 10,
          //   left: 120,
          //   child: TextButton(
          //     child: const Text('3D'),
          //     onPressed: () {/* ... */},
          //   ),
          // ),
          Positioned(
            top: 10,
            left: 10,
            child: cameraToggleButtonMenu(isSelected),
          ),
        ],
      ),
    );
  }

  /// Initialize's the scene.
  initScene() {
    var aspect = dpr; // 1.5
    orthographicCamera = OrthographicCamera((width * aspect) / -2, (width * aspect) / 2, (height * aspect) / -2, (height * aspect) / 2, -1, 1000);
    orthographicCamera.name = 'OrthographicCamera';
    orthographicCamera.setPosition(Vector3(0, 0, 100));

    perspectiveCamera = PerspectiveCamera(45, (width * flgl.dpr) / (height * flgl.dpr), 1, 2000);
    perspectiveCamera.name = 'PerspectiveCamera';
    perspectiveCamera.setPosition(Vector3(0, 0, 300));



    var geometry = NeonQuadGeometry();
    var material = NeonMeshBasicMaterial(color: Color(0, 1, 1, 1));
    var mesh = NeonMesh(gl, geometry, material);
    mesh.name = 'Quad';
    mesh.setScale(Vector3(100, 100, 1));

    scene.add(mesh);

    neonRenderer = NeonRenderer(flgl, gl);
    neonRenderer.width = width;
    neonRenderer.height = height;
    neonRenderer.dpr = dpr;
    neonRenderer.init();


    activeCamera = perspectiveCamera;
  }

  render() {
    if (neonRenderer != null && scene != null && activeCamera != null) {
      neonRenderer.render(scene, activeCamera!);
    }
  }
}

