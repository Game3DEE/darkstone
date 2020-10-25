meta:
  id: darkstone_ska
  title: Darkstone skeleton list
  application: All DSI Darkstone versions
  file-extension: ska
  license: CC0
  encoding: utf8
  endian: le
doc: |
  This file format lists which bones form a skeleton as used in the animations
  in the game.

types:
  skeleton:
    seq:
      - contents: [ 1, 0 ]
      - id: name
        type: strz
        size: 64
      - id: model_name
        type: strz
        size: 64
      - id: bones
        type: strz
        size: 64
        repeat: expr
        repeat-expr: 64

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: skeletons
    type: skeleton
    repeat: expr
    repeat-expr: count
