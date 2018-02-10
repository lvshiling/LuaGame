require("Class")
require("BaseWindow")

--UI_Main继承于BaseWindow
UI_Main = Class(BaseWindow)
local this = UI_Main

function this:ctor(behaviour, path)
    self.path  = path
    self.windowType = 0 --主界面

    --不用重写基类的函数，就不需要保存基类的base对象了
    --self.base = BaseWindow.new(behaviour, self.path, self.windowType)
end

function this:Awake()
    -- body
    print(self.behaviour.name..".Awake ")
end 

function this:Start()

    print(self.behaviour.name..".Start ")

    local fadeWindow = self.transform:Find("FadeWindow")
    self.behaviour:AddClick(fadeWindow.gameObject, function() 
        print("Click FadeWindow")
        WindowManager:Open(UI_FadeWindow,"UI_FadeWindow")
    end)

    local scaleWindow = self.transform:Find("ScaleWindow")
    self.behaviour:AddClick(scaleWindow.gameObject, function() 
        print("Click ScaleWindow")
        WindowManager:Open(UI_ScaleWindow,"UI_ScaleWindow")
    end)
    local moveWindow = self.transform:Find("MoveWindow")
    self.behaviour:AddClick(moveWindow.gameObject, function() 
        print("Click MoveWindow")
        WindowManager:Open(UI_MoveWindow,"UI_MoveWindow")
    end)
    local popWindow = self.transform:Find("PopWindow")
    self.behaviour:AddClick(popWindow.gameObject, function() 
        print("Click PopWindow")
        WindowManager:Open(UI_PopWindow,"UI_PopWindow")
    end)
   
    
end