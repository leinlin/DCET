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
local ArrayByte = System.Array(System.Byte)
local ArraySegmentByte = System.ArraySegment(System.Byte)
local MongoDBBson
local MongoDBBsonIO
System.import(function (out)
  MongoDBBson = MongoDB.Bson
  MongoDBBsonIO = MongoDB.Bson.IO
end)
System.namespace("MongoDB.Bson.IO", function (namespace)
  -- <summary>
  -- An IByteBuffer that is backed by a contiguous byte array.
  -- </summary>
  namespace.class("ByteArrayBuffer", function (namespace)
    local getCapacity, getIsReadOnly, getLength, setLength, AccessBackingBytes, Clear, Dispose, EnsureCapacity, 
    GetByte, GetBytes, GetSlice, MakeReadOnly, SetByte, SetBytes, EnsureIsReadOnly, EnsureIsWritable, 
    SetCapacity, ThrowIfDisposed, class, __ctor1__, __ctor2__
    -- <summary>
    -- Initializes a new instance of the <see cref="ByteArrayBuffer"/> class.
    -- </summary>
    -- <param name="isReadOnly">Whether the buffer is read only.</param>
    __ctor1__ = function (this, bytes, isReadOnly)
      __ctor2__(this, bytes, (bytes == nil) and 0 or #bytes, isReadOnly)
    end
    -- <summary>
    -- Initializes a new instance of the <see cref="ByteArrayBuffer"/> class.
    -- </summary>
    -- <param name="length">The length.</param>
    -- <param name="isReadOnly">Whether the buffer is read only.</param>
    __ctor2__ = function (this, bytes, length, isReadOnly)
      if bytes == nil then
        System.throw(System.ArgumentNullException("bytes"))
      end
      if length < 0 or length > #bytes then
        System.throw(System.ArgumentOutOfRangeException("length"))
      end

      this._length = length
      this._bytes = bytes
      this._isReadOnly = isReadOnly
    end
    getCapacity = function (this)
      ThrowIfDisposed(this)
      return this._isReadOnly and this._length or #this._bytes
    end
    getIsReadOnly = function (this)
      ThrowIfDisposed(this)
      return this._isReadOnly
    end
    getLength = function (this)
      ThrowIfDisposed(this)
      return this._length
    end
    setLength = function (this, value)
      ThrowIfDisposed(this)
      if value < 0 or value > #this._bytes then
        System.throw(System.ArgumentOutOfRangeException("value"))
      end
      EnsureIsWritable(this)

      this._length = value
    end
    AccessBackingBytes = function (this, position)
      ThrowIfDisposed(this)
      if position < 0 or position > this._length then
        System.throw(System.ArgumentOutOfRangeException("position"))
      end

      return ArraySegmentByte(this._bytes, position, this._length - position)
    end
    Clear = function (this, position, count)
      ThrowIfDisposed(this)
      if position < 0 or position > this._length then
        System.throw(System.ArgumentOutOfRangeException("position"))
      end
      if count < 0 or position + count > this._length then
        System.throw(System.ArgumentOutOfRangeException("count"))
      end
      EnsureIsWritable(this)

      System.Array.ClearArray(this._bytes, position, count)
    end
    Dispose = function (this)
      this._disposed = true
      System.GC.SuppressFinalize(this)
    end
    EnsureCapacity = function (this, minimumCapacity)
      if minimumCapacity < 0 then
        System.throw(System.ArgumentOutOfRangeException("minimumCapacity"))
      end
      ThrowIfDisposed(this)
      EnsureIsWritable(this)

      if minimumCapacity > #this._bytes then
        local powerOf2 = math.Max(32, MongoDBBson.PowerOf2.RoundUpToPowerOf2(minimumCapacity))
        SetCapacity(this, powerOf2)
      end
    end
    GetByte = function (this, position)
      ThrowIfDisposed(this)
      if position < 0 or position > this._length then
        System.throw(System.ArgumentOutOfRangeException("position"))
      end

      return this._bytes:get(position)
    end
    GetBytes = function (this, position, destination, offset, count)
      ThrowIfDisposed(this)
      if position < 0 or position > this._length then
        System.throw(System.ArgumentOutOfRangeException("position"))
      end
      if destination == nil then
        System.throw(System.ArgumentNullException("destination"))
      end
      if offset < 0 or offset > #destination then
        System.throw(System.ArgumentOutOfRangeException("offset"))
      end
      if count < 0 or position + count > this._length or offset + count > #destination then
        System.throw(System.ArgumentOutOfRangeException("count"))
      end

      System.Buffer.BlockCopy(this._bytes, position, destination, offset, count)
    end
    GetSlice = function (this, position, length)
      ThrowIfDisposed(this)
      if position < 0 or position > this._length then
        System.throw(System.ArgumentOutOfRangeException("position"))
      end
      if length < 0 or position + length > this._length then
        System.throw(System.ArgumentOutOfRangeException("length"))
      end
      EnsureIsReadOnly(this)

      local forkedBuffer = System.new(class, 2, this._bytes, this._length, true)
      return MongoDBBsonIO.ByteBufferSlice(forkedBuffer, position, length)
    end
    MakeReadOnly = function (this)
      ThrowIfDisposed(this)
      this._isReadOnly = true
    end
    SetByte = function (this, position, value)
      ThrowIfDisposed(this)
      if position < 0 or position > this._length then
        System.throw(System.ArgumentOutOfRangeException("position"))
      end
      EnsureIsWritable(this)

      this._bytes:set(position, value)
    end
    SetBytes = function (this, position, source, offset, count)
      ThrowIfDisposed(this)
      if position < 0 or position > this._length then
        System.throw(System.ArgumentOutOfRangeException("position"))
      end
      if source == nil then
        System.throw(System.ArgumentNullException("source"))
      end
      if offset < 0 or offset > #source then
        System.throw(System.ArgumentOutOfRangeException("offset"))
      end
      if count < 0 or position + count > this._length or offset + count > #source then
        System.throw(System.ArgumentOutOfRangeException("count"))
      end
      EnsureIsWritable(this)

      System.Buffer.BlockCopy(source, offset, this._bytes, position, count)
    end
    EnsureIsReadOnly = function (this)
      if not this._isReadOnly then
        local message = System.String.Format("{0} is not read only.", this:GetType():getName())
        System.throw(System.InvalidOperationException(message))
      end
    end
    EnsureIsWritable = function (this)
      if this._isReadOnly then
        local message = System.String.Format("{0} is not writable.", this:GetType():getName())
        System.throw(System.InvalidOperationException(message))
      end
    end
    SetCapacity = function (this, capacity)
      local oldBytes = this._bytes
      this._bytes = ArrayByte:new(capacity)
      local bytesToCopy = (capacity < #oldBytes) and capacity or #oldBytes
      System.Buffer.BlockCopy(oldBytes, 0, this._bytes, 0, bytesToCopy)
    end
    ThrowIfDisposed = function (this)
      if this._disposed then
        System.throw(System.ObjectDisposedException(this:GetType():getName()))
      end
    end
    class = {
      base = function (out)
        return {
          out.MongoDB.Bson.IO.IByteBuffer
        }
      end,
      _disposed = false,
      _isReadOnly = false,
      _length = 0,
      getCapacity = getCapacity,
      getIsReadOnly = getIsReadOnly,
      getLength = getLength,
      setLength = setLength,
      AccessBackingBytes = AccessBackingBytes,
      Clear = Clear,
      Dispose = Dispose,
      EnsureCapacity = EnsureCapacity,
      GetByte = GetByte,
      GetBytes = GetBytes,
      GetSlice = GetSlice,
      MakeReadOnly = MakeReadOnly,
      SetByte = SetByte,
      SetBytes = SetBytes,
      __ctor__ = {
        __ctor1__,
        __ctor2__
      }
    }
    return class
  end)
end)
