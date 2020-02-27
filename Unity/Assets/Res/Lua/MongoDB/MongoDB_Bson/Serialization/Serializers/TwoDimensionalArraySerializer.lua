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
local MongoDBBsonSerialization
System.import(function (out)
  MongoDBBsonSerialization = MongoDB.Bson.Serialization
end)
System.namespace("MongoDB.Bson.Serialization.Serializers", function (namespace)
  -- <summary>
  -- Represents a serializer for two-dimensional arrays.
  -- </summary>
  namespace.class("TwoDimensionalArraySerializer_1", function (namespace)
    return function (TItem)
      local getItemSerializer, DeserializeValue, SerializeValue, WithItemSerializer, getChildSerializer, WithChildSerializer, class, __ctor1__, 
      __ctor2__, __ctor3__
      local ListTItem = System.List(TItem)
      local ArrayTItem2 = System.Array(TItem, 2)
      local ListListTItem = System.List(ListTItem)
      local IBsonSerializer_1TItem = MongoDB.Bson.Serialization.IBsonSerializer_1(TItem)
      local LazyIBsonSerializer_1TItem = System.Lazy(IBsonSerializer_1TItem)
      -- <summary>
      -- Initializes a new instance of the <see cref="TwoDimensionalArraySerializer{TItem}"/> class.
      -- </summary>
      __ctor1__ = function (this)
        __ctor3__(this, MongoDBBsonSerialization.BsonSerializer.getSerializerRegistry())
      end
      -- <summary>
      -- Initializes a new instance of the <see cref="TwoDimensionalArraySerializer{TItem}"/> class.
      -- </summary>
      __ctor2__ = function (this, itemSerializer)
        if itemSerializer == nil then
          System.throw(System.ArgumentNullException("itemSerializer"))
        end

        this._lazyItemSerializer = LazyIBsonSerializer_1TItem(function ()
          return itemSerializer
        end)
      end
      -- <summary>
      -- Initializes a new instance of the <see cref="TwoDimensionalArraySerializer{TItem}" /> class.
      -- </summary>
      __ctor3__ = function (this, serializerRegistry)
        if serializerRegistry == nil then
          System.throw(System.ArgumentNullException("serializerRegistry"))
        end

        this._lazyItemSerializer = LazyIBsonSerializer_1TItem(function ()
          return serializerRegistry:GetSerializer1(TItem)
        end)
      end
      getItemSerializer = function (this)
        return this._lazyItemSerializer:getValue()
      end
      -- <summary>
      -- Deserializes a value.
      -- </summary>
      -- <param name="args">The deserialization args.</param>
      -- <returns>A deserialized value.</returns>
      DeserializeValue = function (this, context, args)
        local bsonReader = context:getReader()
        this:EnsureBsonTypeEquals(bsonReader, 4 --[[BsonType.Array]])

        bsonReader:ReadStartArray()
        local outerList = ListListTItem()
        while bsonReader:ReadBsonType() ~= 0 --[[BsonType.EndOfDocument]] do
          bsonReader:ReadStartArray()
          local innerList = ListTItem()
          while bsonReader:ReadBsonType() ~= 0 --[[BsonType.EndOfDocument]] do
            innerList:Add(MongoDBBsonSerialization.IBsonSerializerExtensions.Deserialize1(this._lazyItemSerializer:getValue(), context, TItem))
          end
          bsonReader:ReadEndArray()
          outerList:Add(innerList)
        end
        bsonReader:ReadEndArray()

        local length1 = #outerList
        local length2 = (length1 == 0) and 0 or #outerList:get(0)
        local array = ArrayTItem2({ length1, length2 })

        for i = 0, length1 - 1 do
          local innerList = outerList:get(i)
          if #innerList ~= length2 then
            local message = System.String.Format("Inner list {0} is of length {1} but should be of length {2}.", i, #innerList, length2)
            System.throw(System.FormatException(message))
          end
          for j = 0, length2 - 1 do
            array:set(i, j, innerList:get(j))
          end
        end

        return array
      end
      -- <summary>
      -- Serializes a value.
      -- </summary>
      -- <param name="args">The serialization args.</param>
      -- <param name="value">The object.</param>
      SerializeValue = function (this, context, args, value)
        local bsonWriter = context:getWriter()

        local length1 = value:GetLength(0)
        local length2 = value:GetLength(1)

        bsonWriter:WriteStartArray()
        for i = 0, length1 - 1 do
          bsonWriter:WriteStartArray()
          for j = 0, length2 - 1 do
            MongoDBBsonSerialization.IBsonSerializerExtensions.Serialize1(this._lazyItemSerializer:getValue(), context, value:get(i, j), TItem)
          end
          bsonWriter:WriteEndArray()
        end
        bsonWriter:WriteEndArray()
      end
      -- <summary>
      -- Returns a serializer that has been reconfigured with the specified item serializer.
      -- </summary>
      -- <returns>The reconfigured serializer.</returns>
      WithItemSerializer = function (this, itemSerializer)
        return System.new(class, 2, itemSerializer)
      end
      getChildSerializer = function (this)
        return getItemSerializer(this)
      end
      WithChildSerializer = function (this, childSerializer)
        return WithItemSerializer(this, System.cast(IBsonSerializer_1TItem, childSerializer))
      end
      class = {
        base = function (out)
          return {
            out.MongoDB.Bson.Serialization.Serializers.SealedClassSerializerBase_1(System.Array(TItem, 2)),
            out.MongoDB.Bson.Serialization.IChildSerializerConfigurable
          }
        end,
        getItemSerializer = getItemSerializer,
        DeserializeValue = DeserializeValue,
        SerializeValue = SerializeValue,
        WithItemSerializer = WithItemSerializer,
        getChildSerializer = getChildSerializer,
        WithChildSerializer = WithChildSerializer,
        __ctor__ = {
          __ctor1__,
          __ctor2__,
          __ctor3__
        }
      }
      return class
    end
  end)
end)
