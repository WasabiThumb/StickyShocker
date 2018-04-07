AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')
 
function ENT:Initialize()

	print("Initialized!")
	self:SetModel( "models/stickwallcam/s_wallcam.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
end
 
function ENT:Use( activator, caller )
    return
end

local bsound = false
local dsound = false
local isound = false
if SHOCKERDT.SZSOUND then
	bsound = Sound(SHOCKERDT.SZSOUND)
end
if SHOCKERDT.DSOUND then
	dsound = Sound(SHOCKERDT.DSOUND)
end
if SHOCKERDT.ISOUND then
	isound = Sound(SHOCKERDT.ISOUND)
end
local firstclamp = false
function ENT:PhysicsCollide(data, phys)
	if IsValid(data.HitEntity) then
		if data.HitEntity:IsWorld() then self:Remove() end
	end
	if ( data.Speed > 50 ) then
		if isound then sound.Play(isound, self:GetPos(), 75, 100, 1) end
		for k,v in pairs( player.GetHumans() ) do
			local pos = data.HitPos.x - (v:GetRight()*20)
			pos = pos + (v:GetUp()*20) 
			net.Start("SendShockerStrikePos")
			net.WriteVector(pos)
			net.Send(v)
		end
	end
end
 
local hitTimeTable = {}
function ENT:Think()
	local own = self.Owner
	if !IsValid(own) then own = Entity(1) end
	local iterated = false
	for k,v in pairs( ents.FindInSphere(self:GetPos(), SHOCKERDT.RADIUS) ) do
		if !IsValid(v) then continue end
		if v == own then continue end
		if v:IsPlayer() or v:IsNPC() then
			if v:IsNPC() then
				if util.IsValidRagdoll(v:GetModel()) then continue end
				if !(v:GetBoneCount() >= SHOCKERDT.MINHCHECK or SHOCKERDT.WHITELIST[v:GetClass()]) then continue end
			end
			if v:IsPlayer() then if not (hitTimeTable[v:SteamID64()] or 0) <= RealTime() then continue end end
			iterated = true
			if v:IsPlayer() then
				if (v:Health() - SHOCKERDT.PLYDMG) > 0 then
					v:TakeDamage(SHOCKERDT.PLYDMG)
					hitTimeTable[v:SteamID64()] = RealTime() + SHOCKERDT.PLYTM
					continue
				end
			end
			local rag = ents.Create("prop_ragdoll")
			rag:SetModel( v:GetModel() )
			rag:SetPos( v:GetPos() )
			rag:Spawn()
			for i=0,v:GetBoneCount() - 1 do
				local bonepos, boneang = v:GetBonePosition(i)
				rag:SetBonePosition(i, bonepos, boneang)
				local phys = rag:GetPhysicsObjectNum(i)
				if phys:IsValid() then
					phys:SetVelocityInstantaneous( Vector() )
				end
			end
			if v:IsPlayer() then
				v:KillSilent()
				v:Spectate(OBS_MODE_CHASE)
				v:SpectateEntity(rag)
			else
				v:Remove()
			end
			local physwhole = self:GetPhysicsObject()
			if physwhole:IsValid() then
				if bsound then rag:EmitSound(bsound) end
				timer.Create( "shockerRagSeizure" .. tostring(rag:EntIndex()), SHOCKERDT.SZINTERVAL, SHOCKERDT.SZCT, function()
					if physwhole:IsValid() and rag:IsValid() then
						physwhole:ApplyForceCenter( VectorRand()*SHOCKERDT.SZMAGNITUDE )
						local mins = rag:OBBMins()
						local maxs = rag:OBBMaxs()
						-- Add the seizure shocking thing here!
					end
				end )
			end
		end
	end
	if iterated then self:Remove() end
end

function ENT:OnRemove()
	self:CustRemove()
end

function ENT:CustRemove()
	if dsound then self:EmitSound(dsound) end
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetOrigin( vPoint )
	util.Effect( "ManhackSparks", effectdata )
end