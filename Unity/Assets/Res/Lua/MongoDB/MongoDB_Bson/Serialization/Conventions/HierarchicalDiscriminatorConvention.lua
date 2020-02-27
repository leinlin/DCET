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
local MongoDBBson
local MongoDBBsonSerialization
local MongoDBConventions
local ListBsonValue
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBBsonSerialization = MongoDB.Bson.Serialization
  MongoDBConventions = MongoDB.Bson.Serialization.Conventions
  ListBsonValue = System.List(MongoDBBson.BsonValue)
end)
System.namespace("MongoDB.Bson.Serialization.Conventions", function (namespace)
  -- <summary>
  -- Represents a discriminator convention where the discriminator is an array of all the discriminators provided by the class maps of the root class down to the actual type.
  -- </summary>
  namespace.class("HierarchicalDiscriminatorConvention", function (namespace)
    local GetDiscriminator, __ctor__
    -- <summary>
    -- Initializes a new instance of the HierarchicalDiscriminatorConvention class.
    -- </summary>
    __ctor__ = function (this, elementName)
      MongoDBConventions.StandardDiscriminatorConvention.__ctor__(this, elementName)
    end
    -- <summary>
    -- Gets the discriminator value for an actual type.
    -- </summary>
    -- <param name="actualType">The actual type.</param>
    -- <returns>The discriminator value.</returns>
    GetDiscriminator = function (this, nominalType, actualType)
      -- TODO: this isn't quite right, not all classes are serialized using  a class map serializer
      local classMap = MongoDBBsonSerialization.BsonClassMap.LookupClassMap(actualType)
      if actualType ~= nominalType or classMap:getDiscriminatorIsRequired() or classMap:getHasRootClass() then
        if classMap:getHasRootClass() and not classMap:getIsRootClass() then
          local values = ListBsonValue()
          do
            while not classMap:getIsRootClass() do
              values:Add(MongoDBBson.BsonValue.op_Implicit21(classMap:getDiscriminator()))
              classMap = classMap:getBaseClassMap()
            end
          end
          values:Add(MongoDBBson.BsonValue.op_Implicit21(classMap:getDiscriminator()))
          -- add the root class's discriminator
          return System.new(MongoDBBson.BsonArray, 3, Linq.Reverse(values))
          -- reverse to put leaf class last
        else
          return MongoDBBson.BsonValue.op_Implicit21(classMap:getDiscriminator())
        end
      end

      return nil
    end
    return {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.Conventions.StandardDiscriminatorConvention
        }
      end,
      GetDiscriminator = GetDiscriminator,
      __ctor__ = __ctor__
    }
  end)
end)
