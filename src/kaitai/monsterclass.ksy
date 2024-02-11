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
        
      #Monster id in DS Quest Editor.
      - id: id_dsqe
        type: strz
        size: 32
        
      #Monster name in game.
      - id: id_in_game_name
        type: strz
        size: 32
        
      #Change monster type to Monster, Shop, NPC, Alliance Monster.
      - id: type
        type: u2
        
      #Monster spawn level.
      #BYTE 0 = Spawn level [
      #  Valid values [0x00..0xFF]
      #  BYTE 1 can be between 0x00..0x7F.
      #  0x00 = Town (monster have to be set as a NPC(0x02)).
      #  0x01 = Land1 and Level1.
      #  0xFF = Manual spawn.
      #]
      #BYTE 1 = Red glow effect [
      #  Give monster a red glow effect.
      #  0x00..0x7F = Off, 0x80..0xFF = On.
      #  BYTE 0 need to be set to 0xFF(manual spawn).
      #]
      - id: level
        type: u2
        
      - id: hp_min
        type: s4
        doc: valid values [1..32000]
      - id: hp_max
        type: s4
        doc: valid values [1..32000]
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
        
        #I don't know what this dose but Monster/NPC only uses these hex-values
        #0x00, 0x08, 0x0C, 0x0E, 0x14, 0x30.
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
        
      #Monster have to be set as a Shop(0x01).
      #0x00 = Blacksmith     [Forgeron]    [Blacksmith]  (Gunther the Blacksmith)
      #0x01 = BANQUIER       [Banquier]    [Banker]      (Larsac the Usurer)
      #0x02 = APOTHICAIRE    [Magicien]    [Magician]    (Master Elmeric)
      #0x03 = TAVERNIER      [Aubergiste]  [Innkeeper]   (Perry the Publican)
      #0x04 = BONNEAVENTURE  [Irma]        [Irma]        (Madame Irma)
      #0x09 = PROF1          [Dalsin]      [Dalsin]      (Master Dalsin)
      - id: shop
        type: u4
        
      - id: val19
        type: u4
        
      #Positive value = On(time), Negative value = Off.
      - id: attack_frequency
        type: s4
        
      - id: val21
        type: u4
        
      #Positive value = On(distance), Negative value = Off.
      - id: attack_distance_melee
        type: s4
        
      #Positive value = On(distance), Negative value = Off.
      - id: attack_distance_range
        type: s4
        
      - id: val24
        type: u4
      - id: skeleton_name
        type: strz
        size: 64
        
      #Skeleton rotation offset.
      - id: skeleton_rotation
        type: f4
        doc: valid values [-3.14..3.14]
        
      #Unknown, DATA\PCLASS\MONSTER.TXT
      - id: chaapp
        type: u2
      - id: cntapp
        type: u2
        
      - id: val28
        type: u4
        
      #Lower Value = Faster, Higher Value = Slower.
      - id: attack_speed
        type: u4
        
      #Positive value = Flee mode On(duration). 4096 = 1 second.
      #Negative value = Berserker mode On(duration). -4097 = 1 second.
      - id: activate_flee_or_berserker_mode
        type: s4
        
      - id: val31
        type: f4
        
      #0x00..0x0B, DATA\SFX\BLOODx.SFX.
      - id: blood_effect
        type: u4
        
      - id: val33
        type: u4
        
      #Configure monster/NPC behavior, ability, pathing and gender.
      #Read: §1 for more info.
      - id: config
        type: u4
        
      - id: val35
        type: u4
        
      #The "id_dsqe" name of the monster(minion) that will be able to be summoned.
      - id: minion_to_summon
        type: strz
        size: 32
        
      #0x00..0x0B, DATA\SFX\DIEx.SFX.
      - id: death_effect
        type: u4
        
      #Enable / Disable Death effect (SFX).
      #This is not a flag for "No Gore", so the effects in DATA\SFXNOGORE\ will not be used.
      - id: enable_death_effect
        type: u4
        
      - id: val38
        type: u4
        
      #The item that will be dropped by custom monsters made with QuestEdit.
      #The .SPT scripts writes to this.
      #Script: QUEST { AGENT { GIVE { Item.id_dsqe }}}
      - id: item_to_drop
        type: strz
        size: 32
        
      - id: val39
        type: u4
      - id: val40
        type: u4
        
      #Enemy Spell Resistance.
      #Read: §2 for more info.
      - id: enemy_spell_resistance_and_unknown
        size: 8
        
      - id: sound_attack
        type: strz
        size: 32
      - id: sound_die
        type: strz
        size: 32
      - id: sound_parry
        type: strz
        size: 32
      - id: sound_flee
        type: strz
        size: 32
      - id: sound_hit
        type: strz
        size: 32
      - id: sound_6
        type: strz
        size: 32
        
      #Valid values [0x00..0x08C5]
      #but 0x03 is the slowest speed.
      - id: walking_speed
        type: u4
        
      #Projectile
      #BYTE 0..1 = Projectile [
      #  The projectile(mesh) the monster will throw.
      #  DATA\PCLASS\EFFECTCLASS.TXT --> ProjectileList.
      #]
      #BYTE 2..3 = Enable / Disable projectile firing [
      #  0x0000 = On, 0xFFFF = Off.
      #  Values between [0x0001..FFFE] may crash the game at projectile firing.
      #]
      - id: projectile
        type: u4
        
      - id: val44
        type: u4
      - id: val45
        type: u4
        
      #Teleportation
      #BYTE 0 = [
      #  Enable enemy teleportation + dodge backwards + plant Magic Bomb.
      #  Even numbers = Off.
      #  Odd numbers = On.
      #  0x*1 = Doesn't plant Magic Bomb, 0x*7 = Does plant Magic Bomb.
      #]
      #BYTE 1..7 = ?? []
      - id: teleportation_and_unknown
        size: 8
        
      - id: val47
        type: u4
      - id: val48
        type: u4
        
      #Each byte represents the percentage of the player's "% toHit" that will
      #be used to try to hit the monster depending on the damage type that's
      #inflicted by player's weapon. See Item.damageType for more info.
      #Math: toHit = (player.attrToHit * damageTypeVulnerability) /100
      #Byte: 0 = Crushing, 1 = Slashing, 2 = Piercing, 3..15 = Unused
      - id: damage_type_vulnerability
        size: 16

