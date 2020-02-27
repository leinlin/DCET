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
local MongoDBBsonIO
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBBsonIO = MongoDB.Bson.IO
end)
System.namespace("MongoDB.Bson", function (namespace)
  -- <summary>
  -- Represents a BSON boolean value.
  -- </summary>
  namespace.class("BsonBoolean", function (namespace)
    local __falseInstance, __trueInstance, getFalse, getTrue, getBsonType, getRawValue, getValue, op_Implicit22, 
    op_Inequality1, op_Equality1, Create1, CompareTo, CompareTo1, Equals, EqualsObj, GetHashCode, 
    ToBoolean1, ToString, IConvertibleGetTypeCodeImplementation, IConvertibleToBooleanImplementation, IConvertibleToByteImplementation, IConvertibleToDecimalImplementation, IConvertibleToDoubleImplementation, IConvertibleToInt16Implementation, 
    IConvertibleToInt32Implementation, IConvertibleToInt64Implementation, IConvertibleToSByteImplementation, IConvertibleToSingleImplementation, IConvertibleToStringImplementation, IConvertibleToUInt16Implementation, IConvertibleToUInt32Implementation, IConvertibleToUInt64Implementation, 
    class, static, __ctor__
    static = function (this)
      __falseInstance = class(false)
      __trueInstance = class(true)
    end
    -- <summary>
    -- Initializes a new instance of the BsonBoolean class.
    -- </summary>
    __ctor__ = function (this, value)
      MongoDBBson.BsonValue.__ctor__(this)
      this._value = value
    end
    getFalse = function ()
      return __falseInstance
    end
    getTrue = function ()
      return __trueInstance
    end
    getBsonType = function (this)
      return 8 --[[BsonType.Boolean]]
    end
    getRawValue = function (this)
      return this._value
    end
    getValue = function (this)
      return this._value
    end
    -- <summary>
    -- Converts a bool to a BsonBoolean.
    -- </summary>
    -- <returns>A BsonBoolean.</returns>
    op_Implicit22 = function (value)
      local default
      if value then
        default = __trueInstance
      else
        default = __falseInstance
      end
      return default
    end
    -- <summary>
    -- Compares two BsonBoolean values.
    -- </summary>
    -- <param name="rhs">The other BsonBoolean.</param>
    -- <returns>True if the two BsonBoolean values are not equal according to ==.</returns>
    op_Inequality1 = function (lhs, rhs)
      return not (op_Equality1(lhs, rhs))
    end
    -- <summary>
    -- Compares two BsonBoolean values.
    -- </summary>
    -- <param name="rhs">The other BsonBoolean.</param>
    -- <returns>True if the two BsonBoolean values are equal according to ==.</returns>
    op_Equality1 = function (lhs, rhs)
      if System.Object.ReferenceEquals(lhs) then
        return System.Object.ReferenceEquals(rhs)
      end
      return Equals(lhs, rhs)
    end
    -- <summary>
    -- Returns one of the two possible BsonBoolean values.
    -- </summary>
    -- <returns>A BsonBoolean or null.</returns>
    Create1 = function (value)
      if value == nil then
        System.throw(System.ArgumentNullException("value"))
      end

      return System.cast(class, MongoDBBson.BsonTypeMapper.MapToBsonValue1(value, 8 --[[BsonType.Boolean]]))
    end
    -- <summary>
    -- Compares this BsonBoolean to another BsonBoolean.
    -- </summary>
    -- <returns>A 32-bit signed integer that indicates whether this BsonBoolean is less than, equal to, or greather than the other.</returns>
    CompareTo = function (this, other)
      if op_Equality1(other, nil) then
        return 1
      end
      return (this._value and 1 or 0):CompareTo(other._value and 1 or 0)
    end
    -- <summary>
    -- Compares the BsonBoolean to another BsonValue.
    -- </summary>
    -- <returns>A 32-bit signed integer that indicates whether this BsonBoolean is less than, equal to, or greather than the other BsonValue.</returns>
    CompareTo1 = function (this, other)
      if MongoDBBson.BsonValue.op_Equality(other, nil) then
        return 1
      end
      local otherBoolean = System.as(other, class)
      if op_Inequality1(otherBoolean, nil) then
        return (this._value and 1 or 0):CompareTo(otherBoolean._value and 1 or 0)
      end
      return this:CompareTypeTo(other)
    end
    -- <summary>
    -- Compares this BsonBoolean to another BsonBoolean.
    -- </summary>
    -- <returns>True if the two BsonBoolean values are equal.</returns>
    Equals = function (this, rhs)
      if System.Object.ReferenceEquals(rhs) or this:GetType() ~= rhs:GetType() then
        return false
      end
      return this._value == rhs._value
    end
    -- <summary>
    -- Compares this BsonBoolean to another object.
    -- </summary>
    -- <returns>True if the other object is a BsonBoolean and equal to this one.</returns>
    EqualsObj = function (this, obj)
      return Equals(this, System.as(obj, class))
      -- works even if obj is null or of a different type
    end
    -- <summary>
    -- Gets the hash code.
    -- </summary>
    GetHashCode = function (this)
      -- see Effective Java by Joshua Bloch
      local hash = 17
      hash = 37 * hash + this:getBsonType():GetHashCode()
      hash = 37 * hash + this._value:GetHashCode()
      return hash
    end
    -- <summary>
    -- Converts this BsonValue to a Boolean (using the JavaScript definition of truthiness).
    -- </summary>
    ToBoolean1 = function (this)
      return this._value
    end
    -- <summary>
    -- Returns a string representation of the value.
    -- </summary>
    ToString = function (this)
      return MongoDBBsonIO.JsonConvert.ToString(this._value)
    end
    IConvertibleGetTypeCodeImplementation = function (this)
      return 3 --[[TypeCode.Boolean]]
    end
    IConvertibleToBooleanImplementation = function (this, provider)
      return this._value
    end
    IConvertibleToByteImplementation = function (this, provider)
      return System.Convert.ToByte(this._value, provider)
    end
    IConvertibleToDecimalImplementation = function (this, provider)
      return System.Convert.ToDecimal(this._value, provider)
    end
    IConvertibleToDoubleImplementation = function (this, provider)
      return System.Convert.ToDouble(this._value, provider)
    end
    IConvertibleToInt16Implementation = function (this, provider)
      return System.Convert.ToInt16(this._value, provider)
    end
    IConvertibleToInt32Implementation = function (this, provider)
      return System.Convert.ToInt32(this._value, provider)
    end
    IConvertibleToInt64Implementation = function (this, provider)
      return System.Convert.ToInt64(this._value, provider)
    end
    IConvertibleToSByteImplementation = function (this, provider)
      return System.Convert.ToSByte(this._value, provider)
    end
    IConvertibleToSingleImplementation = function (this, provider)
      return System.Convert.ToSingle(this._value, provider)
    end
    IConvertibleToStringImplementation = function (this, provider)
      return System.Convert.ToString(this._value, provider)
    end
    IConvertibleToUInt16Implementation = function (this, provider)
      return System.Convert.ToUInt16(this._value, provider)
    end
    IConvertibleToUInt32Implementation = function (this, provider)
      return System.Convert.ToUInt32(this._value, provider)
    end
    IConvertibleToUInt64Implementation = function (this, provider)
      return System.Convert.ToUInt64(this._value, provider)
    end
    class = {
      base = function (out)
        return {
          out.MongoDB.Bson.BsonValue,
          System.IComparable_1(out.MongoDB.Bson.BsonBoolean),
          System.IEquatable_1(out.MongoDB.Bson.BsonBoolean)
        }
      end,
      _value = false,
      getFalse = getFalse,
      getTrue = getTrue,
      getBsonType = getBsonType,
      getRawValue = getRawValue,
      getValue = getValue,
      op_Implicit22 = op_Implicit22,
      op_Inequality1 = op_Inequality1,
      op_Equality1 = op_Equality1,
      Create1 = Create1,
      CompareTo = CompareTo,
      CompareTo1 = CompareTo1,
      Equals = Equals,
      EqualsObj = EqualsObj,
      GetHashCode = GetHashCode,
      ToBoolean1 = ToBoolean1,
      ToString = ToString,
      IConvertibleGetTypeCodeImplementation = IConvertibleGetTypeCodeImplementation,
      IConvertibleToBooleanImplementation = IConvertibleToBooleanImplementation,
      IConvertibleToByteImplementation = IConvertibleToByteImplementation,
      IConvertibleToDecimalImplementation = IConvertibleToDecimalImplementation,
      IConvertibleToDoubleImplementation = IConvertibleToDoubleImplementation,
      IConvertibleToInt16Implementation = IConvertibleToInt16Implementation,
      IConvertibleToInt32Implementation = IConvertibleToInt32Implementation,
      IConvertibleToInt64Implementation = IConvertibleToInt64Implementation,
      IConvertibleToSByteImplementation = IConvertibleToSByteImplementation,
      IConvertibleToSingleImplementation = IConvertibleToSingleImplementation,
      IConvertibleToStringImplementation = IConvertibleToStringImplementation,
      IConvertibleToUInt16Implementation = IConvertibleToUInt16Implementation,
      IConvertibleToUInt32Implementation = IConvertibleToUInt32Implementation,
      IConvertibleToUInt64Implementation = IConvertibleToUInt64Implementation,
      static = static,
      __ctor__ = __ctor__,
      __metadata__ = function (out)
        return {
          fields = {
            { "__falseInstance", 0x9, class },
            { "__trueInstance", 0x9, class },
            { "_value", 0x1, System.Boolean }
          },
          properties = {
            { "BsonType", 0x206, System.Int32, getBsonType },
            { "False", 0x20E, class, getFalse },
            { "RawValue", 0x206, System.Object, getRawValue, System.ObsoleteAttribute("Use Value instead.") },
            { "True", 0x20E, class, getTrue },
            { "Value", 0x206, System.Boolean, getValue }
          },
          class = { 0x6, System.SerializableAttribute() }
        }
      end
    }
    return class
  end)
end)
