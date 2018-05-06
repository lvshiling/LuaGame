require("Class")
require("UnityClass")
require("AssetManager")
require("WindowManager")
require("PlayerManager")
require("SceneMachine")
----
----Lua表不要与C#中需要Wrap的类同名，会引起混乱
----

--主入口函数。从这里开始lua逻辑
--LuaGame.cs会调用Main.lua执行Lua逻辑
Main = {}

function Main:DebugMode()
	
	return true

end

--资源读取方式
function Main:AssetMode()

	local assetmode = 1
	if LuaGame.EditorMode() then
		assetmode =  UnityEngine.PlayerPrefs.GetInt("assetmode")
	end
	return assetmode
end

function Main:Start()
		
	LuaGame.Log(AssetManager.GetAssetBundlePath())
	--初始化资源管理器
	AssetManager:Initialize()
	--初始化窗口管理器
	WindowManager:Initialize()
	--初始化人物管理器
	PlayerManager:Initialize()
	--初始化场景状态机
	SceneMachine:Initialize()

	--添加Lua逻辑更新

	self.update = UpdateBeat:CreateListener(self.Update,self)		
	self.lateUpate = LateUpdateBeat:CreateListener(Main.LateUpate,self)	 		
	self.fixedUpdate = FixedUpdateBeat:CreateListener(Main.FixedUpdate,self)	 	
	
	UpdateBeat:AddListener(self.update)
	LateUpdateBeat:AddListener(self.lateUpate)
	FixedUpdateBeat:AddListener(self.fixedUpdate)


	
	SceneMachine:ChangeScene(SceneType.FrameScene)
		
end



--场景切换通知
function Main:OnLevelWasLoaded(level)
	collectgarbage("collect")

	Time.timeSinceLevelLoad = 0

	WindowManager:Open(UI_Main, "UI_Main")

	self:CreatePlayer()

end


function Main:CreatePlayer()

	local mode = 0
	for i = 0, 2 do
		
		local tmpPlayerInfo = PlayerInfo.new(i)
		tmpPlayerInfo.guid = i
		tmpPlayerInfo.position = Vector3.New(4+2*i,0, 8+3*i)
		tmpPlayerInfo.direction = Vector3.New(0, -120+ i*10, 0)
		tmpPlayerInfo.baseSpeed = 6
		tmpPlayerInfo.moveSpeedAddition = 0.3
		tmpPlayerInfo.character = "Ahri"

		mode = i % 3
		if mode == 0 then
			tmpPlayerInfo.skin = "Ahri_shadowfox"
		elseif mode == 1 then
			tmpPlayerInfo.skin = "Ahri"
		else
			tmpPlayerInfo.skin = "Ahri_hanbok"
		end

		tmpPlayerInfo.configure = Role_Configure_Ahri
	
	
		PlayerManager:CreatePlayerCharacter(tmpPlayerInfo.guid, tmpPlayerInfo, function (varPlayerCharacter) 
		
		
		end)
		
	end

end

function Main:OnApplicationQuit()
end
--Lua逻辑更新
function Main:Update()
	--print("LuaGame update")

	--local start = os.clock()
	--资源管理器更新
	AssetManager:Update()

	--人物管理器更新
	PlayerManager:Update()
	--print("Main Update: " .. ((os.clock() - start) * 1000))

	
	
end

function Main:LateUpate()

end

function Main:FixedUpdate()

end

-------------------------------------------Test Start-----------------------------------------
--测试static函数
function Main.Test(self, go)

	self:Test1()
	print(go.name)
end


---测试 C# string[] 数组 array 是C#中传入的数组
function Main:Test1(array)

	print("array length =" .. array.Length)
	for i = 0, array.Length - 1 do
		print("array[".. i .."] =" .. array:GetValue(i))
	end
	
	

	print(self)
	
end
--测试创建GameObject
function Main:TestGameObject()

   

end


----测试C#导出栈类
function Main.TestStack()
    
    local stack = Stack.New()
    stack:Push(1)
    stack:Push(2)
    stack:Push(3)

    print("top:"..stack:Peek())

end

--测试继承和重写
A = Class()
function A:print()
	print("A:print")
end

B = Class(A)

function B:ctor()
	--self.base = A.new()
