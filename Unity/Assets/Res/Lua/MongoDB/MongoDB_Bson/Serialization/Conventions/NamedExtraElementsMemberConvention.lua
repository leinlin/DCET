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
local SystemReflection = System.Reflection
local ArrayString = System.Array(System.String)
local IDictionary_2StringObject = System.IDictionary_2(System.String, System.Object)
local MongoDBBson
local MongoDBConventions
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBConventions = MongoDB.Bson.Serialization.Conventions
end)
System.namespace("MongoDB.Bson.Serialization.Conventions", function (namespace)
  -- <summary>
  -- A convention that finds the extra elements member by name (and that is also of type <see cref="BsonDocument"/> or <see cref="IDictionary{String, Object}"/>).
  -- </summary>
  namespace.class("NamedExtraElementsMemberConvention", function (namespace)
    local Apply, __ctor1__, __ctor2__, __ctor3__, __ctor4__, __ctor5__
    -- <summary>
    -- Initializes a new instance of the NamedExtraElementsMemberConvention class.
    -- </summary>
    __ctor1__ = function (this, name)
      __ctor2__(this, ArrayString(name))
    end
    -- <summary>
    -- Initializes a new instance of the <see cref="NamedExtraElementsMemberConvention" /> class.
    -- </summary>
    __ctor2__ = function (this, names)
      __ctor4__(this, names, 20 --[[BindingFlags.Instance | BindingFlags.Public]])
    end
    -- <summary>
    -- Initializes a new instance of the <see cref="NamedExtraElementsMemberConvention" /> class.
    -- </summary>
    -- <param name="memberTypes">The member types.</param>
    __ctor3__ = function (this, names, memberTypes)
      __ctor5__(this, names, memberTypes, 20 --[[BindingFlags.Instance | BindingFlags.Public]])
    end
    -- <summary>
    -- Initializes a new instance of the <see cref="NamedExtraElementsMemberConvention" /> class.
    -- </summary>
    -- <param name="bindingFlags">The binding flags.</param>
    __ctor4__ = function (this, names, bindingFlags)
      __ctor5__(this, names, 20 --[[MemberTypes.Field | MemberTypes.Property]], bindingFlags)
    end
    -- <summary>
    -- Initializes a new instance of the <see cref="NamedExtraElementsMemberConvention" /> class.
    -- </summary>
    -- <param name="memberTypes">The member types.</param>
    -- <param name="bindingFlags">The binding flags.</param>
    -- <exception cref="System.ArgumentNullException"></exception>
    __ctor5__ = function (this, names, memberTypes, bindingFlags)
      MongoDBConventions.ConventionBase.__ctor__[1](this)
      if names == nil then
        System.throw(System.ArgumentNullException("names"))
      end

      this._names = names
      this._memberTypes = memberTypes
      this._bindingFlags = bindingFlags | 2 --[[BindingFlags.DeclaredOnly]]
    end
    -- <summary>
    -- Applies a modification to the class map.
    -- </summary>
    Apply = function (this, classMap)
      local classTypeInfo = SystemReflection.IntrospectionExtensions.GetTypeInfo(classMap:getClassType())
      for _, name in System.each(this._names) do
        local member = Linq.SingleOrDefault(classTypeInfo:GetMember(name, this._memberTypes, this._bindingFlags))

        if member ~= nil then
          local memberType = nil
          local fieldInfo = System.as(member, SystemReflection.FieldInfo)
          if fieldInfo ~= nil then
            memberType = fieldInfo:getFieldType()
          else
            local propertyInfo = System.as(member, SystemReflection.PropertyInfo)
            if propertyInfo ~= nil then
              memberType = propertyInfo:getPropertyType()
            end
          end

          if memberType ~= nil and (memberType == System.typeof(MongoDBBson.BsonDocument) or SystemReflection.IntrospectionExtensions.GetTypeInfo(System.typeof(IDictionary_2StringObject)):IsAssignableFrom(memberType)) then
            classMap:MapExtraElementsMember(member)
            return
          end
        end
      end
    end
    return {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.Conventions.ConventionBase,
          out.MongoDB.Bson.Serialization.Conventions.IClassMapConvention
        }
      end,
      _memberTypes = 0,
      _bindingFlags = 0,
      Apply = Apply,
      __ctor__ = {
        __ctor1__,
        __ctor2__,
        __ctor3__,
        __ctor4__,
        __ctor5__
      }
    }
  end)
end)
