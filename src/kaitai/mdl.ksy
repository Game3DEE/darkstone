meta:
  id: darkstone_mdl
  title: Darkstone MDL file
  file-extension: mdl
  endian: le
  encoding: utf8

types:
  item:
    seq:
      - id: used
        type: u2
      - id: name2
        type: strz
        size: 64
      - id: name3
        type: strz
        size: 64
        
      - id: data
        type: strz
        size: 64
        repeat: expr
        repeat-expr: 8


  sub_block:
    seq:
      - contents: [ 1, 0 ]
      - id: name1
        type: strz
        size: 64
      - id: name2
        type: strz
        size: 64
      - id: strings
        type: strz
        size: 64
        repeat: expr
        repeat-expr: 8
        
  block:
    seq:
      - contents: [ 1, 0 ]
      - id: count
        type: u4
      - id: name
        type: strz
        size: 64
      - id: sub_blocks
        type: sub_block
        repeat: expr
        repeat-expr: count

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4

  - id: blocks
    type: block
    repeat: expr
    repeat-expr: count

