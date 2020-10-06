meta:
  id: darkstone_monsterclass_dat
  file-extension: dat
  endian: le
  encoding: utf8

types:
  monsterclass:
    seq:
      - id: val
        type: u2
      - id: name
        type: strz
        size: 32
      - id: text_name
        type: strz
        size: 32
      - id: data
        size: 82
      - id: string
        type: strz
        size: 64
      - id: data2
        size: 132
      - id: sound_attack
        type: strz
        size: 32
      - id: sound_die
        type: strz
        size: 32
      - id: sound_3
        type: strz
        size: 32
      - id: sound_4
        type: strz
        size: 32
      - id: sound_hit
        type: strz
        size: 32
      - id: sound_6
        type: strz
        size: 32
      - id: data3
        size: 48

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: classes
    type: monsterclass
    repeat: expr
    repeat-expr: count
