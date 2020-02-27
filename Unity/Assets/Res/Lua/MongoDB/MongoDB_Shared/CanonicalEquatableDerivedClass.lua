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
local MongoDBShared
System.import(function (out)
  MongoDBShared = MongoDB.Shared
end)
System.namespace("MongoDB.Shared", function (namespace)
  namespace.class("CanonicalEquatableDerivedClass", function (namespace)
    local Equals, EqualsObj, GetHashCode, class, __ctor__
    -- <summary>
    -- Initializes a new instance of the <see cref="CanonicalEquatableDerivedClass"/> class.
    -- </summary>
    -- <param name="y">The y.</param>
    -- <param name="z">The z.</param>
    __ctor__ = function (this, x, y, z)
      MongoDBShared.CanonicalEquatableClass.__ctor__(this, x, y)
      this._z = z
    end
    -- <summary>
    -- Determines whether the specified <see cref="CanonicalEquatableDerivedClass" /> is equal to this instance.
    -- </summary>
    -- <returns>
    -- <c>true</c> if the specified <see cref="CanonicalEquatableDerivedClass" /> is equal to this instance; otherwise, <c>false</c>.
    -- </returns>
    Equals = function (this, obj)
      return this:EqualsObj(obj)
    end
    -- <summary>
    -- Determines whether the specified <see cref="System.Object" /> is equal to this instance.
    -- </summary>
    -- <returns>
    -- <c>true</c> if the specified <see cref="System.Object" /> is equal to this instance; otherwise, <c>false</c>.
    -- </returns>
    EqualsObj = function (this, obj)
      -- base class checks for obj == null and correct type
      if not MongoDBShared.CanonicalEquatableClass.EqualsObj(this, obj) then
        return false
      end
      local rhs = System.cast(class, obj)
      return this._z == rhs._z
    end
    -- <summary>
    -- Returns a hash code for this instance.
    -- </summary>
    -- A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.
    -- </returns>
    GetHashCode = function (this)
      -- use hash code of base class as seed to Hasher
      return System.new(MongoDBShared.Hasher, 2, MongoDBShared.CanonicalEquatableClass.GetHashCode(this)):Hash1(this._z):GetHashCode()
    end
    class = {
      base = function (out)
        return {
          out.MongoDB.Shared.CanonicalEquatableClass,
          System.IEquatable_1(out.MongoDB.Shared.CanonicalEquatableDerivedClass)
        }
      end,
      _z = 0,
      Equals = Equals,
      EqualsObj = EqualsObj,
      GetHashCode = GetHashCode,
      __ctor__ = __ctor__
    }
    return class
  end)
end)
