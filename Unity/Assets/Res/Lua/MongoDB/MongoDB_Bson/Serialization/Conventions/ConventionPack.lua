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
local MongoDBConventions
local ListIConvention
System.import(function (out)
  MongoDBConventions = MongoDB.Bson.Serialization.Conventions
  ListIConvention = System.List(MongoDBConventions.IConvention)
end)
System.namespace("MongoDB.Bson.Serialization.Conventions", function (namespace)
  -- <summary>
  -- A mutable pack of conventions.
  -- </summary>
  namespace.class("ConventionPack", function (namespace)
    local getConventions, Add, AddClassMapConvention, AddMemberMapConvention, AddPostProcessingConvention, AddRange, Append, GetEnumerator, 
    InsertAfter, InsertBefore, Remove, GetEnumerator1, __ctor__
    -- <summary>
    -- Initializes a new instance of the <see cref="ConventionPack" /> class.
    -- </summary>
    __ctor__ = function (this)
      this._conventions = ListIConvention()
    end
    getConventions = function (this)
      return this._conventions
    end
    -- <summary>
    -- Adds the specified convention.
    -- </summary>
    -- <exception cref="System.ArgumentNullException"></exception>
    Add = function (this, convention)
      if convention == nil then
        System.throw(System.ArgumentNullException("convention"))
      end

      this._conventions:Add(convention)
    end
    -- <summary>
    -- Adds a class map convention created using the specified action upon a class map.
    -- </summary>
    -- <param name="action">The action the convention should take upon the class map.</param>
    AddClassMapConvention = function (this, name, action)
      if name == nil then
        System.throw(System.ArgumentNullException("name"))
      end

      Add(this, MongoDBConventions.DelegateClassMapConvention(name, action))
    end
    -- <summary>
    -- Adds a member map convention created using the specified action upon a member map.
    -- </summary>
    -- <param name="action">The action the convention should take upon the member map.</param>
    AddMemberMapConvention = function (this, name, action)
      if name == nil then
        System.throw(System.ArgumentNullException("name"))
      end

      Add(this, MongoDBConventions.DelegateMemberMapConvention(name, action))
    end
    -- <summary>
    -- Adds a post processing convention created using the specified action upon a class map.
    -- </summary>
    -- <param name="action">The action the convention should take upon the class map.</param>
    AddPostProcessingConvention = function (this, name, action)
      if name == nil then
        System.throw(System.ArgumentNullException("name"))
      end

      Add(this, MongoDBConventions.DelegatePostProcessingConvention(name, action))
    end
    -- <summary>
    -- Adds a range of conventions.
    -- </summary>
    -- <exception cref="System.ArgumentNullException"></exception>
    AddRange = function (this, conventions)
      if conventions == nil then
        System.throw(System.ArgumentNullException("conventions"))
      end

      this._conventions:AddRange(conventions)
    end
    -- <summary>
    -- Appends the conventions in another pack to the end of this pack.
    -- </summary>
    Append = function (this, other)
      if other == nil then
        System.throw(System.ArgumentNullException("other"))
      end

      AddRange(this, other:getConventions())
    end
    -- <summary>
    -- Gets an enumerator for the conventions.
    -- </summary>
    GetEnumerator = function (this)
      return this._conventions:GetEnumerator()
    end
    -- <summary>
    -- Inserts the convention after another convention specified by the name.
    -- </summary>
    -- <param name="convention">The convention.</param>
    InsertAfter = function (this, name, convention)
      if name == nil then
        System.throw(System.ArgumentNullException("name"))
      end
      if convention == nil then
        System.throw(System.ArgumentNullException("convention"))
      end

      local index = this._conventions:FindIndex(function (x)
        return x:getName() == name
      end)
      if index == - 1 then
        local message = System.String.Format("Unable to find a convention by the name of '{0}'.", name)
        System.throw(System.ArgumentOutOfRangeException("name", message))
      end

      this._conventions:Insert(index + 1, convention)
    end
    -- <summary>
    -- Inserts the convention before another convention specified by the name.
    -- </summary>
    -- <param name="convention">The convention.</param>
    InsertBefore = function (this, name, convention)
      if name == nil then
        System.throw(System.ArgumentNullException("name"))
      end
      if convention == nil then
        System.throw(System.ArgumentNullException("convention"))
      end

      local index = this._conventions:FindIndex(function (x)
        return x:getName() == name
      end)
      if index == - 1 then
        local message = System.String.Format("Unable to find a convention by the name of '{0}'.", name)
        System.throw(System.ArgumentOutOfRangeException("name", message))
      end

      this._conventions:Insert(index, convention)
    end
    -- <summary>
    -- Removes the named convention.
    -- </summary>
    Remove = function (this, name)
      if name == nil then
        System.throw(System.ArgumentNullException("name"))
      end

      this._conventions:RemoveAll(function (x)
        return x:getName() == name
      end)
    end
    GetEnumerator1 = function (this)
      return this._conventions:GetEnumerator()
    end
    return {
      base = function (out, this)
        this.__genericT__ = out.MongoDB.Bson.Serialization.Conventions.IConvention
        return {
          out.MongoDB.Bson.Serialization.Conventions.IConventionPack,
          System.IEnumerable_1(out.MongoDB.Bson.Serialization.Conventions.IConvention)
        }
      end,
      getConventions = getConventions,
      Add = Add,
      AddClassMapConvention = AddClassMapConvention,
      AddMemberMapConvention = AddMemberMapConvention,
      AddPostProcessingConvention = AddPostProcessingConvention,
      AddRange = AddRange,
      Append = Append,
      GetEnumerator = GetEnumerator,
      InsertAfter = InsertAfter,
      InsertBefore = InsertBefore,
      Remove = Remove,
      GetEnumerator1 = GetEnumerator1,
      __ctor__ = __ctor__
    }
  end)
end)
