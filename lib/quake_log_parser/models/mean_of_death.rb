module QuakeLogParser
  module Models
    class MeanOfDeath
      MEANS_OF_DEATH = {
        0 => "MOD_UNKNOWN",
        1 => "MOD_SHOTGUN",
        2 => "MOD_GAUNTLET",
        3 => "MOD_MACHINEGUN",
        4 => "MOD_GRENADE",
        5 => "MOD_GRENADE_SPLASH",
        6 => "MOD_ROCKET",
        7 => "MOD_ROCKET_SPLASH",
        8 => "MOD_PLASMA",
        9 => "MOD_PLASMA_SPLASH",
        10 => "MOD_RAILGUN",
        11 => "MOD_LIGHTNING",
        12 => "MOD_BFG",
        13 => "MOD_BFG_SPLASH",
        14 => "MOD_WATER",
        15 => "MOD_SLIME",
        16 => "MOD_LAVA",
        17 => "MOD_CRUSH",
        18 => "MOD_TELEFRAG",
        19 => "MOD_FALLING",
        20 => "MOD_SUICIDE",
        21 => "MOD_TARGET_LASER",
        22 => "MOD_TRIGGER_HURT",
        23 => "MOD_NAIL",
        24 => "MOD_CHAINGUN",
        25 => "MOD_PROXIMITY_MINE",
        26 => "MOD_KAMIKAZE",
        27 => "MOD_JUICED",
        28 => "MOD_GRAPPLE"
      }

      def self.get_by_value(value)
        MEANS_OF_DEATH[value]
      end
    end
  end
end
