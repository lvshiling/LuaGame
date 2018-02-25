require("Class")
require("StateMachine")
require("SceneType")
require("FrameScene")

SceneMachine = Class(StateMachine).new()

function SceneMachine:Initialize()

    --确保只被初始化一次
   if  self.initialized  == nil or self.initialized == false then
   
       self.initialized = true
      
       self.mSceneDic = {}           --场景
   
       self:Init()
       
    end

   return self
end

---注册场景列表
function SceneMachine:Init()

    self.mSceneDic[SceneType.FrameScene] = FrameScene.new(SceneType.FrameScene)

end

function SceneMachine:ChangeScene(sceneType)

    local current = self:GetCurrentState()

    if current then

        if current.name == sceneType then

            return;
        end
    end

    local scene = self.mSceneDic[sceneType]

    if scene == nil then
        return
    end

    self:ChangeState(scene)
    
end
