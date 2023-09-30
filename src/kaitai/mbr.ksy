meta:
  id: darkstone_mbr
  title: Darkstone model part meshes
  application: All DSI Darkstone versions
  file-extension: mbr
  license: CC0
  endian: le
  encoding: utf8
doc: |
  This file format contains all submeshes for a particular model, including
  clothes and weapons.

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


  face:
    doc: exact same face format as in the O3D format.
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

    - id: name
      type: strz
      size: 48
      doc: unique name for submesh (matching with names in related files, e.g. bone names in MDL files)

    - id: type
      type: strz
      size: 48
      doc: identifier for type of mesh, eg. weapon, shield, bone, ....

    - id: position
      type: vector3f
      doc: absolute position of submesh in shared parent coordinates.

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
  - id: version
    contents: [ 1, 0 ]
  - id: submesh_count
    type: u4
  - id: sub_meshes
    type: submesh
    repeat: expr
    repeat-expr: submesh_count
