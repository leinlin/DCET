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
local MongoDBBsonIO
local MongoDBBsonSerialization
local MongoDBSerializers
local MongoDBSerializerHelper
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBBsonIO = MongoDB.Bson.IO
  MongoDBBsonSerialization = MongoDB.Bson.Serialization
  MongoDBSerializers = MongoDB.Bson.Serialization.Serializers
  MongoDBSerializerHelper = MongoDB.Bson.Serialization.Serializers.SerializerHelper
end)
System.namespace("MongoDB.Bson.Serialization.Serializers", function (namespace)
  -- <summary>
  -- Represents a serializer for DateTimeOffsets.
  -- </summary>
  namespace.class("DateTimeOffsetSerializer", function (namespace)
    local getRepresentation, Deserialize, Serialize, WithRepresentation, WithRepresentation1, class, internal, __ctor1__, 
    __ctor2__
    namespace.class("Flags", function (namespace)
      return {}
    end)
    internal = function (this)
      this._int32Serializer = MongoDBSerializers.Int32Serializer()
      this._int64Serializer = MongoDBSerializers.Int64Serializer()
    end
    -- <summary>
    -- Initializes a new instance of the <see cref="DateTimeOffsetSerializer"/> class.
    -- </summary>
    __ctor1__ = function (this)
      __ctor2__(this, 4 --[[BsonType.Array]])
    end
    -- <summary>
    -- Initializes a new instance of the <see cref="DateTimeOffsetSerializer"/> class.
    -- </summary>
    __ctor2__ = function (this, representation)
      internal(this)
      repeat
        local default = representation
        if default == 4 --[[BsonType.Array]] or default == 3 --[[BsonType.Document]] or default == 2 --[[BsonType.String]] then
          break
        else
          local message = System.String.Format("{0} is not a valid representation for a DateTimeOffsetSerializer.", representation)
          System.throw(System.ArgumentException(message))
        end
      until 1

      this._representation = representation

      this._helper = MongoDBSerializers.SerializerHelper(System.Array(MongoDBSerializerHelper.Member)(MongoDBSerializerHelper.Member("DateTime", 1 --[[Flags.DateTime]], false), MongoDBSerializerHelper.Member("Ticks", 2 --[[Flags.Ticks]], false), MongoDBSerializerHelper.Member("Offset", 4 --[[Flags.Offset]], false)))
    end
    getRepresentation = function (this)
      return this._representation
    end
    -- <summary>
    -- Deserializes a value.
    -- </summary>
    -- <param name="args">The deserialization args.</param>
    -- <returns>A deserialized value.</returns>
    Deserialize = function (this, context, args)
      local bsonReader = context:getReader()
      local ticks
      local offset

      local bsonType = bsonReader:GetCurrentBsonType()
      repeat
        local default = bsonType
        if default == 4 --[[BsonType.Array]] then
          bsonReader:ReadStartArray()
          ticks = bsonReader:ReadInt64()
          offset = System.TimeSpan.FromMinutes(bsonReader:ReadInt32())
          bsonReader:ReadEndArray()
          return System.DateTimeOffset(ticks, offset)
        elseif default == 3 --[[BsonType.Document]] then
          ticks = 0
          offset = System.TimeSpan.Zero
          this._helper:DeserializeMembers(context, function (elementName, flag)
            repeat
              local default = flag
              if default == 1 --[[Flags.DateTime]] then
                bsonReader:SkipValue()
                break
              elseif default == 2 --[[Flags.Ticks]] then
                ticks = MongoDBBsonSerialization.IBsonSerializerExtensions.Deserialize1(this._int64Serializer, context, System.Int64)
                break
              elseif default == 4 --[[Flags.Offset]] then
                offset = System.TimeSpan.FromMinutes(MongoDBBsonSerialization.IBsonSerializerExtensions.Deserialize1(this._int32Serializer, context, System.Int32))
                break
              end
            until 1
          end)
          return System.DateTimeOffset(ticks, offset)
        elseif default == 2 --[[BsonType.String]] then
          return MongoDBBsonIO.JsonConvert.ToDateTimeOffset(bsonReader:ReadString())
        else
          System.throw(this:CreateCannotDeserializeFromBsonTypeException(bsonType))
        end
      until 1
    end
    -- <summary>
    -- Serializes a value.
    -- </summary>
    -- <param name="args">The serialization args.</param>
    -- <param name="value">The object.</param>
    Serialize = function (this, context, args, value)
      local bsonWriter = context:getWriter()

      -- note: the DateTime portion cannot be serialized as a BsonType.DateTime because it is NOT in UTC

      repeat
        local default = this._representation
        if default == 4 --[[BsonType.Array]] then
          bsonWriter:WriteStartArray()
          bsonWriter:WriteInt64(value:getTicks())
          bsonWriter:WriteInt32(System.ToInt32(value:getOffset():getTotalMinutes()))
          bsonWriter:WriteEndArray()
          break
        elseif default == 3 --[[BsonType.Document]] then
          bsonWriter:WriteStartDocument()
          MongoDBBsonIO.IBsonWriterExtensions.WriteDateTime(bsonWriter, "DateTime", MongoDBBson.BsonUtils.ToMillisecondsSinceEpoch(value:getUtcDateTime()))
          MongoDBBsonIO.IBsonWriterExtensions.WriteInt64(bsonWriter, "Ticks", value:getTicks())
          MongoDBBsonIO.IBsonWriterExtensions.WriteInt32(bsonWriter, "Offset", System.ToInt32(value:getOffset():getTotalMinutes()))
          bsonWriter:WriteEndDocument()
          break
        elseif default == 2 --[[BsonType.String]] then
          bsonWriter:WriteString(MongoDBBsonIO.JsonConvert.ToString2(value))
          break
        else
          local message = System.String.Format("'{0}' is not a valid DateTimeOffset representation.", this._representation)
          System.throw(System.new(MongoDBBson.BsonSerializationException, 2, message))
        end
      until 1
    end
    -- <summary>
    -- Returns a serializer that has been reconfigured with the specified representation.
    -- </summary>
    -- <returns>The reconfigured serializer.</returns>
    WithRepresentation = function (this, representation)
      if representation == this._representation then
        return this
      else
        return System.new(class, 2, representation)
      end
    end
    WithRepresentation1 = function (this, representation)
      return WithRepresentation(this, representation)
    end
    class = {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.Serializers.StructSerializerBase_1(System.DateTimeOffset),
          out.MongoDB.Bson.Serialization.IRepresentationConfigurable_1(out.MongoDB.Bson.Serialization.Serializers.DateTimeOffsetSerializer)
        }
      end,
      _representation = 0,
      getRepresentation = getRepresentation,
      Deserialize = Deserialize,
      Serialize = Serialize,
      WithRepresentation = WithRepresentation,
      WithRepresentation1 = WithRepresentation1,
      __ctor__ = {
        __ctor1__,
        __ctor2__
      }
    }
    return class
  end)
end)
