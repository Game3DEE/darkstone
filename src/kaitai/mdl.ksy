meta:
  id: darkstone_mdl
  title: Darkstone model part list
  application: All DSI Darkstone versions
  file-extension: mdl
  license: CC0
  encoding: utf8
  endian: le
  doc: |
    This file format lists which submeshes (parts) belong to a specific model. A model in this context
    is a basic configuration of a character in the game.

types:

  bone:
    seq:
      - contents: [ 1, 0 ]
      - id: name
        type: strz
        size: 64
      - id: parent_name
        type: strz
        size: 64
      - id: attachments
        type: strz
        size: 64
        doc: empty strings for all files in Darkstone distribution
        repeat: expr
        repeat-expr: 8

  model:
    seq:
      - contents: [ 1, 0 ]
      - id: part_count
        type: u4
      - id: name
        type: strz
        size: 64
      - id: parts
        type: parts
        repeat: expr
        repeat-expr: part_count

seq:
  - contents: [ 1, 0 ]
  - id: model_count
    type: u4

  - id: models
    type: model
    repeat: expr
    repeat-expr: model_count
