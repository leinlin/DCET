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
local MongoDBBson
System.import(function (out)
  MongoDBBson = MongoDB.Bson
end)
System.namespace("MongoDB.Bson", function (namespace)
  -- <summary>
  -- Represents the BSON undefined value.
  -- </summary>
  namespace.class("BsonUndefined", function (namespace)
    local __value, op_Inequality1, op_Equality1, getValue, getBsonType, CompareTo, CompareTo1, Equals, 
    EqualsObj, GetHashCode, ToBoolean1, ToString, class, static, __ctor__
    static = function (this)
      __value = class()
    end
    __ctor__ = function (this)
      MongoDBBson.BsonValue.__ctor__(this)
    end
    -- <summary>
    -- Compares two BsonUndefined values.
    -- </summary>
    -- <param name="rhs">The other BsonUndefined.</param>
    -- <returns>True if the two BsonUndefined values are not equal according to ==.</returns>
    op_Inequality1 = function (lhs, rhs)
      return not (op_Equality1(lhs, rhs))
    end
    -- <summary>
    -- Compares two BsonUndefined values.
    -- </summary>
    -- <param name="rhs">The other BsonUndefined.</param>
    -- <returns>True if the two BsonUndefined values are equal according to ==.</returns>
    op_Equality1 = function (lhs, rhs)
      if System.Object.ReferenceEquals(lhs) then
        return System.Object.ReferenceEquals(rhs)
      end
      return Equals(lhs, rhs)
    end
    getValue = function ()
      return __value
    end
    getBsonType = function (this)
      return 6 --[[BsonType.Undefined]]
    end
    -- <summary>
    -- Compares this BsonUndefined to another BsonUndefined.
    -- </summary>
    -- <returns>A 32-bit signed integer that indicates whether this BsonUndefined is less than, equal to, or greather than the other.</returns>
    CompareTo = function (this, other)
      if op_Equality1(other, nil) then
        return 1
      end
      return 0
      -- it's a singleton
    end
    -- <summary>
    -- Compares the BsonUndefined to another BsonValue.
    -- </summary>
    -- <returns>A 32-bit signed integer that indicates whether this BsonUndefined is less than, equal to, or greather than the other BsonValue.</returns>
    CompareTo1 = function (this, other)
      if MongoDBBson.BsonValue.op_Equality(other, nil) then
        return 1
      end
      if System.is(other, MongoDBBson.BsonMinKey) then
        return 1
      end
      if System.is(other, class) then
        return 0
      end
      return - 1
    end
    -- <summary>
    -- Compares this BsonUndefined to another BsonUndefined.
    -- </summary>
    -- <returns>True if the two BsonUndefined values are equal.</returns>
    Equals = function (this, rhs)
      if System.Object.ReferenceEquals(rhs) or this:GetType() ~= rhs:GetType() then
        return false
      end
      return true
      -- it's a singleton
    end
    -- <summary>
    -- Compares this BsonUndefined to another object.
    -- </summary>
    -- <returns>True if the other object is a BsonUndefined and equal to this one.</returns>
    EqualsObj = function (this, obj)
      return Equals(this, System.as(obj, class))
      -- works even if obj is null or of a different type
    end
    -- <summary>
    -- Gets the hash code.
    -- </summary>
    GetHashCode = function (this)
      return this:getBsonType():GetHashCode()
    end
    -- <summary>
    -- Converts this BsonValue to a Boolean (using the JavaScript definition of truthiness).
    -- </summary>
    ToBoolean1 = function (this)
      return false
    end
    -- <summary>
    -- Returns a string representation of the value.
    -- </summary>
    ToString = function (this)
      return "BsonUndefined"
    end
    class = {
      base = function (out)
        return {
          out.MongoDB.Bson.BsonValue,
          System.IComparable_1(out.MongoDB.Bson.BsonUndefined),
          System.IEquatable_1(out.MongoDB.Bson.BsonUndefined)
        }
      end,
      op_Inequality1 = op_Inequality1,
      op_Equality1 = op_Equality1,
      getValue = getValue,
      getBsonType = getBsonType,
      CompareTo = CompareTo,
      CompareTo1 = CompareTo1,
      Equals = Equals,
      EqualsObj = EqualsObj,
      GetHashCode = GetHashCode,
      ToBoolean1 = ToBoolean1,
      ToString = ToString,
      static = static,
      __ctor__ = __ctor__,
      __metadata__ = function (out)
        return {
          fields = {
            { "__value", 0x9, class }
          },
          properties = {
            { "BsonType", 0x206, System.Int32, getBsonType },
            { "Value", 0x20E, class, getValue }
          },
          class = { 0x6, System.SerializableAttribute() }
        }
      end
    }
    return class
  end)
end)
