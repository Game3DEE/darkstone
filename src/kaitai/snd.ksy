meta:
  id: darkstone_snd_dat
  file-extension: dat
  endian: le
  encoding: utf8

types:
  sound:
    seq:
      - contents: [ 1, 0 ]
      - id: name
        type: strz
        size: 32

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: sounds
    type: sound
    repeat: expr
    repeat-expr: count

