meta:
  id: darkstone_anb
  title: Darkstone ANB file
  file-extension: anb
  endian: le
  encoding: utf8

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: items
    type: item
    repeat: expr
    repeat-exir: count

types:
  item:
    seq:
      - id: short # [0..3]
        type: u2
      - id: name1
        type: strz
        size: 64
      - id: name2
        type: strz
        size: 64
      - id: name3
        type: strz
        size: 64
      - id: val1
        type: u4
      - id: val2
        type: u4
      - id: val3
        type: u4
      - id: val4
        type: u4
      - id: val4
        type: u4
      - id: data
        size: val4 * 2
