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
local Linq = System.Linq.Enumerable
local SystemDynamic = System.Dynamic
local SystemReflection = System.Reflection
local ListType = System.List(System.Type)
local ArrayType = System.Array(System.Type)
local DictTypeType = System.Dictionary(System.Type, System.Type)
local MongoDBBson
local MongoDBSerializers
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBSerializers = MongoDB.Bson.Serialization.Serializers
end)
System.namespace("MongoDB.Bson.Serialization", function (namespace)
  -- <summary>
  -- Provides serializers for collections.
  -- </summary>
  namespace.class("CollectionsSerializationProvider", function (namespace)
    local __serializerTypes, IsOrIsChildOf, GetSerializer1, GetCollectionSerializer, GetImplementedInterfaces, GetReadOnlyDictionarySerializer, static
    static = function (this)
      local default = DictTypeType()
      default:AddKeyValue(System.typeof(System.BitArray), System.typeof(MongoDBSerializers.BitArraySerializer))
      default:AddKeyValue(System.typeof(SystemDynamic.ExpandoObject), System.typeof(MongoDBSerializers.ExpandoObjectSerializer))
      default:AddKeyValue(System.typeof(queue), System.typeof(MongoDBSerializers.QueueSerializer))
      default:AddKeyValue(System.typeof(stack), System.typeof(MongoDBSerializers.StackSerializer))
      default:AddKeyValue(System.typeof(System.Queue), System.typeof(MongoDBSerializers.QueueSerializer_1))
      default:AddKeyValue(System.typeof(System.ReadOnlyCollection), System.typeof(MongoDBSerializers.ReadOnlyCollectionSerializer_1))
      default:AddKeyValue(System.typeof(System.Stack), System.typeof(MongoDBSerializers.StackSerializer_1))
      __serializerTypes = default
    end
    IsOrIsChildOf = function (type, parent)
      return type == parent or (type ~= nil) and (type ~= System.typeof(System.Object) and IsOrIsChildOf(SystemReflection.IntrospectionExtensions.GetTypeInfo(type):getBaseType(), parent))
    end
    GetSerializer1 = function (this, type, serializerRegistry)
      if type == nil then
        System.throw(System.ArgumentNullException("type"))
      end
      local typeInfo = SystemReflection.IntrospectionExtensions.GetTypeInfo(type)
      if typeInfo:getIsGenericType() and typeInfo:getContainsGenericParameters() then
        local message = System.String.Format("Generic type {0} has unassigned type parameters.", MongoDBBson.BsonUtils.GetFriendlyTypeName(type))
        System.throw(System.ArgumentException(message, "type"))
      end

      local serializerType
      local default
      default, serializerType = __serializerTypes:TryGetValue(type)
      if default then
        return this:CreateSerializer1(serializerType, serializerRegistry)
      end

      if typeInfo:getIsGenericType() and not typeInfo:getContainsGenericParameters() then
        local serializerTypeDefinition
        local extern
        extern, serializerTypeDefinition = __serializerTypes:TryGetValue(type:GetGenericTypeDefinition())
        if extern then
          return this:CreateGenericSerializer1(serializerTypeDefinition, SystemReflection.IntrospectionExtensions.GetTypeInfo(type):GetGenericArguments(), serializerRegistry)
        end
      end

      if type:getIsArray() then
        local elementType = type:GetElementType()
        repeat
          local extern = type:GetArrayRank()
          if extern == 1 then
            local arraySerializerDefinition = System.typeof(MongoDBSerializers.ArraySerializer_1)
            return this:CreateGenericSerializer1(arraySerializerDefinition, ArrayType(elementType), serializerRegistry)
          elseif extern == 2 then
            local twoDimensionalArraySerializerDefinition = System.typeof(MongoDBSerializers.TwoDimensionalArraySerializer_1)
            return this:CreateGenericSerializer1(twoDimensionalArraySerializerDefinition, ArrayType(elementType), serializerRegistry)
          elseif extern == 3 then
            local threeDimensionalArraySerializerDefinition = System.typeof(MongoDBSerializers.ThreeDimensionalArraySerializer_1)
            return this:CreateGenericSerializer1(threeDimensionalArraySerializerDefinition, ArrayType(elementType), serializerRegistry)
          else
            local message = System.String.Format("No serializer found for array for rank {0}.", type:GetArrayRank())
            System.throw(System.new(MongoDBBson.BsonSerializationException, 2, message))
          end
        until 1
      end

      local readOnlyDictionarySerializer = GetReadOnlyDictionarySerializer(this, type, serializerRegistry)
      if readOnlyDictionarySerializer ~= nil then
        return readOnlyDictionarySerializer
      end

      return GetCollectionSerializer(this, type, serializerRegistry)
    end
    GetCollectionSerializer = function (this, type, serializerRegistry)
      local implementedGenericDictionaryInterface = nil
      local implementedGenericEnumerableInterface = nil
      local implementedGenericSetInterface = nil
      local implementedDictionaryInterface = nil
      local implementedEnumerableInterface = nil

      local implementedInterfaces = ListType(SystemReflection.IntrospectionExtensions.GetTypeInfo(type):GetInterfaces())
      local typeInfo = SystemReflection.IntrospectionExtensions.GetTypeInfo(type)
      if typeInfo:getIsInterface() then
        implementedInterfaces:Add(type)
      end

      for _, implementedInterface in System.each(implementedInterfaces) do
        local implementedInterfaceTypeInfo = SystemReflection.IntrospectionExtensions.GetTypeInfo(implementedInterface)
        if implementedInterfaceTypeInfo:getIsGenericType() then
          local genericInterfaceDefinition = implementedInterface:GetGenericTypeDefinition()
          if genericInterfaceDefinition == System.typeof(System.IDictionary_2) then
            implementedGenericDictionaryInterface = implementedInterface
          end
          if genericInterfaceDefinition == System.typeof(System.IEnumerable_1) then
            implementedGenericEnumerableInterface = implementedInterface
          end
          if genericInterfaceDefinition == System.typeof(System.ISet_1) then
            implementedGenericSetInterface = implementedInterface
          end
        else
          if implementedInterface == System.typeof(System.IDictionary) then
            implementedDictionaryInterface = implementedInterface
          end
          if implementedInterface == System.typeof(System.IEnumerable) then
            implementedEnumerableInterface = implementedInterface
          end
        end
      end

      -- the order of the tests is important
      if implementedGenericDictionaryInterface ~= nil then
        local keyType = SystemReflection.IntrospectionExtensions.GetTypeInfo(implementedGenericDictionaryInterface):GetGenericArguments():get(0)
        local valueType = SystemReflection.IntrospectionExtensions.GetTypeInfo(implementedGenericDictionaryInterface):GetGenericArguments():get(1)
        if typeInfo:getIsInterface() then
          local dictionaryDefinition = System.typeof(System.Dictionary)
          local dictionaryType = dictionaryDefinition:MakeGenericType(keyType, valueType)
          local serializerDefinition = System.typeof(MongoDBSerializers.ImpliedImplementationInterfaceSerializer_2)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type, dictionaryType), serializerRegistry)
        else
          local serializerDefinition = System.typeof(MongoDBSerializers.DictionaryInterfaceImplementerSerializer_3)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type, keyType, valueType), serializerRegistry)
        end
      elseif implementedDictionaryInterface ~= nil then
        if typeInfo:getIsInterface() then
          local dictionaryType = System.typeof(System.Hashtable)
          local serializerDefinition = System.typeof(MongoDBSerializers.ImpliedImplementationInterfaceSerializer_2)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type, dictionaryType), serializerRegistry)
        else
          local serializerDefinition = System.typeof(MongoDBSerializers.DictionaryInterfaceImplementerSerializer_1)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type), serializerRegistry)
        end
      elseif implementedGenericSetInterface ~= nil then
        local itemType = SystemReflection.IntrospectionExtensions.GetTypeInfo(implementedGenericSetInterface):GetGenericArguments():get(0)

        if typeInfo:getIsInterface() then
          local hashSetDefinition = System.typeof(System.HashSet)
          local hashSetType = hashSetDefinition:MakeGenericType(itemType)
          local serializerDefinition = System.typeof(MongoDBSerializers.ImpliedImplementationInterfaceSerializer_2)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type, hashSetType), serializerRegistry)
        else
          local serializerDefinition = System.typeof(MongoDBSerializers.EnumerableInterfaceImplementerSerializer_2)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type, itemType), serializerRegistry)
        end
      elseif implementedGenericEnumerableInterface ~= nil then
        local itemType = SystemReflection.IntrospectionExtensions.GetTypeInfo(implementedGenericEnumerableInterface):GetGenericArguments():get(0)

        local readOnlyCollectionType = System.typeof(System.ReadOnlyCollection):MakeGenericType(itemType)
        if type == readOnlyCollectionType then
          local serializerDefinition = System.typeof(MongoDBSerializers.ReadOnlyCollectionSerializer_1)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(itemType), serializerRegistry)
        elseif SystemReflection.IntrospectionExtensions.GetTypeInfo(readOnlyCollectionType):IsAssignableFrom(type) then
          local serializerDefinition = System.typeof(MongoDBSerializers.ReadOnlyCollectionSubclassSerializer_2)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type, itemType), serializerRegistry)
        elseif typeInfo:getIsInterface() then
          local listDefinition = System.typeof(System.List)
          local listType = listDefinition:MakeGenericType(itemType)
          local serializerDefinition = System.typeof(MongoDBSerializers.ImpliedImplementationInterfaceSerializer_2)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type, listType), serializerRegistry)
        else
          local serializerDefinition = System.typeof(MongoDBSerializers.EnumerableInterfaceImplementerSerializer_2)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type, itemType), serializerRegistry)
        end
      elseif implementedEnumerableInterface ~= nil then
        if typeInfo:getIsInterface() then
          local listType = System.typeof(System.ArrayList)
          local serializerDefinition = System.typeof(MongoDBSerializers.ImpliedImplementationInterfaceSerializer_2)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type, listType), serializerRegistry)
        else
          local serializerDefinition = System.typeof(MongoDBSerializers.EnumerableInterfaceImplementerSerializer_1)
          return this:CreateGenericSerializer1(serializerDefinition, ArrayType(type), serializerRegistry)
        end
      end

      return nil
    end
    GetImplementedInterfaces = function (this, type)
      local default
      if SystemReflection.IntrospectionExtensions.GetTypeInfo(type):getIsInterface() then
        default = Linq.ToList(Linq.Concat(SystemReflection.IntrospectionExtensions.GetTypeInfo(type):GetInterfaces(), ArrayType(type)))
      else
        default = Linq.ToList(SystemReflection.IntrospectionExtensions.GetTypeInfo(type):GetInterfaces())
      end
      return default
    end
    GetReadOnlyDictionarySerializer = function (this, type, serializerRegistry)
      local typeInfo = SystemReflection.IntrospectionExtensions.GetTypeInfo(type)
      if not typeInfo:getIsGenericType() or typeInfo:getIsGenericTypeDefinition() or #typeInfo:GetGenericArguments() ~= 2 then
        return nil
      end

      local keyType = typeInfo:GetGenericArguments():get(0)
      local valueType = typeInfo:GetGenericArguments():get(1)
      local typeIsIReadOnlyDictionary = type == System.typeof(System.IReadOnlyDictionary_2):MakeGenericType(keyType, valueType)
      local typeIsOrIsChildOfReadOnlyDictionary = IsOrIsChildOf(type, System.typeof(System.ReadOnlyDictionary_2):MakeGenericType(keyType, valueType))

      local implementedInterfaces = GetImplementedInterfaces(this, type)
      local genericImplementedInterfaces = Linq.Where(implementedInterfaces, function (ii)
        return SystemReflection.IntrospectionExtensions.GetTypeInfo(ii):getIsGenericType()
      end)
      local genericImplementedInterfaceDefinitions = Linq.ToArray(Linq.Select(genericImplementedInterfaces, function (i)
        return i:GetGenericTypeDefinition()
      end, System.Type))
      local implementsGenericReadOnlyDictionaryInterface = Linq.Contains(genericImplementedInterfaceDefinitions, System.typeof(System.IReadOnlyDictionary_2))
      local implementsGenericDictionaryInterface = Linq.Contains(genericImplementedInterfaceDefinitions, System.typeof(System.IDictionary_2))

      if typeIsIReadOnlyDictionary then
        return this:CreateGenericSerializer1(System.typeof(MongoDBSerializers.ImpliedImplementationInterfaceSerializer_2), ArrayType(type, System.typeof(System.ReadOnlyDictionary_2):MakeGenericType(keyType, valueType)), serializerRegistry)
      end

      if typeIsOrIsChildOfReadOnlyDictionary or (not typeInfo:getIsInterface() and implementsGenericReadOnlyDictionaryInterface and not implementsGenericDictionaryInterface) then
        return this:CreateGenericSerializer1(System.typeof(MongoDBSerializers.ReadOnlyDictionaryInterfaceImplementerSerializer_3), ArrayType(type, keyType, valueType), serializerRegistry)
      end

      return nil
    end
    return {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.BsonSerializationProviderBase
        }
      end,
      GetSerializer1 = GetSerializer1,
      static = static
    }
  end)
end)
