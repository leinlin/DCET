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
    public class MongoDBBsonSerializationSerializersSByteSerializerWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(MongoDB.Bson.Serialization.Serializers.SByteSerializer);
			Utils.BeginObjectRegister(type, L, translator, 0, 3, 1, 0);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "Deserialize", _m_Deserialize);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "Serialize", _m_Serialize);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "WithRepresentation", _m_WithRepresentation);
			
			
			Utils.RegisterFunc(L, Utils.GETTER_IDX, "Representation", _g_get_Representation);
            
			
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 1, 0, 0);
			
			
            
			
			
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            
			try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
				if(LuaAPI.lua_gettop(L) == 1)
				{
					
					MongoDB.Bson.Serialization.Serializers.SByteSerializer gen_ret = new MongoDB.Bson.Serialization.Serializers.SByteSerializer();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				if(LuaAPI.lua_gettop(L) == 2 && translator.Assignable<MongoDB.Bson.BsonType>(L, 2))
				{
					MongoDB.Bson.BsonType _representation;translator.Get(L, 2, out _representation);
					
					MongoDB.Bson.Serialization.Serializers.SByteSerializer gen_ret = new MongoDB.Bson.Serialization.Serializers.SByteSerializer(_representation);
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to MongoDB.Bson.Serialization.Serializers.SByteSerializer constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_Deserialize(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                MongoDB.Bson.Serialization.Serializers.SByteSerializer gen_to_be_invoked = (MongoDB.Bson.Serialization.Serializers.SByteSerializer)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    MongoDB.Bson.Serialization.BsonDeserializationContext _context = (MongoDB.Bson.Serialization.BsonDeserializationContext)translator.GetObject(L, 2, typeof(MongoDB.Bson.Serialization.BsonDeserializationContext));
                    MongoDB.Bson.Serialization.BsonDeserializationArgs _args;translator.Get(L, 3, out _args);
                    
                        sbyte gen_ret = gen_to_be_invoked.Deserialize( _context, _args );
                        LuaAPI.xlua_pushinteger(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_Serialize(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                MongoDB.Bson.Serialization.Serializers.SByteSerializer gen_to_be_invoked = (MongoDB.Bson.Serialization.Serializers.SByteSerializer)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    MongoDB.Bson.Serialization.BsonSerializationContext _context = (MongoDB.Bson.Serialization.BsonSerializationContext)translator.GetObject(L, 2, typeof(MongoDB.Bson.Serialization.BsonSerializationContext));
                    MongoDB.Bson.Serialization.BsonSerializationArgs _args;translator.Get(L, 3, out _args);
                    sbyte _value = (sbyte)LuaAPI.xlua_tointeger(L, 4);
                    
                    gen_to_be_invoked.Serialize( _context, _args, _value );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_WithRepresentation(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                MongoDB.Bson.Serialization.Serializers.SByteSerializer gen_to_be_invoked = (MongoDB.Bson.Serialization.Serializers.SByteSerializer)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    MongoDB.Bson.BsonType _representation;translator.Get(L, 2, out _representation);
                    
                        MongoDB.Bson.Serialization.Serializers.SByteSerializer gen_ret = gen_to_be_invoked.WithRepresentation( _representation );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_Representation(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                MongoDB.Bson.Serialization.Serializers.SByteSerializer gen_to_be_invoked = (MongoDB.Bson.Serialization.Serializers.SByteSerializer)translator.FastGetCSObj(L, 1);
                translator.PushMongoDBBsonBsonType(L, gen_to_be_invoked.Representation);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        
        
		
		
		
		
    }
}
