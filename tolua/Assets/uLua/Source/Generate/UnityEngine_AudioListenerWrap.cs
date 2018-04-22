﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class UnityEngine_AudioListenerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEngine.AudioListener), typeof(UnityEngine.Behaviour));
		L.RegFunction("GetOutputData", GetOutputData);
		L.RegFunction("GetSpectrumData", GetSpectrumData);
		L.RegFunction("New", _CreateUnityEngine_AudioListener);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("volume", get_volume, set_volume);
		L.RegVar("pause", get_pause, set_pause);
		L.RegVar("velocityUpdateMode", get_velocityUpdateMode, set_velocityUpdateMode);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateUnityEngine_AudioListener(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 0)
			{
				UnityEngine.AudioListener obj = new UnityEngine.AudioListener();
				ToLua.PushSealed(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.AudioListener.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetOutputData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			float[] arg0 = ToLua.CheckNumberArray<float>(L, 1);
			int arg1 = (int)LuaDLL.luaL_checknumber(L, 2);
			UnityEngine.AudioListener.GetOutputData(arg0, arg1);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetSpectrumData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float[] arg0 = ToLua.CheckNumberArray<float>(L, 1);
			int arg1 = (int)LuaDLL.luaL_checknumber(L, 2);
			UnityEngine.FFTWindow arg2 = (UnityEngine.FFTWindow)ToLua.CheckObject(L, 3, typeof(UnityEngine.FFTWindow));
			UnityEngine.AudioListener.GetSpectrumData(arg0, arg1, arg2);
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
	static int get_volume(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, UnityEngine.AudioListener.volume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_pause(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, UnityEngine.AudioListener.pause);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_velocityUpdateMode(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.AudioListener obj = (UnityEngine.AudioListener)o;
			UnityEngine.AudioVelocityUpdateMode ret = obj.velocityUpdateMode;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index velocityUpdateMode on a nil value");
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_volume(IntPtr L)
	{
		try
		{
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			UnityEngine.AudioListener.volume = arg0;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_pause(IntPtr L)
	{
		try
		{
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			UnityEngine.AudioListener.pause = arg0;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_velocityUpdateMode(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.AudioListener obj = (UnityEngine.AudioListener)o;
			UnityEngine.AudioVelocityUpdateMode arg0 = (UnityEngine.AudioVelocityUpdateMode)ToLua.CheckObject(L, 2, typeof(UnityEngine.AudioVelocityUpdateMode));
			obj.velocityUpdateMode = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o, "attempt to index velocityUpdateMode on a nil value");
		}
	}
}

