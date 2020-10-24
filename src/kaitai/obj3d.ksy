meta:
  id: darkstone_obj3d_dat
  file-extension: dat
  endian: le
  encoding: utf8

types:
  object3d:
    seq:
      - contents: [ 1, 0 ]
      - id: name
        type: strz
        size: 32
        doc: name of o3d file in data/common/meshes directory.

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: objects
    type: object3d
    repeat: expr
    repeat-expr: count
    
