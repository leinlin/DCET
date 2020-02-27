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
local MongoDBOptions
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBBsonIO = MongoDB.Bson.IO
  MongoDBOptions = MongoDB.Bson.Serialization.Options
end)
System.namespace("MongoDB.Bson.Serialization.Serializers", function (namespace)
  -- <summary>
  -- Represents a serializer for Doubles.
  -- </summary>
  namespace.class("DoubleSerializer", function (namespace)
    local getConverter, getRepresentation, Deserialize, Serialize, WithConverter, WithRepresentation, WithConverter1, WithRepresentation1, 
    class, __ctor1__, __ctor2__, __ctor3__
    -- <summary>
    -- Initializes a new instance of the <see cref="DoubleSerializer"/> class.
    -- </summary>
    __ctor1__ = function (this)
      __ctor2__(this, 1 --[[BsonType.Double]])
    end
    -- <summary>
    -- Initializes a new instance of the <see cref="DoubleSerializer"/> class.
    -- </summary>
    __ctor2__ = function (this, representation)
      __ctor3__(this, representation, MongoDBOptions.RepresentationConverter(false, false))
    end
    -- <summary>
    -- Initializes a new instance of the <see cref="DoubleSerializer"/> class.
    -- </summary>
    -- <param name="converter">The converter.</param>
    __ctor3__ = function (this, representation, converter)
      repeat
        local default = representation
        if default == 19 --[[BsonType.Decimal128]] or default == 1 --[[BsonType.Double]] or default == 16 --[[BsonType.Int32]] or default == 18 --[[BsonType.Int64]] or default == 2 --[[BsonType.String]] then
          break
        else
          local message = System.String.Format("{0} is not a valid representation for a DoubleSerializer.", representation)
          System.throw(System.ArgumentException(message))
        end
      until 1

      this._representation = representation
      this._converter = converter
    end
    getConverter = function (this)
      return this._converter
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

      local bsonType = bsonReader:GetCurrentBsonType()
      repeat
        local default = bsonType
        if default == 19 --[[BsonType.Decimal128]] then
          return this._converter:ToDouble1(bsonReader:ReadDecimal128())
        elseif default == 1 --[[BsonType.Double]] then
          return bsonReader:ReadDouble()
        elseif default == 16 --[[BsonType.Int32]] then
          return this._converter:ToDouble4(bsonReader:ReadInt32())
        elseif default == 18 --[[BsonType.Int64]] then
          return this._converter:ToDouble5(bsonReader:ReadInt64())
        elseif default == 2 --[[BsonType.String]] then
          return MongoDBBsonIO.JsonConvert.ToDouble(bsonReader:ReadString())
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

      repeat
        local default = this._representation
        if default == 19 --[[BsonType.Decimal128]] then
          bsonWriter:WriteDecimal128(this._converter:ToDecimal1281(value))
          break
        elseif default == 1 --[[BsonType.Double]] then
          bsonWriter:WriteDouble(value)
          break
        elseif default == 16 --[[BsonType.Int32]] then
          bsonWriter:WriteInt32(this._converter:ToInt322(value))
          break
        elseif default == 18 --[[BsonType.Int64]] then
          bsonWriter:WriteInt64(this._converter:ToInt642(value))
          break
        elseif default == 2 --[[BsonType.String]] then
          bsonWriter:WriteString(MongoDBBsonIO.JsonConvert.ToString5(value))
          break
        else
          local message = System.String.Format("'{0}' is not a valid Double representation.", this._representation)
          System.throw(System.new(MongoDBBson.BsonSerializationException, 2, message))
        end
      until 1
    end
    -- <summary>
    -- Returns a serializer that has been reconfigured with the specified item serializer.
    -- </summary>
    -- <returns>The reconfigured serializer.</returns>
    WithConverter = function (this, converter)
      if converter == this._converter then
        return this
      else
        return System.new(class, 3, this._representation, converter)
      end
    end
    -- <summary>
    -- Returns a serializer that has been reconfigured with the specified representation.
    -- </summary>
    -- <returns>The reconfigured serializer.</returns>
    WithRepresentation = function (this, representation)
      if representation == this._representation then
        return this
      else
        return System.new(class, 3, representation, this._converter)
      end
    end
    WithConverter1 = function (this, converter)
      return WithConverter(this, converter)
    end
    WithRepresentation1 = function (this, representation)
      return WithRepresentation(this, representation)
    end
    class = {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.Serializers.StructSerializerBase_1(System.Double),
          out.MongoDB.Bson.Serialization.IRepresentationConfigurable_1(out.MongoDB.Bson.Serialization.Serializers.DoubleSerializer),
          out.MongoDB.Bson.Serialization.IRepresentationConverterConfigurable_1(out.MongoDB.Bson.Serialization.Serializers.DoubleSerializer)
        }
      end,
      _representation = 0,
      getConverter = getConverter,
      getRepresentation = getRepresentation,
      Deserialize = Deserialize,
      Serialize = Serialize,
      WithConverter = WithConverter,
      WithRepresentation = WithRepresentation,
      WithConverter1 = WithConverter1,
      WithRepresentation1 = WithRepresentation1,
      __ctor__ = {
        __ctor1__,
        __ctor2__,
        __ctor3__
      }
    }
    return class
  end)
end)
