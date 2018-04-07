include("shared.lua")

ENT.RenderGroup = RENDERGROUP_OPAQUE
local white = Material( "models/props_lab/tpplug_plug" )
function ENT:Draw()
	render.ModelMaterialOverride( white )
	render.ModelMaterialOverride()
end