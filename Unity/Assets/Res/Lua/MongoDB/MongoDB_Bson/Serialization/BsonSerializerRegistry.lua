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
local SystemConcurrent = System.Collections.Concurrent
local SystemReflection = System.Reflection
local MongoDBBson
local MongoDBBsonSerialization
local ConcurrentDictionary_2TypeIBsonSerializer
local ConcurrentStack_1IBsonSerializationProvider
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBBsonSerialization = MongoDB.Bson.Serialization
  ConcurrentDictionary_2TypeIBsonSerializer = SystemConcurrent.ConcurrentDictionary_2(System.Type, MongoDBBsonSerialization.IBsonSerializer)
  ConcurrentStack_1IBsonSerializationProvider = SystemConcurrent.ConcurrentStack_1(MongoDBBsonSerialization.IBsonSerializationProvider)
end)
System.namespace("MongoDB.Bson.Serialization", function (namespace)
  -- <summary>
  -- Default, global implementation of an <see cref="IBsonSerializerRegistry"/>.
  -- </summary>
  namespace.class("BsonSerializerRegistry", function (namespace)
    local GetSerializer, GetSerializer1, RegisterSerializer, RegisterSerializationProvider, CreateSerializer, __ctor__
    -- <summary>
    -- Initializes a new instance of the <see cref="BsonSerializerRegistry"/> class.
    -- </summary>
    __ctor__ = function (this)
      this._cache = ConcurrentDictionary_2TypeIBsonSerializer()
      this._serializationProviders = ConcurrentStack_1IBsonSerializationProvider()
    end
    -- <summary>
    -- Gets the serializer for the specified <paramref name="type" />.
    -- </summary>
    -- <returns>
    -- The serializer.
    -- </returns>
    GetSerializer = function (this, type)
      if type == nil then
        System.throw(System.ArgumentNullException("type"))
      end
      local typeInfo = SystemReflection.IntrospectionExtensions.GetTypeInfo(type)
      if typeInfo:getIsGenericType() and typeInfo:getContainsGenericParameters() then
        local message = System.String.Format("Generic type {0} has unassigned type parameters.", MongoDBBson.BsonUtils.GetFriendlyTypeName(type))
        System.throw(System.ArgumentException(message, "type"))
      end

      return this._cache:GetOrAdd(type, System.fn(this, CreateSerializer))
    end
    -- <summary>
    -- Gets the serializer for the specified <typeparamref name="T" />.
    -- </summary>
    -- <returns>
    -- The serializer.
    -- </returns>
    GetSerializer1 = function (this, T)
      return System.cast(MongoDBBsonSerialization.IBsonSerializer_1(T), GetSerializer(this, System.typeof(T)))
    end
    -- <summary>
    -- Registers the serializer.
    -- </summary>
    -- <param name="serializer">The serializer.</param>
    RegisterSerializer = function (this, type, serializer)
      if type == nil then
        System.throw(System.ArgumentNullException("type"))
      end
      if serializer == nil then
        System.throw(System.ArgumentNullException("serializer"))
      end
      local typeInfo = SystemReflection.IntrospectionExtensions.GetTypeInfo(type)
      if SystemReflection.IntrospectionExtensions.GetTypeInfo(System.typeof(MongoDBBson.BsonValue)):IsAssignableFrom(type) then
        local message = System.String.Format("A serializer cannot be registered for type {0} because it is a subclass of BsonValue.", MongoDBBson.BsonUtils.GetFriendlyTypeName(type))
        System.throw(System.new(MongoDBBson.BsonSerializationException, 2, message))
      end
      if typeInfo:getIsGenericType() and typeInfo:getContainsGenericParameters() then
        local message = System.String.Format("Generic type {0} has unassigned type parameters.", MongoDBBson.BsonUtils.GetFriendlyTypeName(type))
        System.throw(System.ArgumentException(message, "type"))
      end

      if not this._cache:TryAdd(type, serializer) then
        local message = System.String.Format("There is already a serializer registered for type {0}.", MongoDBBson.BsonUtils.GetFriendlyTypeName(type))
        System.throw(System.new(MongoDBBson.BsonSerializationException, 2, message))
      end
    end
    -- <summary>
    -- Registers the serialization provider. This behaves like a stack, so the
    -- last provider registered is the first provider consulted.
    -- </summary>
    RegisterSerializationProvider = function (this, serializationProvider)
      if serializationProvider == nil then
        System.throw(System.ArgumentNullException("serializationProvider"))
      end

      this._serializationProviders:Push(serializationProvider)
    end
    CreateSerializer = function (this, type)
      for _, serializationProvider in System.each(this._serializationProviders) do
        local serializer

        local registryAwareSerializationProvider = System.as(serializationProvider, MongoDBBsonSerialization.IRegistryAwareBsonSerializationProvider)
        if registryAwareSerializationProvider ~= nil then
          serializer = registryAwareSerializationProvider:GetSerializer1(type, this)
        else
          serializer = serializationProvider:GetSerializer(type)
        end

        if serializer ~= nil then
          return serializer
        end
      end

      local message = System.String.Format("No serializer found for type {0}.", type:getFullName())
      System.throw(System.new(MongoDBBson.BsonSerializationException, 2, message))
    end
    return {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.IBsonSerializerRegistry
        }
      end,
      GetSerializer = GetSerializer,
      GetSerializer1 = GetSerializer1,
      RegisterSerializer = RegisterSerializer,
      RegisterSerializationProvider = RegisterSerializationProvider,
      __ctor__ = __ctor__
    }
  end)
end)
