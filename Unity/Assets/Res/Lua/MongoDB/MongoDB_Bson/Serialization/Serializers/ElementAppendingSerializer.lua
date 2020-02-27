-- Generated by CSharp.lua Compiler
--[[ Copyright 2017-present MongoDB Inc.
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
local Linq = System.Linq.Enumerable
local MongoDBBsonIO
local MongoDBBsonSerialization
System.import(function (out)
  MongoDBBsonIO = MongoDB.Bson.IO
  MongoDBBsonSerialization = MongoDB.Bson.Serialization
end)
System.namespace("MongoDB.Bson.Serialization.Serializers", function (namespace)
  -- <summary>
  -- A serializer that serializes a document and appends elements to the end of it.
  -- </summary>
  -- <seealso cref="MongoDB.Bson.Serialization.IBsonSerializer{TDocument}" />
  namespace.class("ElementAppendingSerializer_1", function (namespace)
    return function (TDocument)
      local getValueType, Deserialize, Deserialize1, Serialize, Serialize1, ConfigureElementAppendingContext, __ctor__
      -- <summary>
      -- Initializes a new instance of the <see cref="ElementAppendingSerializer{TDocument}" /> class.
      -- </summary>
      -- <param name="elements">The elements to append.</param>
      -- <param name="writerSettingsConfigurator">The writer settings configurator.</param>
      __ctor__ = function (this, documentSerializer, elements, writerSettingsConfigurator)
        if documentSerializer == nil then
          System.throw(System.ArgumentNullException("documentSerializer" --[[nameof(documentSerializer)]]))
        end
        if elements == nil then
          System.throw(System.ArgumentNullException("elements" --[[nameof(elements)]]))
        end
        this._documentSerializer = documentSerializer
        this._elements = Linq.ToList(elements)
        this._writerSettingsConfigurator = writerSettingsConfigurator
        -- can be null
      end
      getValueType = function (this)
        return System.typeof(TDocument)
      end
      Deserialize = function (this, context, args)
        System.throw(System.NotSupportedException())
      end
      Deserialize1 = function (this, context, args)
        System.throw(System.NotSupportedException())
      end
      Serialize = function (this, context, args, value)
        local writer = context:getWriter()
        local elementAppendingWriter = MongoDBBsonIO.ElementAppendingBsonWriter(writer, this._elements, this._writerSettingsConfigurator)
        local elementAppendingContext = MongoDBBsonSerialization.BsonSerializationContext.CreateRoot(elementAppendingWriter, function (builder)
          ConfigureElementAppendingContext(this, builder, context)
        end)
        this._documentSerializer:Serialize(elementAppendingContext, args:__clone__(), value)
      end
      Serialize1 = function (this, context, args, value)
        Serialize(this, context, args:__clone__(), System.cast(TDocument, value))
      end
      ConfigureElementAppendingContext = function (this, builder, originalContext)
        builder:setIsDynamicType(originalContext:getIsDynamicType())
      end
      return {
        base = function (out)
          return {
            out.MongoDB.Bson.Serialization.IBsonSerializer_1(TDocument)
          }
        end,
        getValueType = getValueType,
        Deserialize = Deserialize,
        Deserialize1 = Deserialize1,
        Serialize = Serialize,
        Serialize1 = Serialize1,
        __ctor__ = __ctor__
      }
    end
  end)
end)
