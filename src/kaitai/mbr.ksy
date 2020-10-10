meta:
  id: darkstone_mbr
  file-extension: mbr
  endian: le
  encoding: utf8

types:
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

  short5:
    seq:
      - id: shorts
        type: u2
        repeat: expr
        repeat-expr: 5

  face:
    seq:
      - id: color
        type: u1
        repeat: expr
        repeat-expr: 4

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

    - id: names
      type: strz
      size: 48
      repeat: expr
      repeat-expr: 2

    - id: floats9x3
      type: f4
      repeat: expr
      repeat-expr: 9 * 3

    - id: count_vertices
      type: u4

    - id: count_faces
      type: u4

    - id: vertices
      type: vector3f
      repeat: expr
      repeat-expr: count_vertices

    - id: faces
      type: face
      repeat: expr
      repeat-expr: count_faces

    - id: triplet_int # texture references for polygons?
      type: u4
      repeat: expr
      repeat-expr: count_vertices

    - id: count_float
      type: u4
      if: version == 2

    - id: float_8
      type: face
      repeat: expr
      repeat-expr: count_float
      if: count_float > 0

    - id: short_5
      type: short5
      repeat: expr
      repeat-expr: count_float
      if: count_float > 0

    - id: float_6
      type: f4
      repeat: expr
      repeat-expr: 6

seq:
  - contents: [ 1, 0 ]
  - id: submesh_count
    type: u4
  - id: submeshes
    type: submesh
    repeat: expr
    repeat-expr: submesh_count