end
--[[
function B:print()
	print("B:print")

	self.base:print()
end
--]]
function Main:TestOverWrite()

	local a = A.new()
	a:print()

	--没有重写 调用A的print
	local b = B.new()
	b:print()

end

--测试Socket,以 socket 的方式访问获取百度首页数据
function Main:TestSocketClient()

	local socket = require("socket")
 
	local host = "127.0.0.1"
	local port = 1255
	local sock = socket.connect(host, port)

	if sock then	
	
		sock:settimeout(0)
	  
		local input = "Hello LuaSocket!"
		local recvt, sendt, status
		while true do
	
			assert(sock:send(input .. "\n"))
		
		 
			recvt, sendt, status = socket.select({sock}, nil, 1)
			while #recvt > 0 do
				local response, receive_status = sock:receive()
				if receive_status ~= "closed" then
					if response then
						print(response)
						recvt, sendt, status = socket.select({sock}, nil, 1)
					end
				else
					break
				end
			end
		end
	else
		print("connect "..host ..":"..port.." fail.")
	end
end

function Main:TestSocketServer()

	local socket = require("socket")
 
	local host = "127.0.0.1"
	local port = "12345"
	local server = assert(socket.bind(host, port, 1024))
	server:settimeout(0)
	local client_tab = {}
	local conn_count = 0
 
	print("Server Start " .. host .. ":" .. port) 
 
	while true do
    	local conn = server:accept()
    	if conn then
        	conn_count = conn_count + 1
        	client_tab[conn_count] = conn
        	print("A client successfully connect!") 
    	end
  
    	for conn_count, client in pairs(client_tab) do
        	local recvt, sendt, status = socket.select({client}, nil, 1)
        	if #recvt > 0 then
            	local receive, receive_status = client:receive()
            	if receive_status ~= "closed" then
                	if receive then
                    	assert(client:send("Client " .. conn_count .. " Send : "))
                    	assert(client:send(receive .. "\n"))
                    	print("Receive Client " .. conn_count .. " : ", receive)   
                	end
            	else
                	table.remove(client_tab, conn_count) 
                	client:close() 
                	print("Client " .. conn_count .. " disconnect!") 
            	end
        	end
         
    	end
	end

end

function Main:TestSetPosition()

	local go = GameObject('TestSetPosition')

	local time = os.clock()

	for i = 1, 1000000 do
		SetPosition(go, Vector3.zero)
	end

	print(os.clock() - time)

end

function Main:TestSetPosition1()

	local go = GameObject('TestSetPosition1')

	local time = os.clock()

	for i = 1, 1000000 do
		go.transform.position = Vector3.zero
	end

	print(os.clock() - time)

end

function Main:TestSetPosition2()


	local index = TestLua.TestCreateGameObject(1000)
	local TestSetPosition = TestLua.TestSetPosition
	local time = os.clock()

	for i = 1, 1000000 do
		TestSetPosition(index, 0,0,0)
	end


	

	print(os.clock() - time)

end


function Main:TestAssetManager()
	local plane = "assets/r/Plane.prefab";
    AssetManager:Load(plane, plane, function (varGo)

        if varGo then
            
            self.go0 = AssetManager:Instantiate(plane, plane, varGo) 
			
		end
    end)


    local cube = "assets/r/Cube.prefab";
    AssetManager:Load(cube, cube, function (varGo)

        if varGo then
            
            self.go1 = AssetManager:Instantiate(cube, cube, varGo) 
			
		end
	end)
	
end

function Main:TestAssetManagerUpdate()
	if  Input.GetKeyDown (KeyCode.Keypad0) then 
		Destroy(self.go0)
	end
	if  Input.GetKeyDown (KeyCode.Keypad1) then 
		Destroy(self.go1)
	end

	if  Input.GetKeyDown (KeyCode.Keypad2) then 
		if self.mList  then
			for i,v in ipairs(self.mList) do
				Destroy(v)
			end
		end
	end

	if  Input.GetKeyDown (KeyCode.Keypad3) then 
		local plane = "assets/r/Plane.prefab";
    	AssetManager:Load(plane, plane, function (varGo)

        	if varGo then
            
				local go = AssetManager:Instantiate(plane, plane, varGo) 
				if self.mList == nil then
					self.mList =  {}
				end
				table.insert( self.mList, go )

			end
    	end)
	end
end
-------------------------------------------Test End-----------------------------------------


return Main