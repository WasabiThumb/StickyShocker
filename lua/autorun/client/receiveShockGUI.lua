local shouldDraw = false
local activeframes = 0
local pos = Vector()

local hitmat = Material("FX/Electro/Tazer/Tazer_Hit_Arcs_01_")
local white = Color( 255, 255, 255, 255 )
net.Receive("SendShockerStrikePos", function(leng, ply)
	pos = net.ReadVector()
	shouldDraw = true
end )

hook.Add("PreDrawTranslucentRenderables", "drawShockerHitNet", function()
	if (activeframes >= SHOCKERDT.HFFRAMES) and shouldDraw then
		render.SetMaterial( hitmat )
		render.DrawSprite( pos, 40, 40, white )
		if activeframes == SHOCKERDT.HFFRAMES then
			shouldDraw = false
		end
		activeframes = activeframes + 1
	else
		activeframes = 0
	end
end )