meta:
  id: darkstone_monsterclass_dat
  file-extension: dat
  endian: le
  encoding: utf8

types:
  monsterclass:
    seq:
      - id: version
        type: u2
        doc: valid values [1..16]
      - id: id
        type: strz
        size: 32
      - id: str_id
        type: strz
        size: 32
      - id: val1
        type: u2
      - id: level
        type: u2
      - id: level_min
        type: u4
      - id: level_max
        type: u4
      - id: ac
        type: u4
      - id: to_hit
        type: u4
      - id: damage_min
        type: u4
      - id: damage_max
        type: u4
      - id: val10
        type: u2
      - id: val11
        type: u2
      - id: val12
        type: u2
      - id: val13
        type: u4
      - id: val14
        type: u4
      - id: val15
        type: u4
      - id: val16
        type: u4
      - id: val17
        type: u4
      - id: val18
        type: u4
      - id: val19
        type: u4
      - id: val20
        type: u4
      - id: val21
        type: u4
      - id: val22
        type: u4
      - id: val23
        type: u4
      - id: val24
        type: u4
      - id: model
        type: strz
        size: 64
      - id: val25
        type: u4
      - id: val26
        type: u2
      - id: val27
        type: u2
      - id: val28
        type: u4
      - id: val29
        type: u4
      - id: val30
        type: u4
      - id: val31
        type: f4
      - id: val32
        type: u4
      - id: val33
        type: u4
      - id: val34
        type: u4
      - id: val35
        type: u4
      - id: string
        type: strz
        size: 32
      - id: val36
        type: u4
      - id: val37
        type: u4
      - id: val38
        type: u4
      - id: string2
        type: strz
        size: 32
      - id: val39
        type: u4
      - id: val40
        type: u4
      - id: val41
        size: 8
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
      - id: val42
        type: u4
      - id: val43
        type: u4
      - id: val44
        type: u4
      - id: val45
        type: u4
      - id: val46
        size: 8
      - id: val47
        type: u4
      - id: val48
        type: u4
      - id: val49
        size: 16

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: classes
    type: monsterclass
    repeat: expr
    repeat-expr: count
