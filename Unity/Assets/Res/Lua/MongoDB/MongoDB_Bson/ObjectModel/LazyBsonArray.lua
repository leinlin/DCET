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
local ListIDisposable = System.List(System.IDisposable)
local MongoDBBson
local MongoDBBsonIO
local MongoDBBsonSerialization
local MongoDBSerializers
local ListBsonValue
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBBsonIO = MongoDB.Bson.IO
  MongoDBBsonSerialization = MongoDB.Bson.Serialization
  MongoDBSerializers = MongoDB.Bson.Serialization.Serializers
  ListBsonValue = System.List(MongoDBBson.BsonValue)
end)
System.namespace("MongoDB.Bson", function (namespace)
  -- <summary>
  -- Represents a BSON array that is deserialized lazily.
  -- </summary>
  namespace.class("LazyBsonArray", function (namespace)
    local getSlice, Clone, DeepClone, Dispose1, Materialize, MaterializeCompleted, CloneSlice, DeserializeLazyBsonArray, 
    DeserializeLazyBsonDocument, MaterializeThisLevel, class, __ctor__
    -- <summary>
    -- Initializes a new instance of the <see cref="LazyBsonArray"/> class.
    -- </summary>
    -- <exception cref="System.ArgumentNullException">slice</exception>
    -- <exception cref="System.ArgumentException">LazyBsonArray cannot be used with an IByteBuffer that needs disposing.</exception>
    __ctor__ = function (this, slice)
      this._disposableItems = ListIDisposable()
      this._readerSettings = MongoDBBsonIO.BsonBinaryReaderSettings.getDefaults()
      MongoDBBson.MaterializedOnDemandBsonArray.__ctor__(this)
      if slice == nil then
        System.throw(System.ArgumentNullException("slice"))
      end

      this._slice = slice
    end
    getSlice = function (this)
      return this._slice
    end
    -- <summary>
    -- Creates a shallow clone of the array (see also DeepClone).
    -- </summary>
    Clone = function (this)
      if this._slice ~= nil then
        return class(CloneSlice(this))
      else
        return MongoDBBson.MaterializedOnDemandBsonArray.Clone(this)
      end
    end
    -- <summary>
    -- Creates a deep clone of the array (see also Clone).
    -- </summary>
    DeepClone = function (this)
      if this._slice ~= nil then
        return class(CloneSlice(this))
      else
        return MongoDBBson.MaterializedOnDemandBsonArray.Clone(this)
      end
    end
    -- <summary>
    -- Releases unmanaged and - optionally - managed resources.
    -- </summary>
    Dispose1 = function (this, disposing)
      if not this:getIsDisposed() then
        if disposing then
          if this._slice ~= nil then
            this._slice:Dispose()
            this._slice = nil
          end
          if this._disposableItems ~= nil then
            this._disposableItems:ForEach(function (x)
              x:Dispose()
            end)
            this._disposableItems = nil
          end
        end
      end
      MongoDBBson.MaterializedOnDemandBsonArray.Dispose1(this, disposing)
    end
    -- <summary>
    -- Materializes the BsonArray.
    -- </summary>
    -- The materialized values.
    -- </returns>
    Materialize = function (this)
      return MaterializeThisLevel(this)
    end
    -- <summary>
    -- Informs subclasses that the Materialize process completed so they can free any resources related to the unmaterialized state.
    -- </summary>
    MaterializeCompleted = function (this)
      local slice = this._slice
      this._slice = nil
      slice:Dispose()
    end
    CloneSlice = function (this)
      return this._slice:GetSlice(0, this._slice:getLength())
    end
    DeserializeLazyBsonArray = function (this, bsonReader)
      local slice = bsonReader:ReadRawBsonArray()
      local nestedArray = class(slice)
      this._disposableItems:Add(nestedArray)
      return nestedArray
    end
    DeserializeLazyBsonDocument = function (this, bsonReader)
      local slice = bsonReader:ReadRawBsonDocument()
      local nestedDocument = MongoDBBson.LazyBsonDocument(slice)
      this._disposableItems:Add(nestedDocument)
      return nestedDocument
    end
    MaterializeThisLevel = function (this)
      local values = ListBsonValue()

      System.using(MongoDBBsonIO.ByteBufferStream(this._slice, false), function (stream)
        System.using(System.new(MongoDBBsonIO.BsonBinaryReader, 2, stream, this._readerSettings), function (bsonReader)
          local context = MongoDBBsonSerialization.BsonDeserializationContext.CreateRoot(bsonReader)

          bsonReader:ReadStartDocument()
          local bsonType
          while true do
            bsonType = bsonReader:ReadBsonType()
            if not (bsonType ~= 0 --[[BsonType.EndOfDocument]]) then
              break
            end
            bsonReader:SkipName()
            local value
            repeat
              local default = bsonType
              if default == 4 --[[BsonType.Array]] then
                value = DeserializeLazyBsonArray(this, bsonReader)
                break
              elseif default == 3 --[[BsonType.Document]] then
                value = DeserializeLazyBsonDocument(this, bsonReader)
                break
              else
                value = MongoDBBsonSerialization.IBsonSerializerExtensions.Deserialize1(MongoDBSerializers.BsonValueSerializer.getInstance(), context, MongoDBBson.BsonValue)
                break
              end
            until 1
            values:Add(value)
          end
          bsonReader:ReadEndDocument()
        end)
      end)

      return values
    end
    class = {
      base = function (out)
        return {
          out.MongoDB.Bson.MaterializedOnDemandBsonArray
        }
      end,
      getSlice = getSlice,
      Clone = Clone,
      DeepClone = DeepClone,
      Dispose1 = Dispose1,
      Materialize = Materialize,
      MaterializeCompleted = MaterializeCompleted,
      __ctor__ = __ctor__,
      __metadata__ = function (out)
        return {
          class = { 0x6, System.new(out.MongoDB.Bson.Serialization.Attributes.BsonSerializerAttribute, 2, System.typeof(MongoDBSerializers.LazyBsonArraySerializer)) }
        }
      end
    }
    return class
  end)
end)
