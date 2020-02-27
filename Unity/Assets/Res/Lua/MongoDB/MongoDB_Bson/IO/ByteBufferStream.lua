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
local SystemIO = System.IO
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
  -- Represents a Stream backed by an IByteBuffer. Similar to MemoryStream but backed by an IByteBuffer
  -- instead of a byte array and also implements the BsonStream interface for higher performance BSON I/O.
  -- </summary>
  namespace.class("ByteBufferStream", function (namespace)
    local getBuffer, getCanRead, getCanSeek, getCanTimeout, getCanWrite, getLength, getPosition, setPosition, 
    Flush, Read, ReadByte, Seek, SetLength, Write, WriteByte, Dispose, 
    EnsureWriteable, FindNullByte, PrepareToWrite, ReadBytes, SetPositionAfterWrite, ThrowIfDisposed, ThrowIfEndOfStream, ReadCString, 
    ReadCStringBytes, ReadDecimal128, ReadDouble, ReadInt32, ReadInt64, ReadObjectId, ReadSlice, ReadString, 
    SkipCString, WriteCString, WriteCStringBytes, WriteDecimal128, WriteDouble, WriteInt32, WriteInt64, WriteObjectId, 
    WriteString, __ctor__
    -- <summary>
    -- Initializes a new instance of the <see cref="ByteBufferStream"/> class.
    -- </summary>
    -- <param name="ownsBuffer">Whether the stream owns the buffer and should Dispose it when done.</param>
    __ctor__ = function (this, buffer, ownsBuffer)
      this._temp = ArrayByte:new(12)
      this._tempUtf8 = ArrayByte:new(128)
      MongoDBBsonIO.BsonStream.__ctor__(this)
      if buffer == nil then
        System.throw(System.ArgumentNullException("buffer"))
      end

      this._buffer = buffer
      this._ownsBuffer = ownsBuffer
      this._length = buffer:getLength()
    end
    getBuffer = function (this)
      ThrowIfDisposed(this)
      return this._buffer
    end
    getCanRead = function (this)
      return not this._disposed
    end
    getCanSeek = function (this)
      return not this._disposed
    end
    getCanTimeout = function (this)
      return false
    end
    getCanWrite = function (this)
      return not this._disposed and not this._buffer:getIsReadOnly()
    end
    getLength = function (this)
      ThrowIfDisposed(this)
      return this._length
    end
    getPosition = function (this)
      ThrowIfDisposed(this)
      return this._position
    end
    setPosition = function (this, value)
      if value < 0 or value > 2147483647 --[[Int32.MaxValue]] then
        System.throw(System.ArgumentOutOfRangeException("value"))
      end
      ThrowIfDisposed(this)
      this._position = System.toInt32(value)
    end
    Flush = function (this)
      ThrowIfDisposed(this)
      -- do nothing
    end
    Read = function (this, buffer, offset, count)
      if buffer == nil then
        System.throw(System.ArgumentNullException("buffer"))
      end
      if offset < 0 or offset > #buffer then
        System.throw(System.ArgumentOutOfRangeException("offset"))
      end
      if count < 0 or offset + count > #buffer then
        System.throw(System.ArgumentOutOfRangeException("count"))
      end
      ThrowIfDisposed(this)

      if this._position >= this._length then
        return 0
      end

      local available = this._length - this._position
      if count > available then
        count = available
      end

      this._buffer:GetBytes(this._position, buffer, offset, count)
      this._position = this._position + count

      return count
    end
    ReadByte = function (this)
      ThrowIfDisposed(this)
      if this._position >= this._length then
        return - 1
      end
      local default = this._position
      this._position = default + 1
      return this._buffer:GetByte(default)
    end
    Seek = function (this, offset, origin)
      ThrowIfDisposed(this)

      local position
      repeat
        local default = origin
        if default == 0 --[[SeekOrigin.Begin]] then
          position = offset
          break
        elseif default == 1 --[[SeekOrigin.Current]] then
          position = this._position + offset
          break
        elseif default == 2 --[[SeekOrigin.End]] then
          position = this._length + offset
          break
        else
          System.throw(System.ArgumentException("Invalid origin.", "origin"))
        end
      until 1
      if position < 0 then
        System.throw(SystemIO.IOException("Attempted to seek before the beginning of the stream."))
      end
      if position > 2147483647 --[[Int32.MaxValue]] then
        System.throw(SystemIO.IOException("Attempted to seek beyond the maximum value that can be represented using 32 bits."))
      end

      this._position = System.toInt32(position)
      return position
    end
    SetLength = function (this, value)
      if value < 0 or value > 2147483647 --[[Int32.MaxValue]] then
        System.throw(System.ArgumentOutOfRangeException("value"))
      end
      ThrowIfDisposed(this)
      EnsureWriteable(this)

      this._buffer:EnsureCapacity(System.toInt32(value))
      this._length = System.toInt32(value)
      if this._position > this._length then
        this._position = this._length
      end
    end
    Write = function (this, buffer, offset, count)
      if buffer == nil then
        System.throw(System.ArgumentNullException("buffer"))
      end
      if offset < 0 or offset > #buffer then
        System.throw(System.ArgumentOutOfRangeException("offset"))
      end
      if count < 0 or offset + count > #buffer then
        System.throw(System.ArgumentOutOfRangeException("count"))
      end
      ThrowIfDisposed(this)
      EnsureWriteable(this)

      PrepareToWrite(this, count)
      this._buffer:SetBytes(this._position, buffer, offset, count)
      SetPositionAfterWrite(this, this._position + count)
    end
    WriteByte = function (this, value)
      ThrowIfDisposed(this)
      PrepareToWrite(this, 1)
      this._buffer:SetByte(this._position, value)
      SetPositionAfterWrite(this, this._position + 1)
    end
    Dispose = function (this, disposing)
      if not this._disposed then
        if this._ownsBuffer then
          this._buffer:Dispose()
        end
        this._disposed = true
      end
      SystemIO.Stream.Dispose1(this, disposing)
    end
    EnsureWriteable = function (this)
      if not this:getCanWrite() then
        System.throw(System.NotSupportedException("Stream is not writeable."))
      end
    end
    FindNullByte = function (this)
      local position = this._position
      while position < this._length do
        local segment = this._buffer:AccessBackingBytes(position)
        local endOfSegmentIndex = segment:getOffset() + segment:getCount()
        for index = segment:getOffset(), endOfSegmentIndex - 1 do
          if segment:getArray():get(index) == 0 then
            return position + (index - segment:getOffset())
          end
        end
        position = position + segment:getCount()
      end

      System.throw(SystemIO.EndOfStreamException())
    end
    PrepareToWrite = function (this, count)
      local minimumCapacity = this._position + count
      if minimumCapacity > 2147483647 --[[Int32.MaxValue]] then
        System.throw(SystemIO.IOException("Stream was too long."))
      end

      this._buffer:EnsureCapacity(System.toInt32(minimumCapacity))
      this._buffer:setLength(this._buffer:getCapacity())
      if this._length < this._position then
        this._buffer:Clear(this._length, this._position - this._length)
      end
    end
    ReadBytes = function (this, count)
      ThrowIfEndOfStream(this, count)
      local bytes = ArrayByte:new(count)
      this._buffer:GetBytes(this._position, bytes, 0, count)
      this._position = this._position + count
      return bytes
    end
    SetPositionAfterWrite = function (this, position)
      this._position = position
      if this._length < position then
        this._length = position
      end
    end
    ThrowIfDisposed = function (this)
      if this._disposed then
        System.throw(System.ObjectDisposedException("ByteBufferStream"))
      end
    end
    ThrowIfEndOfStream = function (this, count)
      local minimumLength = this._position + count
      if this._length < minimumLength then
        if this._position < this._length then
          this._position = this._length
        end
        System.throw(SystemIO.EndOfStreamException())
      end
    end
    ReadCString = function (this, encoding)
      if encoding == nil then
        System.throw(System.ArgumentNullException("encoding"))
      end
      ThrowIfDisposed(this)

      local bytes = this:ReadCStringBytes()
      return MongoDBBsonIO.Utf8Helper.DecodeUtf8String(bytes:getArray(), bytes:getOffset(), bytes:getCount(), encoding)
    end
    ReadCStringBytes = function (this)
      ThrowIfDisposed(this)
      ThrowIfEndOfStream(this, 1)

      local segment = this._buffer:AccessBackingBytes(this._position)
      local index = System.Array.IndexOf(segment:getArray(), 0, segment:getOffset(), segment:getCount())
      if index ~= - 1 then
        local length = index - segment:getOffset()
        this._position = this._position + (length + 1)
        -- advance over the null byte
        return ArraySegmentByte(segment:getArray(), segment:getOffset(), length)
        -- without the null byte
      else
        local nullPosition = FindNullByte(this)
        local length = nullPosition - this._position
        local cstring = ReadBytes(this, length + 1)
        -- advance over the null byte
        return ArraySegmentByte(cstring, 0, length)
        -- without the null byte
      end
    end
    ReadDecimal128 = function (this)
      ThrowIfDisposed(this)
      ThrowIfEndOfStream(this, 16)

      local lowBits = System.toUInt64(this:ReadInt64())
      local highBits = System.toUInt64(this:ReadInt64())
      return MongoDBBson.Decimal128.FromIEEEBits(highBits, lowBits)
    end
    ReadDouble = function (this)
      ThrowIfDisposed(this)
      ThrowIfEndOfStream(this, 8)

      local segment = this._buffer:AccessBackingBytes(this._position)
      if segment:getCount() >= 8 then
        this._position = this._position + 8
        return System.BitConverter.ToDouble(segment:getArray(), segment:getOffset())
      else
        MongoDBBsonIO.BsonStreamExtensions.ReadBytes(this, this._temp, 0, 8)
        return System.BitConverter.ToDouble(this._temp, 0)
      end
    end
    ReadInt32 = function (this)
      ThrowIfDisposed(this)
      ThrowIfEndOfStream(this, 4)

      local segment = this._buffer:AccessBackingBytes(this._position)
      if segment:getCount() >= 4 then
        this._position = this._position + 4
        local bytes = segment:getArray()
        local offset = segment:getOffset()
        return System.bor(System.bor(System.bor(bytes:get(offset), (System.sl(bytes:get(offset + 1), 8))), (System.sl(bytes:get(offset + 2), 16))), (System.sl(bytes:get(offset + 3), 24)))
      else
        MongoDBBsonIO.BsonStreamExtensions.ReadBytes(this, this._temp, 0, 4)
        return System.bor(System.bor(System.bor(this._temp:get(0), (System.sl(this._temp:get(1), 8))), (System.sl(this._temp:get(2), 16))), (System.sl(this._temp:get(3), 24)))
      end
    end
    ReadInt64 = function (this)
      ThrowIfDisposed(this)
      ThrowIfEndOfStream(this, 8)

      local segment = this._buffer:AccessBackingBytes(this._position)
      if segment:getCount() >= 8 then
        this._position = this._position + 8
        return System.BitConverter.ToInt64(segment:getArray(), segment:getOffset())
      else
        MongoDBBsonIO.BsonStreamExtensions.ReadBytes(this, this._temp, 0, 8)
        return System.BitConverter.ToInt64(this._temp, 0)
      end
    end
    ReadObjectId = function (this)
      ThrowIfDisposed(this)
      ThrowIfEndOfStream(this, 12)

      local segment = this._buffer:AccessBackingBytes(this._position)
      if segment:getCount() >= 12 then
        this._position = this._position + 12
        return MongoDBBson.ObjectId(segment:getArray(), segment:getOffset())
      else
        MongoDBBsonIO.BsonStreamExtensions.ReadBytes(this, this._temp, 0, 12)
        return MongoDBBson.ObjectId(this._temp, 0)
      end
    end
    ReadSlice = function (this)
      ThrowIfDisposed(this)

      local position = this._position
      local length = this:ReadInt32()
      ThrowIfEndOfStream(this, length - 4)
      this:setPosition(position + length)

      return this._buffer:GetSlice(position, length)
    end
    ReadString = function (this, encoding)
      if encoding == nil then
        System.throw(System.ArgumentNullException("encoding"))
      end
      ThrowIfDisposed(this)

      local length = this:ReadInt32()
      if length <= 0 then
        local message = System.String.Format("Invalid string length: {0}.", length)
        System.throw(System.FormatException(message))
      end

      local segment = this._buffer:AccessBackingBytes(this._position)
      if segment:getCount() >= length then
        ThrowIfEndOfStream(this, length)
        if segment:getArray():get(segment:getOffset() + length - 1) ~= 0 then
          System.throw(System.FormatException("String is missing terminating null byte."))
        end
        this._position = this._position + length
        return MongoDBBsonIO.Utf8Helper.DecodeUtf8String(segment:getArray(), segment:getOffset(), length - 1, encoding)
      else
        local default
        if length <= #this._tempUtf8 then
          default = this._tempUtf8
        else
          default = ArrayByte:new(length)
        end
        local bytes = default
        MongoDBBsonIO.BsonStreamExtensions.ReadBytes(this, bytes, 0, length)
        if bytes:get(length - 1) ~= 0 then
          System.throw(System.FormatException("String is missing terminating null byte."))
        end
        return MongoDBBsonIO.Utf8Helper.DecodeUtf8String(bytes, 0, length - 1, encoding)
      end
    end
    SkipCString = function (this)
      ThrowIfDisposed(this)
      local nullPosition = FindNullByte(this)
      this._position = nullPosition + 1
    end
    WriteCString = function (this, value)
      if value == nil then
        System.throw(System.ArgumentNullException("value"))
      end
      ThrowIfDisposed(this)

      local maxLength = MongoDBBsonIO.CStringUtf8Encoding.GetMaxByteCount(#value) + 1
      PrepareToWrite(this, maxLength)

      local actualLength
      local segment = this._buffer:AccessBackingBytes(this._position)
      if segment:getCount() >= maxLength then
        actualLength = MongoDBBsonIO.CStringUtf8Encoding.GetBytes(value, segment:getArray(), segment:getOffset(), MongoDBBsonIO.Utf8Encodings.getStrict())
        segment:getArray():set(segment:getOffset() + actualLength, 0)
      else
        local bytes
        if maxLength <= #this._tempUtf8 then
          bytes = this._tempUtf8
          actualLength = MongoDBBsonIO.CStringUtf8Encoding.GetBytes(value, bytes, 0, MongoDBBsonIO.Utf8Encodings.getStrict())
        else
          bytes = MongoDBBsonIO.Utf8Encodings.getStrict():GetBytes(value)
          if System.Array.IndexOf(bytes, 0) ~= - 1 then
            System.throw(System.ArgumentException("A CString cannot contain null bytes.", "value"))
          end
          actualLength = #bytes
        end

        this._buffer:SetBytes(this._position, bytes, 0, actualLength)
        this._buffer:SetByte(this._position + actualLength, 0)
      end

      SetPositionAfterWrite(this, this._position + actualLength + 1)
    end
    WriteCStringBytes = function (this, value)
      if value == nil then
        System.throw(System.ArgumentNullException("value"))
      end
      ThrowIfDisposed(this)

      local length = #value

      PrepareToWrite(this, length + 1)

      this._buffer:SetBytes(this._position, value, 0, length)
      this._buffer:SetByte(this._position + length, 0)

      SetPositionAfterWrite(this, this._position + length + 1)
    end
    WriteDecimal128 = function (this, value)
      ThrowIfDisposed(this)
      this:WriteInt64(System.toInt64(value:GetIEEELowBits()))
      this:WriteInt64(System.toInt64(value:GetIEEEHighBits()))
    end
    WriteDouble = function (this, value)
      ThrowIfDisposed(this)

      PrepareToWrite(this, 8)

      local bytes = System.BitConverter.GetBytesFromDouble(value)
      this._buffer:SetBytes(this._position, bytes, 0, 8)

      SetPositionAfterWrite(this, this._position + 8)
    end
    WriteInt32 = function (this, value)
      ThrowIfDisposed(this)

      PrepareToWrite(this, 4)

      local segment = this._buffer:AccessBackingBytes(this._position)
      if segment:getCount() >= 4 then
        segment:getArray():set(segment:getOffset(), System.toByte(value))
        segment:getArray():set(segment:getOffset() + 1, System.toByte(System.sr(value, 8)))
        segment:getArray():set(segment:getOffset() + 2, System.toByte(System.sr(value, 16)))
        segment:getArray():set(segment:getOffset() + 3, System.toByte(System.sr(value, 24)))
      else
        this._temp:set(0, System.toByte(value))
        this._temp:set(1, System.toByte(System.sr(value, 8)))
        this._temp:set(2, System.toByte(System.sr(value, 16)))
        this._temp:set(3, System.toByte(System.sr(value, 24)))
        this._buffer:SetBytes(this._position, this._temp, 0, 4)
      end

      SetPositionAfterWrite(this, this._position + 4)
    end
    WriteInt64 = function (this, value)
      ThrowIfDisposed(this)

      PrepareToWrite(this, 8)

      local bytes = System.BitConverter.GetBytesFromInt64(value)
      this._buffer:SetBytes(this._position, bytes, 0, 8)

      SetPositionAfterWrite(this, this._position + 8)
    end
    WriteObjectId = function (this, value)
      ThrowIfDisposed(this)

      PrepareToWrite(this, 12)

      local segment = this._buffer:AccessBackingBytes(this._position)
      if segment:getCount() >= 12 then
        value:ToByteArray1(segment:getArray(), segment:getOffset())
      else
        local bytes = value:ToByteArray()
        this._buffer:SetBytes(this._position, bytes, 0, 12)
      end

      SetPositionAfterWrite(this, this._position + 12)
    end
    WriteString = function (this, value, encoding)
      ThrowIfDisposed(this)

      local maxLength = encoding:GetMaxByteCount(#value) + 5
      PrepareToWrite(this, maxLength)

      local actualLength
      local segment = this._buffer:AccessBackingBytes(this._position)
      if segment:getCount() >= maxLength then
        actualLength = encoding:GetBytes(value, 0, #value, segment:getArray(), segment:getOffset() + 4)

        local lengthPlusOne = actualLength + 1
        segment:getArray():set(segment:getOffset(), System.toByte(lengthPlusOne))
        segment:getArray():set(segment:getOffset() + 1, System.toByte(System.sr(lengthPlusOne, 8)))
        segment:getArray():set(segment:getOffset() + 2, System.toByte(System.sr(lengthPlusOne, 16)))
        segment:getArray():set(segment:getOffset() + 3, System.toByte(System.sr(lengthPlusOne, 24)))
        segment:getArray():set(segment:getOffset() + 4 + actualLength, 0)
      else
        local bytes
        if maxLength <= #this._tempUtf8 then
          bytes = this._tempUtf8
          actualLength = encoding:GetBytes(value, 0, #value, bytes, 0)
        else
          bytes = encoding:GetBytes(value)
          actualLength = #bytes
        end

        local lengthPlusOneBytes = System.BitConverter.GetBytesFromInt32(actualLength + 1)

        this._buffer:SetBytes(this._position, lengthPlusOneBytes, 0, 4)
        this._buffer:SetBytes(this._position + 4, bytes, 0, actualLength)
        this._buffer:SetByte(this._position + 4 + actualLength, 0)
      end

      SetPositionAfterWrite(this, this._position + actualLength + 5)
    end
    return {
      base = function (out)
        return {
          out.MongoDB.Bson.IO.BsonStream
        }
      end,
      _disposed = false,
      _length = 0,
      _ownsBuffer = false,
      _position = 0,
      getBuffer = getBuffer,
      getCanRead = getCanRead,
      getCanSeek = getCanSeek,
      getCanTimeout = getCanTimeout,
      getCanWrite = getCanWrite,
      getLength = getLength,
      getPosition = getPosition,
      setPosition = setPosition,
      Flush = Flush,
      Read = Read,
      ReadByte = ReadByte,
      Seek = Seek,
      SetLength = SetLength,
      Write = Write,
      WriteByte = WriteByte,
      Dispose = Dispose,
      ReadCString = ReadCString,
      ReadCStringBytes = ReadCStringBytes,
      ReadDecimal128 = ReadDecimal128,
      ReadDouble = ReadDouble,
      ReadInt32 = ReadInt32,
      ReadInt64 = ReadInt64,
      ReadObjectId = ReadObjectId,
      ReadSlice = ReadSlice,
      ReadString = ReadString,
      SkipCString = SkipCString,
      WriteCString = WriteCString,
      WriteCStringBytes = WriteCStringBytes,
      WriteDecimal128 = WriteDecimal128,
      WriteDouble = WriteDouble,
      WriteInt32 = WriteInt32,
      WriteInt64 = WriteInt64,
      WriteObjectId = WriteObjectId,
      WriteString = WriteString,
      __ctor__ = __ctor__
    }
  end)
end)
