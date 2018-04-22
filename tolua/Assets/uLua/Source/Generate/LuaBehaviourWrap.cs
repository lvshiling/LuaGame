﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class LuaBehaviourWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaBehaviour), typeof(UnityEngine.MonoBehaviour));
		L.RegFunction("Init", Init);
		L.RegFunction("AddClick", AddClick);
		L.RegFunction("RemoveClick", RemoveClick);
		L.RegFunction("ClearClick", ClearClick);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("luaTable", get_luaTable, null);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Init(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LuaBehaviour obj = (LuaBehaviour)ToLua.CheckObject<LuaBehaviour>(L, 1);
			LuaTable arg0 = ToLua.CheckLuaTable(L, 2);
			obj.Init(arg0);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int AddClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			LuaBehaviour obj = (LuaBehaviour)ToLua.CheckObject<LuaBehaviour>(L, 1);
			UnityEngine.GameObject arg0 = (UnityEngine.GameObject)ToLua.CheckObject(L, 2, typeof(UnityEngine.GameObject));
			LuaFunction arg1 = ToLua.CheckLuaFunction(L, 3);
			obj.AddClick(arg0, arg1);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int RemoveClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LuaBehaviour obj = (LuaBehaviour)ToLua.CheckObject<LuaBehaviour>(L, 1);
			UnityEngine.GameObject arg0 = (UnityEngine.GameObject)ToLua.CheckObject(L, 2, typeof(UnityEngine.GameObject));
			obj.RemoveClick(arg0);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ClearClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaBehaviour obj = (LuaBehaviour)ToLua.CheckObject<LuaBehaviour>(L, 1);
			obj.ClearClick();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object arg0 = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object arg1 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool o = arg0 == arg1;
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_luaTable(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			LuaBehaviour obj = (LuaBehaviour)o;
			LuaInterface.LuaTable ret = obj.luaTable;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index luaTable on a nil value");
		}
	}
}

