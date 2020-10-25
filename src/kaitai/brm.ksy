meta:
  id: darkstone_brm
  file-extension: brm
  endian: le
  encoding: utf8

seq:
  - id: count
    type: u4
  - id: blocks
    type: block
    repeat: expr
    repeat-expr: count

types:
  block:
    seq:
      - contents: [ "INS", 0 ]
      - id: zero4
        type: u4
      - id: name
        type: strz
        size: 60
      - id: float3
        type: f4
        repeat: expr
        repeat-expr: 3
      - id: block_end
        type: u4
