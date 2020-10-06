meta:
  id: darkstone_itemsobject_dat
  file-extension: dat
  endian: le
  encoding: utf8

types:
  item:
    seq:
      - id: val1
        type: u4
      - id: val2
        type: u4
      - id: item_name
        type: strz
        size: 32
      - id: val1_2
        type: u4
      - id: val2_2
        type: u4
      - id: description_name
        type: strz
        size: 32
      - id: id_name
        type: strz
        size: 32
      - id: sval_1
        type: u2
      - id: sval_2
        type: u2
      - id: sval_3
        type: u2
      - id: sprite_name
        type: strz
        size: 32
      - id: s_val3
        type: u2
      - id: mesh_name
        type: strz
        size: 32
      - id: data_val1
        type: u4
      - id: data_val2
        type: u4
      - id: attr_dmin
        type: u2
      - id: attr_ac
        type: u2
      - id: attr_dmax
        type: u4
      - id: data1
        type: u4
      - id: data2
        type: u4
      - id: data3
        type: u4
      - id: data4
        type: u4
      - id: data5
        type: u4
      - id: data6
        type: u4
      - id: data7
        type: u4
      - id: data8
        type: u4
      - id: data9
        type: u4
      - id: data10
        type: u4
      - id: data11a
        type: u2
      - id: attr_strength 
        type: u2
      - id: attr_magic
        type: u2
      - id: attr_dexterity
        type: u2
      - id: attr_vitality
        type: u4
      - id: data14a
        type: u2
      - id: data15a
        type: u2
      - id: attr_durability
        type: u2
      - id: data16
        type: u4
      - id: data17
        type: u4
      - id: data18
        type: u4
      - id: data19
        type: u4
      - id: data20
        type: u4
      - id: data21
        type: u4
      - id: data22
        type: u4
      - id: attr_level
        type: u2
      - id: data14b
        type: u2
      - id: snd_pickup
        type: strz
        size: 32
      - id: snd_drop
        type: strz
        size: 32
      - id: snd_use
        type: strz
        size: 32
      - id: data
        size: 8

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4

  - id: items
    type: item
    repeat: expr
    repeat-expr: count
