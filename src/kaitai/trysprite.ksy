meta:
  id: darkstone_trisprite_dat
  file-extension: dat
  encoding: utf8
  endian: le

types:
  sprite:
    seq:
      - contents: [ 1, 0 ]
      - id: name
        type: strz
        size: 32
      - id: val1
        type: u2
      - id: val2
        type: u2
      - id: val3
        type: u2
      - id: val4
        type: u2
      - id: val5
        type: u2
      - id: val6
        type: u4

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: sprites
    type: sprite
    repeat: expr
    repeat-expr: count
