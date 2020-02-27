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
local MongoDBBsonSerialization
local MongoDBSerializers
local BsonValueSerializerBase_1LazyBsonArray
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBBsonSerialization = MongoDB.Bson.Serialization
  MongoDBSerializers = MongoDB.Bson.Serialization.Serializers
  BsonValueSerializerBase_1LazyBsonArray = MongoDBSerializers.BsonValueSerializerBase_1(MongoDBBson.LazyBsonArray)
end)
System.namespace("MongoDB.Bson.Serialization.Serializers", function (namespace)
  -- <summary>
  -- Represents a serializer for LazyBsonArrays.
  -- </summary>
  namespace.class("LazyBsonArraySerializer", function (namespace)
    local DeserializeValue, SerializeValue, __ctor__
    -- <summary>
    -- Initializes a new instance of the <see cref="LazyBsonArraySerializer"/> class.
    -- </summary>
    __ctor__ = function (this)
      BsonValueSerializerBase_1LazyBsonArray.__ctor__(this, 4 --[[BsonType.Array]])
    end
    -- <summary>
    -- Deserializes a value.
    -- </summary>
    -- <param name="args">The deserialization args.</param>
    -- <returns>A deserialized value.</returns>
    DeserializeValue = function (this, context, args)
      local bsonReader = context:getReader()
      local slice = bsonReader:ReadRawBsonArray()
      return MongoDBBson.LazyBsonArray(slice)
    end
    -- <summary>
    -- Serializes a value.
    -- </summary>
    -- <param name="args">The serialization args.</param>
    -- <param name="value">The object.</param>
    SerializeValue = function (this, context, args, value)
      local bsonWriter = context:getWriter()

      local slice = value:getSlice()
      if slice == nil then
        MongoDBBsonSerialization.IBsonSerializerExtensions.Serialize1(MongoDBSerializers.BsonArraySerializer.getInstance(), context, value, MongoDBBson.BsonArray)
      else
        bsonWriter:WriteRawBsonArray(slice)
      end
    end
    return {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.Serializers.BsonValueSerializerBase_1(out.MongoDB.Bson.LazyBsonArray)
        }
      end,
      DeserializeValue = DeserializeValue,
      SerializeValue = SerializeValue,
      __ctor__ = __ctor__
    }
  end)
end)
