meta:
  id: darkstone_itemsobject_dat
  file-extension: dat
  endian: le
  encoding: utf8

types:
  item:
    seq:
      - id: version
        type: u2
        doc: valid values [1..16]
      - id: data0
        type: u4
      - id: data1
        type: u2
      
      #Item id in DS Quest Editor.
      - id: id_dsqe
        type: strz
        size: 32
        
      - id: data2
        type: u4
      - id: data3
        type: u4
        
      #Item name in game.
      - id: id_in_game_name
        type: strz
        size: 32
        
      #Item name in game if the item is unidentified
      - id: id_in_game_name_unidentified
        type: strz
        size: 32
        
      #Change what Member (equipment slot) the item will be using.
      #DATA\PCLASS\WCLASS.TXT
      #0x00 = Unequippable
      #0x01 = 1-Handed Weapons  [weaponMember, bouclerMember]
      #0x02 = 2-Handed Weapons  [weaponMember]
      #0x03 = Chest Armour      [armorMember]
      #0x04 = Helmet            [capMember]
      #0x05 = Ring
      #0x06 = Amulet
      #0x07 = Ambidextrous items (like a torch)
      - id: equipment_member
        type: u2
        
      #Item type.
      #DATA\PCLASS\WCLASS.TXT
      #0x00 = Amulet/Ring
      #0x01 = Weapon           [weaponMember]
      #0x02 = Shield/Armour    [armorMember, bouclerMember, capMember]
      #0x03 = Gold
      - id: equipment_type
        type: u2
        
      #Sprite index in DATA\TRISPRITE.DAT
      #The game will overwrite this with the correct sprite index at startup.
      - id: sprite_index
        type: u2
        
      #Item sprite used in DS Quest Editor / Game.
      #Gets the name from DATA\TRISPRITE.DAT
      - id: sprite_name
        type: strz
        size: 32
        
      #Mesh index in DATA\OBJ3D.DAT
      #The game will overwrite this with the correct mesh index at startup.
      - id: mesh_index
        type: u2
        
      #Item mesh used in game.
      #Gets the name from DATA\OBJ3D.DAT
      - id: mesh_name
        type: strz
        size: 32
      
      #Food. The amount of "Food" an item will give if you eat it.
      #(Probably for something else too).
      - id: food_and_unknown
        type: u4
      
      #Item static price in shop and the amount of gold in a gold stack.
      #Only for items with static price, e.g Food and Potions.
      - id: price_static
        type: u4
        
      - id: attr_dmg_min
        type: u2
      - id: attr_ac
        type: u2
      - id: attr_dmg_max
        type: u2
        
      #Weapon Enchantment 1.
      #0x00 = Off
      #0x01 = Poison
      #0x02 = Fire Element
      #0x03 = Vampire
      #0x04 = Magic Missiles
      #0x05 = Storm
      #0x06 = Stone Curse
      #0x07 = Touch of Confusion.
      - id: enchantment1_weapon
        type: u2
        
      #Weapon Enchantment 2.
      #Bit 0 = Push Target Back
      #Bit 1 = Fast Attack
      #Bit 2 = Faster Attack
      #Bit 3 = Fastest Attack, Read note.
      #Bit 4 = Recovery Time Improved
      #Bit 5 = Quick Recovery, If bit 4 is set then use "Recovery Time Improved" instead.
      #Bit 6..7 = NULL
      #Note: The game will always use the slowest attack speed that's set.
      #      1000 = Fastest Attack, 1100 = Faster Attack, 1110 = Fast Attack
      - id: enchantment2_weapon
        type: u2
      
      - id: data6
        type: u2
      
      #+%Damage. Only works on weapons.
      - id: attr_dmg_pct
        type: u2
        
      #+% to hit.
      - id: attr_to_hit
        type: u2
        
      #+% Armour.
      - id: attr_ac_pct
        type: u2
        
      #Item Enchantment / Curse / Usable items(Right Click) / (Quest Items?)
      #Read: §1 for more info.
      - id: enchantment3
        type: u2
        
      #Gives item a Spell / Skill.
      #Read: §2 for more info.
      - id: enchantment4_spell_skill
        type: u2
        
      #+x to Strength.
      - id: attr_strength
        type: u2
      
      #+x to Magic.
      - id: attr_magic
        type: u2
        
      #+x to Dexterity.
      - id: attr_dexterity
        type: u2
        
      #+x to Vitality.
      - id: attr_vitality
        type: u2
        
      #+% Fire resistance.
      - id: attr_resist_fire
        type: u2
        
      #+% Poison resistance.
      - id: attr_resist_poison
        type: u2
        
      #+% Magic resistance.
      - id: attr_resist_magic
        type: u2
        
      #+x to Mana.
      - id: attr_mana
        type: u2
        
      #+x to Life.
      - id: attr_life
        type: u2
        
      #+% Light Radius.
      #Don't know what this does in game.
      - id: attr_light_radius
        type: u2
        
      #Adds x-0 damage points.
      - id: attr_add_dmg_min
        type: u2
        
      #Adds 0-x damage points.
      - id: attr_add_dmg_max
        type: u2
        
      - id: data7
        type: u2
      - id: data8
        type: u2
        
      #Required strength.
      - id: req_strength
        type: u2
        
      #Required magic.
      - id: req_magic
        type: u2
        
      #Required dexterity.
      - id: req_dexterity
        type: u2
        
      #Required vitality.
      - id: req_vitality
        type: u2
        
      #Item enchanted with a spell, Mana: x/0.
      #Variable "enchantment4_spell_skill" need to be 0x01 or higher.
      - id: spell_mana_current
        type: u2
        
      #Item enchanted with a spell, Mana: 0/x.
      #Variable "enchantment4_spell_skill" need to be 0x01 or higher.
      - id: spell_mana_max
        type: u2
        
      - id: data9
        type: u2
        
      #Item durability: 0/x.
      - id: durability_max
        type: u2
        
      #Item is identified flag.
      #0 = unidentified, 1 = identified.
      #Gets cleared at startup.
      - id: b_identified
        type: u4
        
      #Enable "Cursed Item" mode for armour and weapons.
      - id: b_cursed
        type: u4
        
      - id: data11
        type: u4
      - id: data12
        type: u4
        
      #Equipped equipment will be using this mesh/piece.
      #DATA\PCLASS\WCLASS.TXT
      #e.g. The torch (ITEM_TORCHE) will have the values of:
      #equipment_type = 0x01 --> [weaponMember]
      #equipment_mesh = 0x08 --> [torche]
      #
      #Maximum number of pieces in each member group:
      #  armorMember:    0x1F
      #  weaponMember:   0x3F
      #  capMember:      0x23
      #  bouclerMember:  0x1F
      - id: equipment_mesh
        type: u2
        
      #What skeleton the item animations will be using.
      #DATA\PCLASS\WCLASS.TXT --> weaponKindName
      #e.g. If the item is a torch held in right hand then it will be using
      #weaponKindName --> torche and this variable will have the value 0x07.
      - id: weapon_kind
        type: u2
        
      - id: data13
        type: u4
        
      #Read: §3 for more info.
      - id: data14
        type: u4
        
      #Drop level.
      #Delay when the item will be available in the shop.
      #The items identification price in Madame Irma's shop might be based on this.
      - id: level
        type: u4
        
      - id: snd_pickup
        type: strz
        size: 32
      - id: snd_drop
        type: strz
        size: 32
      - id: snd_use
        type: strz
        size: 32
        
      - id: data15
        type: u4
      - id: data16
        type: u4
      - id: data17
        type: u4

