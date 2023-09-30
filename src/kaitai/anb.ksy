meta:
  id: anb
  file-extension: anb
  endian: le
  encoding: utf8

types:
  vector3f:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

  key_frame:
    seq:
      - id: timing
        type: u4
      - id: version
        contents: [ 1, 0 ]
      - id: euler_count
        type: u4
      - id: v1
        type: vector3f
      - id: v2
        type: vector3f
      - id: eulers
        type: vector3f
        repeat: expr
        repeat-expr: euler_count

  animation:
    seq:
    - id: version  # 1,2,3
      type: u2
    - id: name
      type: strz
      size: 64
    - id: model_name
      type: strz
      size: 64
    - id: model_type_name
      type: strz
      size: 64
    - id: bigval
      type: u4
    - id: max_timing
      type: u4
    - id: min_timing
      type: u4
    - id: val4
      type: u4
    - id: part_count
      type: u4
    - id: part_ids
      type: s2
      repeat: expr
      repeat-expr: part_count
    - id: part_names
      type: strz
      size: 64
      repeat: expr
      repeat-expr: part_count
    - id: key_frame_count
      type: u4
    - id: key_frames
      type: key_frame
      repeat: expr
      repeat-expr: key_frame_count
    - id: values
      type: u4
      repeat: expr
      repeat-expr: "(version == 3) ? 4 : 1"
      if: version > 1

seq:
  - id: magic
    contents: [ 1, 0]
  - id: animation_count
    type: u4
  - id: animations
    type: animation
    repeat: expr
    repeat-expr: animation_count
