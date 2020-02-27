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
System.import(function (out)
  MongoDBBson = MongoDB.Bson
end)
System.namespace("MongoDB.Bson.Serialization.Serializers", function (namespace)
  -- <summary>
  -- Represents an abstract base class for serializers.
  -- </summary>
  namespace.class("SerializerBase_1", function (namespace)
    return function (TValue)
      local getValueType, Deserialize, Serialize, CreateCannotBeDeserializedException, CreateCannotBeSerializedException, CreateCannotDeserializeFromBsonTypeException, EnsureBsonTypeEquals, Deserialize1, 
      Serialize1
      getValueType = function (this)
        return System.typeof(TValue)
      end
      -- <summary>
      -- Deserializes a value.
      -- </summary>
      -- <param name="args">The deserialization args.</param>
      -- <returns>A deserialized value.</returns>
      Deserialize = function (this, context, args)
        System.throw(CreateCannotBeDeserializedException(this))
      end
      -- <summary>
      -- Serializes a value.
      -- </summary>
      -- <param name="args">The serialization args.</param>
      -- <param name="value">The value.</param>
      Serialize = function (this, context, args, value)
        System.throw(CreateCannotBeSerializedException(this))
      end
      -- <summary>
      -- Creates an exception to throw when a type cannot be deserialized.
      -- </summary>
      CreateCannotBeDeserializedException = function (this)
        local message = System.String.Format("Values of type '{0}' cannot be deserialized using a serializer of type '{1}'.", MongoDBBson.BsonUtils.GetFriendlyTypeName(System.typeof(TValue)), MongoDBBson.BsonUtils.GetFriendlyTypeName(this:GetType()))
        return System.NotSupportedException(message)
      end
      -- <summary>
      -- Creates an exception to throw when a type cannot be deserialized.
      -- </summary>
      CreateCannotBeSerializedException = function (this)
        local message = System.String.Format("Values of type '{0}' cannot be serialized using a serializer of type '{1}'.", MongoDBBson.BsonUtils.GetFriendlyTypeName(System.typeof(TValue)), MongoDBBson.BsonUtils.GetFriendlyTypeName(this:GetType()))
        return System.NotSupportedException(message)
      end
      -- <summary>
      -- Creates an exception to throw when a type cannot be deserialized from a BsonType.
      -- </summary>
      -- <returns>An exception.</returns>
      CreateCannotDeserializeFromBsonTypeException = function (this, bsonType)
        local message = System.String.Format("Cannot deserialize a '{0}' from BsonType '{1}'.", MongoDBBson.BsonUtils.GetFriendlyTypeName(getValueType(this)), bsonType)
        return System.FormatException(message)
      end
      -- <summary>
      -- Ensures that the BsonType equals the expected type.
      -- </summary>
      -- <param name="bsonType">The expected type.</param>
      EnsureBsonTypeEquals = function (this, reader, bsonType)
        if reader:GetCurrentBsonType() ~= bsonType then
          System.throw(CreateCannotDeserializeFromBsonTypeException(this, reader:GetCurrentBsonType()))
        end
      end
      Deserialize1 = function (this, context, args)
        return this:Deserialize(context, args:__clone__())
      end
      Serialize1 = function (this, context, args, value)
        this:Serialize(context, args:__clone__(), System.cast(TValue, value))
      end
      return {
        base = function (out)
          return {
            out.MongoDB.Bson.Serialization.IBsonSerializer_1(TValue)
          }
        end,
        getValueType = getValueType,
        Deserialize = Deserialize,
        Serialize = Serialize,
        CreateCannotBeDeserializedException = CreateCannotBeDeserializedException,
        CreateCannotBeSerializedException = CreateCannotBeSerializedException,
        CreateCannotDeserializeFromBsonTypeException = CreateCannotDeserializeFromBsonTypeException,
        EnsureBsonTypeEquals = EnsureBsonTypeEquals,
        Deserialize1 = Deserialize1,
        Serialize1 = Serialize1
      }
    end
  end)
end)
