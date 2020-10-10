meta:
  id: darkstone_ska
  file-extension: ska
  endian: le
  encoding: utf8

types:
  block:
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
        repeat-expr: 64

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: blocks
    type: block
    repeat: expr
    repeat-expr: count
