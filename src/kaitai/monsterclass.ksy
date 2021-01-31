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
          #Valid values [0x00..0xFF]
          #BYTE 1 can be between 0x00..0x7F.
          #0x00 = Town (monster have to be set as a NPC(0x02)).
          #0x01 = Land1 and Level1.
          #0xFF = Manual spawn.
        #]
        #BYTE 1 = Red glow effect [
          #Give monster a red glow effect.
          #0x00..0x7F = Off, 0x80..0xFF = On.
          #BYTE 0 need to be set to 0xFF(manual spawn).
        #]
      - id: level
        type: u2

      - id: hp_min
        type: u4
      - id: hp_max
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
      #0x00 = Blacksmith    [Forgeron]	  [Blacksmith]	(Gunther the Blacksmith)
      #0x01 = BANQUIER      [Banquier]	  [Banker]	    (Larsac the Usurer)
      #0x02 = APOTHICAIRE	  [Magicien]  	[Magician]	  (Master Elmeric)
      #0x03 = TAVERNIER		  [Aubergiste]	[Innkeeper]	  (Perry the Publican)
      #0x04 = BONNEAVENTURE	[Irma]	    	[Irma]	  	  (Madame Irma)
      #0x09 = PROF1		      [Dalsin]	    [Dalsin]  	  (Master Dalsin)
      - id: shop
        type: u4

      - id: val19
        type: u4
      - id: val20
        type: u4
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
      - id: val34
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
      - id: string2
        type: strz
        size: 32
      - id: val39
        type: u4
      - id: val40
        type: u4

        #Enemy Spell Resistance.
          #BYTE 0..3 = Enemy Spell Resistance [
            #Byte 0: Mutation, Stone, Wall of Fire, Slowness, Thunder, Fear, Confusion.
            #Byte 1: Flame Thrower, Absorption, Fire Ball, Magic Missile.
            #Byte 2: Spark, Death Dome.
            #Byte 3: Poison Cloud, Magic Bomb, Forgetfulness.
            #I have a list that contains every spell combination that I've found this far.
          #]
          #BYTE 4..7 = ?? []
      - id: enemy_spell_resistance_and_unknown
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

      #Valid values [0x00..0x08C5]
      #but 0x03 is the slowest speed.
      - id: walking_speed
        type: u4

      #Projectile
        #BYTE 0..1 = Projectile [
          #The projectile(mesh) the monster will throw.
          #DATA\PCLASS\EFFECTCLASS.TXT --> ProjectileList.
        #]
        #BYTE 2..3 = Enable / Disable projectile firing [
           #0x0000 = On, 0xFFFF = Off.
           #Values between [0x0001..FFFE] may crash the game at projectile firing.
        #]
      - id: projectile
        type: u4

      - id: val44
        type: u4
      - id: val45
        type: u4

      #Teleportation
        #BYTE 0 = [
          #Enable enemy teleportation + dodge backwards + plant Magic Bomb.
          #Even numbers = Off.
          #Odd numbers = On.
          #0x*1 = Doesn't plant Magic Bomb, 0x*7 = Does plant Magic Bomb.
        #]
        #BYTE 1..7 = ?? []
      - id: teleportation_and_unknown
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
