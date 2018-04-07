-- Sticky Shockers by WasabiThumbs
-- Config

-- This is sciency stuff, look down there.
SHOCKERDT = {}
SHOCKERDT.WHITELIST = {}
-- End of sciency stuff

-- By default, all NPCs go through a humanoid test.
-- Enter the classname in here with the following format if it should be omitted.
-- Repeat as many times as you need.
SHOCKERDT.WHITELIST["npc_manhack"] = true

-- This is the minimum number of bones something should have to be concidered "humanoid". 
-- 51 is a good number. If this is -1, then the humanoid test won't happen.
SHOCKERDT.MINHCHECK = 51

-- The radius of the shocker.
SHOCKERDT.RADIUS = 10

-- Interval between seizure movements in seconds.
SHOCKERDT.SZINTERVAL = 0.02

-- How many times to seizure. Note that the seizure time is SZCT*SZINTERVAL seconds. Default is 1.6 seconds.
SHOCKERDT.SZCT = 80

-- The magnitude of the seizure. Guess and check, there is no real world version.
SHOCKERDT.SZMAGNITUDE = 40

-- The seizure sound to make, if any. To not do any sound, replace with false, no quotation marks.
SHOCKERDT.SZSOUND = "seizure.mp3"

-- The sound that the shocker makes when it dies.
SHOCKERDT.DSOUND = "weapons/sc20k/sticky_shocker.wav"

-- The amount of damage to apply to players, NPCs instakill
SHOCKERDT.PLYDMG = 20 

-- The timeout in seconds for shocking players, per shocker.
SHOCKERDT.PLYTM = 1

-- The starting number of shockers in a player's inventory, per weapon
SHOCKERDT.SHOCKCOUNT = 5

-- The time in seconds it takes to reload
SHOCKERDT.RELOADTIME = 2

-- Time in seconds it takes to be able to shoot another
SHOCKERDT.REFRESHTIME = 0.7

-- The reload sound. False for no sound.
SHOCKERDT.RSOUND = "bagreload.mp3"

-- The throw sound. False for no sound.
SHOCKERDT.TSOUND = "throwcan.mp3"

-- The sound made on impact with moderate speed. False for no sound.
SHOCKERDT.TSOUND = "standardimpact.mp3"

-- The player's arm strength.
--[[
	1: Inhumanly Small
	20: Do you even lift?
	80: Meh.
	150: You go!
	240: OH SHIT GO BACK
	600: I SAID GO BACK
]]
SHOCKERDT.ARMST = 150 

-- The weapons that this should work with.
SHOCKERDT.WEPLIST = {
	["weapon_sc_20ka"] = true,
	["weapon_sc_20kanniversary"] = true,
	["weapon_smg"] = true
}

-- The key that should be held down.
SHOCKERDT.HOLDKEY = IN_USE

-- The key that should be pressed.
SHOCKERDT.RELEASEKEY = IN_ATTACK

-- How many frames should the shocker hit flash be? THE FLASH DOES NOT MOVE, IT STAYS IN ABOUT THE SAME SPOT.
-- USE SMALL NUMBERS!
SHOCKERDT.HFFRAMES = 2

-- How many frames should the seizure flash be? THE FLASH DOES NOT MOVE, IT STAYS IN ABOUT THE SAME SPOT.
-- USE SMALL NUMBERS!
SHOCKERDT.SFFRAMES = 2

