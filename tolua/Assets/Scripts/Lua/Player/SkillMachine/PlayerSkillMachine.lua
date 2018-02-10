require("StateMachine")
require("PlayerSkillState")

PlayerSKillMachine = Class(StateMachine)

--没用base保存一个基类的对象
--不要重写StateMachine的函数了，不然会被覆盖掉的
--基类的函数就不起作用了

function PlayerSKillMachine:ctor(playerCharacter)
    self.name = "None"
    self.mPlayerSkillStateDic = {} --状态列表
    self.mPlayerCharacter   = playerCharacter
end


function PlayerSKillMachine:Init(configure)

    if configure == nil or configure.StateList == nil then return end

    self.name = configure.name

    for i,v in ipairs(configure.StateList) do
       local skillType = v.enum
       local state = PlayerSkillState.new(v.name)
       state:Init(v)
       state:SetStateMachine(self)
       self.mPlayerSkillStateDic[skillType] = state
    end

end


function PlayerSKillMachine:Cache(skillType)

    local state = self:GetPlayerSkillState(skillType)
    if state == nil then
        return false
    end


end

function PlayerSKillMachine:GetPlayerSkillState(skillType)

    if self.mPlayerSkillStateDic ~= nil then

        return self.mPlayerSkillStateDic[skillType]
    
    end
    return nil
end 