seq:
  - id: version
    contents: [ 1, 0 ]
  - id: count
    type: u4
  - id: classes
    type: monsterclass
    repeat: expr
    repeat-expr: count

#_______________________________________________________________________________
#§1 |
#___|
#
#Note: The command between the square brackets are used by the .SPT scripts to set the respective bit.
#      Script: QUEST { AGENT { COMMAND } }
#
#BYTE 0 = [
#  bit 0 = isTownQuestMonster
#  bit 1 = NULL
#  bit 2 = isDraak
#  bit 3 = isPoisonous
#  bit 4 = isNonInteractive
#  bit 5 = isFemale     (Use NPC skeletons/animations prefixed with "f")
#  bit 6 = isQuestAgent             [ QUEST { AGENT { ... }} ]
#  bit 7 = followPlayer (See note)  [ FLAG { FOLLOW } ]
#]
#
#BYTE 1 = [
#  bit 0 = auto (See note)  [ FLAG { AUTO } ]
#  bit 1 = followPath       [ FLAG { PATH } ], [ PATH { PATH_KEY_ID } ]
#  bit 2 = isStatic         [ FLAG { STATIC } ]
#  bit 3 = isTownGuide
#  bit 4 = bodyEffectFire
#  bit 5 = bodyEffectIce
#  bit 6 = NULL
#  bit 7 = NULL
#]
#
#Note:
#  Requires:
#  trackNode = TRACK { TRAP_KEY_ID }
#  item = Monster.item_to_drop
#
#  NPC will follow the player until the trackNode position is found.
#  The item is then dropped and used to trigger next quest trap/state code block.
#  If Byte1.bit0 = false, then player has to manually click on NPC to trigger item drop.
#  If Byte1.bit0 = true, then the quest will automatically proceed by auto dropping the item. (item must be virtual)
#_______________________________________________________________________________
#§2 |
#___|
#
#BYTE 0 = [
#  bit 0 = Confusion
#  bit 1 = NULL
#  bit 2 = Fear
#  bit 3 = Thunder
#  bit 4 = Slowness
#  bit 5 = Wall of Fire
#  bit 6 = Mutation
#  bit 7 = Stone
#]
#
#BYTE 1 = [
#  bit 0 = NULL
#  bit 1 = NULL
#  bit 2 = Magic Missile
#  bit 3 = Fire Ball
#  bit 4 = Absorption
#  bit 5 = NULL
#  bit 6 = Flame Thrower
#  bit 7 = NULL
#]
#
#BYTE 2 = [
#  bit 0 = NULL
#  bit 1 = Death Dome
#  bit 2 = NULL
#  bit 3 = Spark
#  bit 4 = NULL
#  bit 5 = NULL
#  bit 6 = NULL
#  bit 7 = NULL
#]
#
#BYTE 3 = [
#  bit 0 = Forgetfulness
#  bit 1 = NULL
#  bit 2 = Magic Bomb
#  bit 3 = NULL
#  bit 4 = Poison Cloud
#  bit 5 = NULL
#  bit 6 = NULL
#  bit 7 = NULL
#]
#
#BYTE 4..7 = ?? []
