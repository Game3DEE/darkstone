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
        
      #The level where the dropped item is located.
      - id: pos_level
        type: u2
      
      #Item id in DS Quest Editor.
      - id: id_dsqe
        type: strz
        size: 32
        
      #Item's drop X-position (East / West)
      #Item's X-position in player's inventory grid.
      - id: pos_x
        type: u4
        
      #Item's drop Z-position (North / South)
      #Item's Y-position in player's inventory grid.
      - id: pos_z
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
        type: s2
        
      #Item sprite used in DS Quest Editor / Game.
      #Gets the name from DATA\TRISPRITE.DAT
      - id: sprite_name
        type: strz
        size: 32
        
      #Mesh index in DATA\OBJ3D.DAT
      #The game will overwrite this with the correct mesh index at startup.
      - id: mesh_index
        type: s2
        
      #Item mesh used in game.
      #Gets the name from DATA\OBJ3D.DAT
      - id: mesh_name
        type: strz
        size: 32
      
      #Item base price is based on the item's basic stats.
      #Used to calculate the sell price for unidentified items.
      #The amount of "Food" an item will give if it's eaten.
      #
      #Weapon:
      #  v1 = 3 * Item->attrDmgMax + 2 * Item->attrDmgMin;
      #  basePrice = Item->durabilityMax * v1 * 0.75);
      #Shield/Armour:
      #  basePrice = Item->durabilityMax * (4 * Item->attrAc) * 0.75);
      - id: base_price_and_food
        type: s4
        
      #Item price in shop and the amount of gold in a gold stack.
      - id: price
        type: s4
        
      - id: attr_dmg_min
        type: s2
      - id: attr_ac
        type: s2
      - id: attr_dmg_max
        type: s2
        
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
        type: s2
        
      #+% to hit.
      - id: attr_to_hit
        type: s2
        
      #+% Armour.
      - id: attr_ac_pct
        type: s2
        
      #Item Enchantment: Usable items(Right Click) / Bless / Curse / Object class.
      #Read: §1 for more info.
      - id: enchantment3_magic
        type: u2
        
      #Gives item a Spell / Skill.
      #Read: §2 for more info.
      - id: enchantment4_spell_skill
        type: u2
        
      #+x to Strength.
      - id: attr_strength
        type: s2
      
      #+x to Magic.
      - id: attr_magic
        type: s2
        
      #+x to Dexterity.
      - id: attr_dexterity
        type: s2
        
      #+x to Vitality.
      - id: attr_vitality
        type: s2
        
      #+% Fire resistance.
      - id: attr_resist_fire
        type: s2
        
      #+% Poison resistance.
      - id: attr_resist_poison
        type: s2
        
      #+% Magic resistance.
      - id: attr_resist_magic
        type: s2
        
      #+x to Mana.
      - id: attr_mana
        type: s2
        
      #+x to Life.
      - id: attr_life
        type: s2
        
      #+% Light Radius.
      #Don't know what this does in game.
      - id: attr_light_radius
        type: s2
        
      #Adds x-0 damage points.
      - id: attr_add_dmg_min
        type: s2
        
      #Adds 0-x damage points.
      - id: attr_add_dmg_max
        type: s2
        
      #Item is found by being picked up or identified.
      #Quest / TownQuest items only.
      - id: b_found
        type: u2
        
      #Link items in inventory that is identical to the item held in belt.
      #0          = Not in inventory/belt
      #-1         = Inventory
      #0x3A..0x3D = Belt[0..3]
      - id: corresponding_belt_index
        type: s2
        
      #Required strength.
      - id: req_strength
        type: s2
        
      #Required magic.
      - id: req_magic
        type: s2
        
      #Required dexterity.
      - id: req_dexterity
        type: s2
        
      #Required vitality.
      - id: req_vitality
        type: s2
        
      #Item enchanted with a spell, Mana: x/0.
      #Variable "enchantment4_spell_skill" need to be 0x01 or higher.
      - id: spell_mana_current
        type: s2
        
      #Item enchanted with a spell, Mana: 0/x.
      #Variable "enchantment4_spell_skill" need to be 0x01 or higher.
      - id: spell_mana_max
        type: s2
        
      - id: data9
        type: u2
        
      #Item durability: 0/x.
      - id: durability_max
        type: s2
        
      #Item is identified flag.
      #0 = unidentified, 1 = identified.
      #Gets cleared at startup.
      - id: b_identified
        type: u4
        
      #Enable "Cursed Item" mode for armour and weapons.
      - id: b_cursed
        type: u4
        
      #Makes the color for items info text in the description box darker red to
      #indicate that it has good enchantments.
      #Items are limited to 2 enchantments per item. (Improved durability
      #doesn't count as an enchantment.)
      #If the item has got improved attributes/stats, then this bool indicates
      #that it also has an extra bonus added ontop of it.
      #(Some items have this set to true without any enchantments/improvements.)
      - id: b_has_good_enchantment
        type: u4
        
      #Makes the color for items info text in the description box light red.
      #Pulsating glow effect in shop.
      #Can be detected with the "Detection" spell/skill.
      #Item has got improved attributes/stats. (Improved durability isn't included.)
      #(Some items have this set to true without any enchantments/improvements.)
      - id: b_emphasize
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
        
      #Item's drop Y-position (Elevation)
      #Item's respawn time(ms) in shop after purchase.
      #RespawnTime = Item->Price (min/max: 200.0f..5000.0f)
      - id: pos_y
        type: f4
        
      #Read: §3 for more info.
      - id: data14
        type: u4
        
      #Drop level.
      #Delay when the item will be available in the shop.
      #The items identification price in Madame Irma's shop might be based on this.
      - id: level
        type: s4
        
      - id: snd_pickup
        type: strz
        size: 32
      - id: snd_drop
        type: strz
        size: 32
      - id: snd_use
        type: strz
        size: 32
        
      #Item durability: x/0.
      - id: durability_cur
        type: f4
        
      - id: data16
        type: u4
        
      #An unique ID for the specific item.
      #Item->uniqueID = i + timeGetTime(); return ++i;
      - id: unique_id
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
#Note: The keyword between the curly brackets are used by the .SPT/.DSM scripts to get/set the respective bit.
#      Script(get): TRAP { STATE { MULTI { CONDITION { SENSEOBJMAGIC {KEYWORD}}}}}
#      Script(set): QUEST { OBJECT { MAGIC {KEYWORD}}}
#
#[Magical items] (Items that can be added to player's quick belt)
#0x01 = Full Healing Potion  { POTION_FULL_HEALING }
#0x02 = Healing Potion       { POTION_HEALING }
#0x03 = Full Mana Potion     { POTION_FULL_MANA }
#0x04 = Mana Potion          { POTION_MANA }
#0x05 = Elixir of Strength   { ELIXIR_STRENGTH }
#0x06 = Elixir of Magic      { ELIXIR_MAGIC }
#0x07 = Elixir of Dexterity  { ELIXIR_DEXTERITY }
#0x08 = Full Elixir of Youth { POTION_FULL_REJUV }
#0x09 = Elixir of Youth      { POTION_REJUV }
#0x0A = Scroll(Spell:enchantment4_spell_skill(Offset D4-D5)). { SCROLL }
#0x0B = The Time Orb         { SPECIAL1 }
#0x0C = Elixir of Vitality   { ELIXIR_VITALITY }
#0x0D = Vial of Poison       { POTION_POISON }
#0x0E = Antidote Potion      { POTION_ANTIPOISON }
#0x0F = Potion of Surprise   { POTION_SURPRISE }
#
#[Bless / Curse]
#0x24 = Old Age
#0x25 = Unease
#0x26 = Slow Motion
#0x27 = Bulimia
#0x28 = Abundance
#0x29 = Life Recovery
#0x2A = Quick Mana Recovery
#0x2B = Poison's Effects Slowed Down
#0x2C = Light Aura
#0x2D = Leaking Pockets
#0x2E = Spell Duration Increased
#0x2F = Permenant Perception
#0x30 = Mana Shield
#0x31 = Eternal Youth
#
#[Object Class]
#0x32 = STAFF     { STAFF }
#0x33 = SpellBook { BOOK }
#0x34 = RING      { RING }
#0x35 = AMULET    { AMULET }
#0x36 = SPELL     { SPELL }
#0x38 = Chicken Leg(Horn of Plenty)               { ABONDANCE }
#0x39 = Empty Scroll(Right click to attach spell) { PARCHEMIN }
#0x3A = Concentration Rune/(ITEM_RUNFIXATION)     { FIXATION }
#0x3B = Food      { FOOD }
#0x3C = Letter    { LETTER }
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
#0x33 = Communion (Priestess) [NATURE]
#0x34 = Communion (Sorceress) [ELEMENT]
#0x35 = Language
#0x36 = Lycanthropy
#
#[Misc]
#0x37 = Concentration Rune [RUNEFIXATION]
#_______________________________________________________________________________
#§3 |
#___|
#
#Note: The keyword between the curly brackets are used by the .SPT scripts to set the respective bit.
#      Script: QUEST { OBJECT { FLAG {KEYWORD}}}
#
#BYTE 0 = Shop / Quest item [
#  0x00 = Hide in Shop / DS Editor
#  bit 0 = Gunther The Blacksmith { STORE_FORGERON }
#  bit 1 = Master Elmeric         { FLAG_STORE_MAGICIEN }
#  bit 2 = Perry The Publican     { STORE_TAVERNE }
#  bit 3 = Custom Object          { CUSTOM }
#  bit 4 = Virtual Object         { VIRTUAL }
#  bit 5 = Quest Object           { QUEST }
#  bit 6 = ??                     { FEMININ }
#  bit 7 = Town Quest Object
#]
#
#BYTE 1 = Shop / Drop [
#  bit 0 = Larsac The Usurer shop (unused)
#  bit 1 = ??
#  bit 2 = Item tier: Normal                { GIVE_NORMAL }
#  bit 3 = Item tier: Good                  { GIVE_GOOD }
#  bit 4 = Item tier: Extra                 { GIVE_EXTRA }
#  bit 5 = Item tier: Magic [BookStand]     { GIVE_MAGIC }
#  bit 6 = Generate enchantments (See note) { GENERATE }
#  bit 7 = Item will not despawn from shop after 16 levels visited over item level. { APPEAR }
#
#Note:
#  Allow random enchantments to be generated on the item.
#  If Bit7=1 then Bit6 will be set to 0 (only for items in shop).
#  Bit6:0 = Item can't be enchanted but will respawn in shop after purchase.
#           See Item->posY for info about the respawn time.
#  Bit6:1 = Item can be enchanted but won't respawn in shop after purchase
#           until the shop rerolls all its items (player enters a new dungeon).
#           If the shop item doesn't get enchanted, then Bit6 will be set to 0.
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
