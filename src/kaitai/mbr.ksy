meta:
  id: darkstone_mbr
  file-extension: mbr
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

  vector3f:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

  vector2f:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4


  # Same structure as in O3D file
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

  submesh:
    seq:
    - id: version
      type: u2

    - id: name1
      type: strz
      size: 48

    - id: name2
      type: strz
      size: 48

    - id: position
      type: vector3f
    - id: v8
      type: vector3f
      repeat: expr
      repeat-expr: 8

    - id: vertex_count
      type: u4
    - id: face_count
      type: u4

    - id: vertices
      type: vector3f
      repeat: expr
      repeat-expr: vertex_count

    - id: faces
      type: face
      repeat: expr
      repeat-expr: face_count

    - id: vertex_values
      type: u4
      repeat: expr
      repeat-expr: vertex_count

    - id: face_count2
      type: u4
      if: version == 2

    - id: faces2
      type: face
      repeat: expr
      repeat-expr: face_count2
      if: version == 2

    - id: unknown
      size: 10
      repeat: expr
      repeat-expr: face_count2
      if: version == 2

    - id: v2_vec1
      type: vector3f
      if: version == 2
    - id: v2_vec2
      type: vector3f
      if: version == 2

seq:
  - contents: [ 1, 0 ]
  - id: submesh_count
    type: u4
  - id: sub_meshes
    type: submesh
    repeat: expr
    repeat-expr: submesh_count
