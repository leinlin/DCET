﻿#if USE_UNI_LUA
using LuaAPI = UniLua.Lua;
using RealStatePtr = UniLua.ILuaState;
using LuaCSFunction = UniLua.CSharpFunctionDelegate;
#else
using LuaAPI = XLua.LuaDLL.Lua;
using RealStatePtr = System.IntPtr;
using LuaCSFunction = XLua.LuaDLL.lua_CSFunction;
#endif

using XLua;
using System.Collections.Generic;


namespace XLua.CSObjectWrap
{
    using Utils = XLua.Utils;
    public class DCETModelKcpProtocalTypeWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(DCET.Model.KcpProtocalType);
			Utils.BeginObjectRegister(type, L, translator, 0, 0, 0, 0);
			
			
			
			
			
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 5, 0, 0);
			
			
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "SYN", DCET.Model.KcpProtocalType.SYN);
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "ACK", DCET.Model.KcpProtocalType.ACK);
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "FIN", DCET.Model.KcpProtocalType.FIN);
            Utils.RegisterObject(L, translator, Utils.CLS_IDX, "MSG", DCET.Model.KcpProtocalType.MSG);
            
			
			
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            return LuaAPI.luaL_error(L, "DCET.Model.KcpProtocalType does not have a constructor!");
        }
        
		
        
		
        
        
        
        
        
        
        
        
        
		
		
		
		
    }
}
