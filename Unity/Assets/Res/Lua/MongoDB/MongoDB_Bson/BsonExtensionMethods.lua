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
local SystemIO = System.IO
local MongoDBBson
local MongoDBBsonIO
local MongoDBBsonSerialization
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBBsonIO = MongoDB.Bson.IO
  MongoDBBsonSerialization = MongoDB.Bson.Serialization
end)
System.namespace("MongoDB.Bson", function (namespace)
  -- <summary>
  -- A static class containing BSON extension methods.
  -- </summary>
  namespace.class("BsonExtensionMethods", function (namespace)
    local ToBson, ToBson1, ToBsonDocument, ToBsonDocument1, ToJson, ToJson1
    -- <summary>
    -- Serializes an object to a BSON byte array.
    -- </summary>
    -- <param name="obj">The object.</param>
    -- <param name="serializer">The serializer.</param>
    -- <param name="writerSettings">The writer settings.</param>
    -- <param name="configurator">The serialization context configurator.</param>
    -- <param name="args">The serialization args.</param>
    -- <returns>A BSON byte array.</returns>
    ToBson = function (obj, serializer, writerSettings, configurator, args, TNominalType)
      return ToBson1(obj, System.typeof(TNominalType), writerSettings, serializer, configurator, args:__clone__())
    end
    -- <summary>
    -- Serializes an object to a BSON byte array.
    -- </summary>
    -- <param name="nominalType">The nominal type of the object..</param>
    -- <param name="writerSettings">The writer settings.</param>
    -- <param name="serializer">The serializer.</param>
    -- <param name="configurator">The serialization context configurator.</param>
    -- <param name="args">The serialization args.</param>
    -- <returns>A BSON byte array.</returns>
    -- <exception cref="System.ArgumentNullException">nominalType</exception>
    -- <exception cref="System.ArgumentException">serializer</exception>
    ToBson1 = function (obj, nominalType, writerSettings, serializer, configurator, args)
      if nominalType == nil then
        System.throw(System.ArgumentNullException("nominalType"))
      end

      if serializer == nil then
        serializer = MongoDBBsonSerialization.BsonSerializer.LookupSerializer1(nominalType)
      end
      if serializer:getValueType() ~= nominalType then
        local message = System.String.Format("Serializer type {0} value type does not match document types {1}.", serializer:GetType():getFullName(), nominalType:getFullName())
        System.throw(System.ArgumentException(message, "serializer"))
      end

      local default, extern = System.using(SystemIO.MemoryStream(), function (memoryStream)
        System.using(System.new(MongoDBBsonIO.BsonBinaryWriter, 2, memoryStream, writerSettings or MongoDBBsonIO.BsonBinaryWriterSettings.getDefaults()), function (bsonWriter)
          local context = MongoDBBsonSerialization.BsonSerializationContext.CreateRoot(bsonWriter, configurator)
          args:setNominalType(nominalType)
          serializer:Serialize1(context, args:__clone__(), obj)
        end)
        return true, memoryStream:ToArray()
      end)
      if default then
        return extern
      end
    end
    -- <summary>
    -- Serializes an object to a BsonDocument.
    -- </summary>
    -- <param name="obj">The object.</param>
    -- <param name="serializer">The serializer.</param>
    -- <param name="configurator">The serialization context configurator.</param>
    -- <param name="args">The serialization args.</param>
    -- <returns>A BsonDocument.</returns>
    ToBsonDocument = function (obj, serializer, configurator, args, TNominalType)
      return ToBsonDocument1(obj, System.typeof(TNominalType), serializer, configurator, args:__clone__())
    end
    -- <summary>
    -- Serializes an object to a BsonDocument.
    -- </summary>
    -- <param name="nominalType">The nominal type of the object.</param>
    -- <param name="serializer">The serializer.</param>
    -- <param name="configurator">The serialization context configurator.</param>
    -- <param name="args">The serialization args.</param>
    -- <returns>A BsonDocument.</returns>
    -- <exception cref="System.ArgumentNullException">nominalType</exception>
    -- <exception cref="System.ArgumentException">serializer</exception>
    ToBsonDocument1 = function (obj, nominalType, serializer, configurator, args)
      if nominalType == nil then
        System.throw(System.ArgumentNullException("nominalType"))
      end

      if obj == nil then
        return nil
      end

      if serializer == nil then
        local bsonDocument = System.as(obj, MongoDBBson.BsonDocument)
        if MongoDBBson.BsonDocument.op_Inequality1(bsonDocument, nil) then
          return bsonDocument
          -- it's already a BsonDocument
        end

        local convertibleToBsonDocument = System.as(obj, MongoDBBson.IConvertibleToBsonDocument)
        if convertibleToBsonDocument ~= nil then
          return convertibleToBsonDocument:ToBsonDocument()
          -- use the provided ToBsonDocument method
        end

        serializer = MongoDBBsonSerialization.BsonSerializer.LookupSerializer1(nominalType)
      end
      if serializer:getValueType() ~= nominalType then
        local message = System.String.Format("Serializer type {0} value type does not match document types {1}.", serializer:GetType():getFullName(), nominalType:getFullName())
        System.throw(System.ArgumentException(message, "serializer"))
      end

      -- otherwise serialize into a new BsonDocument
      local document = MongoDBBson.BsonDocument()
      System.using(MongoDBBsonIO.BsonDocumentWriter(document), function (bsonWriter)
        local context = MongoDBBsonSerialization.BsonSerializationContext.CreateRoot(bsonWriter, configurator)
        args:setNominalType(nominalType)
        serializer:Serialize1(context, args:__clone__(), obj)
      end)
      return document
    end
    -- <summary>
    -- Serializes an object to a JSON string.
    -- </summary>
    -- <param name="obj">The object.</param>
    -- <param name="writerSettings">The JsonWriter settings.</param>
    -- <param name="serializer">The serializer.</param>
    -- <param name="configurator">The serializastion context configurator.</param>
    -- <param name="args">The serialization args.</param>
    -- <returns>
    -- A JSON string.
    -- </returns>
    ToJson = function (obj, writerSettings, serializer, configurator, args, TNominalType)
      return ToJson1(obj, System.typeof(TNominalType), writerSettings, serializer, configurator, args:__clone__())
    end
    -- <summary>
    -- Serializes an object to a JSON string.
    -- </summary>
    -- <param name="nominalType">The nominal type of the objectt.</param>
    -- <param name="writerSettings">The JsonWriter settings.</param>
    -- <param name="serializer">The serializer.</param>
    -- <param name="configurator">The serialization context configurator.</param>
    -- <param name="args">The serialization args.</param>
    -- <returns>
    -- A JSON string.
    -- </returns>
    -- <exception cref="System.ArgumentNullException">nominalType</exception>
    -- <exception cref="System.ArgumentException">serializer</exception>
    ToJson1 = function (obj, nominalType, writerSettings, serializer, configurator, args)
      if nominalType == nil then
        System.throw(System.ArgumentNullException("nominalType"))
      end

      if serializer == nil then
        serializer = MongoDBBsonSerialization.BsonSerializer.LookupSerializer1(nominalType)
      end
      if serializer:getValueType() ~= nominalType then
        local message = System.String.Format("Serializer type {0} value type does not match document types {1}.", serializer:GetType():getFullName(), nominalType:getFullName())
        System.throw(System.ArgumentException(message, "serializer"))
      end

      local default, extern = System.using(SystemIO.StringWriter(), function (stringWriter)
        System.using(System.new(MongoDBBsonIO.JsonWriter, 2, stringWriter, writerSettings or MongoDBBsonIO.JsonWriterSettings.getDefaults()), function (bsonWriter)
          local context = MongoDBBsonSerialization.BsonSerializationContext.CreateRoot(bsonWriter, configurator)
          args:setNominalType(nominalType)
          serializer:Serialize1(context, args:__clone__(), obj)
        end)
        return true, stringWriter:ToString()
      end)
      if default then
        return extern
      end
    end
    return {
      ToBson = ToBson,
      ToBson1 = ToBson1,
      ToBsonDocument = ToBsonDocument,
      ToBsonDocument1 = ToBsonDocument1,
      ToJson = ToJson,
      ToJson1 = ToJson1
    }
  end)
end)
