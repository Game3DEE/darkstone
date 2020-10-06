meta:
  id: darkstone_mdl
  title: Darkstone MDL file
  file-extension: mdl
  endian: le
  encoding: utf8

types:
  item:
    seq:
      - id: used
        type: u2
      - id: name2
        type: strz
        size: 64
      - id: name3
        type: strz
        size: 64
        
      - id: data
        type: strz
        size: 64
        repeat: expr
        repeat-expr: 8
    

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
    
  - id: id
    type: u2
  - id: val
    type: u4
  - id: name
    type: strz
    size: 64
  - id: items
    type: item
    repeat: expr
    repeat-expr: val
