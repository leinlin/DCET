-- Generated by CSharp.lua Compiler
--[[ Copyright 2010-present MongoDB Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
]]
local System = System
local MongoDBBson
local MongoDBSerializers
local BsonValueSerializerBase_1BsonSymbol
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBSerializers = MongoDB.Bson.Serialization.Serializers
  BsonValueSerializerBase_1BsonSymbol = MongoDBSerializers.BsonValueSerializerBase_1(MongoDBBson.BsonSymbol)
end)
System.namespace("MongoDB.Bson.Serialization.Serializers", function (namespace)
  -- <summary>
  -- Represents a serializer for BsonSymbols.
  -- </summary>
  namespace.class("BsonSymbolSerializer", function (namespace)
    local __instance, getInstance, DeserializeValue, SerializeValue, class, static, __ctor__
    static = function (this)
      __instance = class()
    end
    -- <summary>
    -- Initializes a new instance of the BsonSymbolSerializer class.
    -- </summary>
    __ctor__ = function (this)
      BsonValueSerializerBase_1BsonSymbol.__ctor__(this, 14 --[[BsonType.Symbol]])
    end
    getInstance = function ()
      return __instance
    end
    -- <summary>
    -- Deserializes a value.
    -- </summary>
    -- <param name="args">The deserialization args.</param>
    -- <returns>A deserialized value.</returns>
    DeserializeValue = function (this, context, args)
      local bsonReader = context:getReader()
      return MongoDBBson.BsonSymbolTable.Lookup(bsonReader:ReadSymbol())
    end
    -- <summary>
    -- Serializes a value.
    -- </summary>
    -- <param name="args">The serialization args.</param>
    -- <param name="value">The object.</param>
    SerializeValue = function (this, context, args, value)
      local bsonWriter = context:getWriter()
      bsonWriter:WriteSymbol(value:getName())
    end
    class = {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.Serializers.BsonValueSerializerBase_1(out.MongoDB.Bson.BsonSymbol)
        }
      end,
      getInstance = getInstance,
      DeserializeValue = DeserializeValue,
      SerializeValue = SerializeValue,
      static = static,
      __ctor__ = __ctor__
    }
    return class
  end)
end)
