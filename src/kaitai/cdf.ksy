meta:
  id: darkstone_cdf
  file-extension: cdf
  endian: le
  encoding: utf8

seq:
  - id: magic
    contents: [ "CDF", 0 ]
  - id: version
    type: u4
  - id: min_x
    type: u4
  - id: min_y
    type: u4
  - id: max_x
    type: u4
  - id: max_y
    type: u4
  - id: block_count
    type: u4
  - id: blocks
    type: block
    repeat: expr
    repeat-expr: block_count
  - id: map
    type: u2
    repeat: expr
    repeat-expr: map_width * map_height * 3 * 3 # Every block is divided into a 3x3 grid for object positioning
  - id: trap_count
    type: u4
  - id: traps
    type: trap
    repeat: expr
    repeat-expr: trap_count
  - id: monster_count
    type: u4
  - id: monsters
    type: monster
    repeat: expr
    repeat-expr: monster_count
    # effectively the CBS file from the Quest Maker
  - id: cbs_magic
    contents: [ "CBS", 0 ]
  - id: cbs_version
    contents: [ 1, 0, 0, 0 ]
  - id: cbs_object_count
    type: u4
  - id: cbs_objects
    type: cbs_object
    repeat: expr
    repeat-expr: cbs_object_count
instances:
  map_width:
    value: (max_x - min_x) +1
  map_height:
    value: (max_y - min_y) +1

types:
  block:
    seq:
      - id: x
        type: u4
      - id: y
        type: u4
      - id: val3
        type: u4
      - id: rotation
        type: u4
      - id: val5
        type: u4
      - id: val6
        type: u4
      - id: val7
        type: u4
      - id: val8
        type: u4
      - id: path
        type: strz
        size: 512
      - id: version
        contents: [ 1, 0, 0, 0 ]
        
  cbs_object:
    seq:
      - id: index
        type: u4
      - id: object_path
        type: strz
        size: 512

  monster:
    seq:
      - id: x
        type: u4
      - id: y
        type: u4
      - id: name
        type: strz
        size: 32
      - id: rotation
        type: u4

  trap:
    seq:
      - id: x
        type: u4
      - id: y
        type: u4
      - id: type
        type: u4
      - id: rotation
        type: u4
      - id: data
        type: s4
        repeat: expr
        repeat-expr: data_count
      - id: name
        type: strz
        size: 32
    instances:
      data_count:
        value: "_root.version <= 3 ? 13 : 21"
