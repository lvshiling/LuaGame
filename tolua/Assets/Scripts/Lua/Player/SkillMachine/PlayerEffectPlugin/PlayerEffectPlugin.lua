require("PlayerSkillPlugin")
require("UnityClass")

PlayerEffectPlugin = Class(PlayerSkillPlugin)

function PlayerEffectPlugin:ctor(name)
    
end

function PlayerEffectPlugin:SetPlayerEffectState(effectState)

    self.mPlayerEffectState = effectState

end

function PlayerEffectPlugin:OnBegin()

end


function PlayerEffectPlugin:OnEnd()

end