meta:
  id: darkstone_mdl
  title: Darkstone Model Hierarchy
  application: All DSI Darkstone versions
  file-extension: mdl
  endian: le
  encoding: utf8

types:

  bone:
    seq:
      - contents: [ 1, 0 ]
      - id: name
        type: strz
        size: 64
      - id: parent_name
        type: strz
        size: 64
      - id: attachments
        type: strz
        size: 64
        doc: empty strings for all files in Darkstone distribution
        repeat: expr
        repeat-expr: 8

  skeleton:
    seq:
      - contents: [ 1, 0 ]
      - id: bone_count
        type: u4
      - id: name
        type: strz
        size: 64
      - id: bones
        type: bone
        repeat: expr
        repeat-expr: bone_count

seq:
  - contents: [ 1, 0 ]
  - id: skeleton_count
    type: u4

  - id: skeletons
    type: skeleton
    repeat: expr
    repeat-expr: skeleton_count
