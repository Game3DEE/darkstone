meta:
  id: darkstone_trisprite_dat
  file-extension: dat
  encoding: utf8
  endian: le

types:
  sprite:
    seq:
      - contents: [ 1, 0 ]
      - id: name
        type: strz
        size: 32
      - id: x_pos
        type: u2
      - id: y_pos
        type: u2

      #Source image from DATA\BANKDATABASE\DRAGONBLADE\
      - id: source_image_number
        type: u2

      #A collision(where the player can click) box with dimension 24x24 pixels.
      #Valid values [0x00..0x05]
      #0x00=1x1, 0x01=1x3, 0x02=2x2, 0x03=2x3, 0x04=3x3, 0x05=1x2
      - id: size_collision
        type: u2

      - id: size_sprite
        type: u2
      - id: opacity
        type: u4

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: sprites
    type: sprite
    repeat: expr
    repeat-expr: count
