util.AddNetworkString("SendShockerStrikePos")
util.AddNetworkString("SendShockerTwitchPos")

local shockerTable = {} 

local timesPerPlayer = {}

local rSound = false
if SHOCKERDT.RSOUND then rSound = Sound(SHOCKERDT.RSOUND) end

local tSound = false
if SHOCKERDT.TSOUND then tSound = Sound(SHOCKERDT.TSOUND) end

function initShockers(ply, oldwep, newwep)
	if !newwep then newwep = ply:GetActiveWeapon() end
	if IsValid(newwep) then
		if SHOCKERDT.WEPLIST[newwep:GetClass()] then
			if !shockerTable[newwep] then shockerTable[newwep] = SHOCKERDT.SHOCKCOUNT end
		end
	end
end

hook.Add("PlayerSwitchWeapon", "InitShockerCount", initShockers)
hook.Add("PlayerSpawn", "InitShockerCount", initShockers)

hook.Add( "KeyPress", "keypress_throwshocker", function( ply, key )
	if ( key == SHOCKERDT.RELEASEKEY ) and ply:KeyDown(SHOCKERDT.HOLDKEY) then
		local act = ply:GetActiveWeapon()
		if IsValid(act) then
			local class = act:GetClass()
			if SHOCKERDT.WEPLIST[class] then
				act:SetNextPrimaryFire( CurTime() + FrameTime() )
				local shouldDo = true
				if timesPerPlayer[ply] then
					if timesPerPlayer[ply] > RealTime() then shouldDo = false end
				end
				if shouldDo then
					timesPerPlayer[ply] = RealTime() + SHOCKERDT.REFRESHTIME
					local ammo = shockerTable[act] or nil
					if ammo == nil then
						ammo = SHOCKERDT.SHOCKCOUNT
						shockerTable[act] = ammo
					end
					if ammo == 0 then
						if rSound then ply:EmitSound(rSound) end
						timesPerPlayer[ply] = RealTime() + SHOCKERDT.RELOADTIME
					else
						ammo = ammo - 1
						if tSound then ply:EmitSound(tSound) end
						local shocker = ents.Create("prop_stickshock")
						shocker:SetPos( ply:GetShootPos() )
						shocker.Owner = ply
						shocker:Spawn()
						local phys = shocker:GetPhysicsObject()
						if phys:IsValid() then phys:ApplyForceCenter( ply:GetAimVector()*SHOCKERDT.ARMST ) end
					end
				end
			end
		end
	end
end )