seq:
  - contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: items
    type: item
    repeat: expr
    repeat-expr: count

#_______________________________________________________________________________
#§1 |
#___|
#
#0x02 = Healing Potion
#0x04 = Mana Potion
#0x05 = Elixir of Strength
#0x06 = Elixir of Magic
#0x07 = Elixir of Dexterity
#0x09 = Elixir of Youth
#0x0A = Scroll(Spell:enchantment4_spell_skill(Offset D4-D5))
#0x0B = The Time Orb
#0x0C = Elixir of Vitality
#0x0D = Vial of Poison
#0x0E = Antidote Potion
#0x0F = Potion of Surprise
#0x24 = Old Age
#0x25 = Unease
#0x26 = Slow Motion
#0x27 = Bulimia
#0x28 = Abundance
#0x29 = Life Recovery
#0x2A = Quick Mana Recovery
#0x2B = Poison's Effects Slowed Down
#0x2C = Light Aura
#0x2D = Leaking Pockets(equipped)
#0x2E = Spell Duration Increased
#0x2F = Permenant Perception
#0x30 = Mana Shield
#0x31 = Eternal Youth
#0x32 = ??
#0x33 = Use Spell Book
#0x34 = ??
#0x35 = ??
#0x38 = Chicken Leg(Horn of Plenty)
#0x39 = Empty Scroll(Right click to attach spell)
#0x3A = Concentration Rune/(ITEM_RUNFIXATION) Behavior
#0x3B = Food
#_______________________________________________________________________________
#§2 |
#___|
#
#[Spells]
#0x01 = Confusion
#0x02 = Healing
#0x03 = Fear
#0x04 = Thunder
#0x05 = Slowness
#0x06 = Wall of Fire
#0x07 = Mutation
#0x08 = Stone
#0x09 = Night Vision
#0x0A = Haste
#0x0B = Magic Missile
#0x0C = Fire Ball
#0x0D = Absorption
#0x0E = Antidote
#0x0F = Flame Thrower
#0x10 = Storm
#0x11 = Invisibility
#0x12 = Death Dome
#0x13 = Invocation
#0x14 = Spark
#0x15 = Teleportation
#0x16 = Detection
#0x17 = Food
#0x18 = Berserker
#0x19 = Forgetfulness
#0x1A = Reflection
#0x1B = Magic Bomb
#0x1C = Magic Door
#0x1D = Poison Cloud
#0x1E = Resurrection
#0x1F = Telekinesis
#0x20 = Light
#
#[Skills]
#0x21 = Identification
#0x22 = Trade
#0x23 = Repair
#0x24 = Perception
#0x25 = Defusing
#0x26 = Forester
#0x27 = Learning
#0x28 = Theft
#0x29 = Silence
#0x2A = Meditation
#0x2B = Concentration
#0x2C = Orientation
#0x2D = Medicine
#0x2E = Recharging
#0x2F = Exorcism
#0x30 = Prayer
#0x31 = Detection
#0x32 = Master of Arms
#0x33 = Communion
#0x35 = Language
#0x36 = Lycanthropy
#_______________________________________________________________________________
#§3 |
#___|
#
#BYTE 0 = Shop / Quest item / ?? [
#  0x00 = Hide in Shop / DS Editor
#  bit 0 = Gunther The Blacksmith
#  bit 1 = Master Elmeric
#  bit 2 = Perry The Publican
#  bit 3 = ?? (Might have something to do with quest items)
#  bit 4 = ??
#  bit 5 = Quest Item Behavior. Bit0..2 will be ignored.
#  bit 6 = ??
#  bit 7 = ??
#]
#
#BYTE 1 = ?? [
#  bit 0 = Larsac The Usurer shop (unused)
#  bit 1..6 = ??
#  bit 7 = Item will not despawn from shop after 16 levels visited over item level.
#]
#
#BYTE 2 = Gunther The Blacksmith: Shop category [
#  Note: Byte 0 need to have value 0x01..0x07.
#  0x00 = Hide in Shop
#  bit 0 = Wizard
#  bit 1 = Thief
#  bit 2 = Warrior
#  bit 3 = Priest
#  bit 4..7 = (NULL?)
#]
#
#BYTE 3 = ?? []
