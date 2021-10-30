String vertexShader = """
  #version 300 es
  
  // an attribute is an input (in) to a vertex shader.
  // It will receive data from a buffer
  in vec4 a_position;

  // A matrix to transform the positions by
  // uniform mat4 u_matrix;

  // the object matrix4
  uniform mat4 u_world;
  
  // all shaders have a main function
  void main() {
  
    // gl_Position is a special variable a vertex shader
    // is responsible for setting
    gl_Position = u_world * a_position;
  }
""";

String fragmentShader = """
  #version 300 es
  
  precision highp float;

  uniform vec4 u_colorMult;

  // we need to declare an output for the fragment shader
  out vec4 outColor;

  void main() {
    outColor = u_colorMult;
  }
""";

Map triangleShaders = {
  'vertexShader': vertexShader,
  'fragmentShader': fragmentShader,
};
