meta:
  id: darkstone_o3d
  file-extension: o3d
  endian: le
  encoding: utf8

types:
  bgra:
    seq:
      - id: b
        type: u1
      - id: g
        type: u1
      - id: r
        type: u1
      - id: a
        type: u1

  vector2f:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
  
  vector3f:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

  face:
    seq:
      - id: color
        type: bgra
      - id: tex_coords
        type: vector2f
        repeat: expr
        repeat-expr: 4
      - id: indices
        type: u2
        repeat: expr
        repeat-expr: 4
      - id: flags
        type: u4
      - id: tex_number
        type: u2

seq:
  - id: vertex_count
    type: u4
  - id: face_count
    type: u4
  - id: unknown1
    type: u4
  - id: unknown2
    type: u4
  - id: vertices
    type: vector3f
    repeat: expr
    repeat-expr: vertex_count
  - id: faces
    type: face
    repeat: expr
    repeat-expr: face_count

