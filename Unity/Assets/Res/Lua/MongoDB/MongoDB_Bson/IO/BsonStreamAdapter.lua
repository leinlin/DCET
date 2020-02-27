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
  -- A Stream that wraps another Stream while implementing the BsonStream abstract methods.
  -- </summary>
  namespace.class("BsonStreamAdapter", function (namespace)
    local getBaseStream, getCanRead, getCanSeek, getCanTimeout, getCanWrite, getLength, getPosition, setPosition, 
    getReadTimeout, setReadTimeout, getWriteTimeout, setWriteTimeout, BeginRead, BeginWrite, Close, CopyToAsync, 
    Dispose, EndRead, EndWrite, Flush, FlushAsync, Read, ReadAsync, ReadByte, 
    ReadCString, ReadCStringBytes, ReadDecimal128, ReadDouble, ReadInt32, ReadInt64, ReadObjectId, ReadSlice, 
    ReadString, Seek, SetLength, SkipCString, ThrowIfDisposed, Write, WriteAsync, WriteByte, 
    WriteCString, WriteCStringBytes, WriteDecimal128, WriteDouble, WriteInt32, WriteInt64, WriteObjectId, WriteString, 
    __ctor__
    -- <summary>
    -- Initializes a new instance of the <see cref="BsonStreamAdapter"/> class.
    -- </summary>
    -- <param name="ownsStream">if set to <c>true</c> [owns stream].</param>
    -- <exception cref="System.ArgumentNullException">stream</exception>
    __ctor__ = function (this, stream, ownsStream)
      this._temp = ArrayByte:new(12)
      this._tempUtf8 = ArrayByte:new(128)
      System.base(this).__ctor__(this)
      if stream == nil then
        System.throw(System.ArgumentNullException("stream"))
      end

      this._stream = stream
      this._ownsStream = ownsStream
    end
    getBaseStream = function (this)
      ThrowIfDisposed(this)
      return this._stream
    end
    getCanRead = function (this)
      ThrowIfDisposed(this)
      return this._stream:getCanRead()
    end
    getCanSeek = function (this)
      ThrowIfDisposed(this)
      return this._stream:getCanSeek()
    end
    getCanTimeout = function (this)
      ThrowIfDisposed(this)
      return this._stream:getCanTimeout()
    end
    getCanWrite = function (this)
      ThrowIfDisposed(this)
      return this._stream:getCanWrite()
    end
    getLength = function (this)
      ThrowIfDisposed(this)
      return this._stream:getLength()
    end
    getPosition = function (this)
      ThrowIfDisposed(this)
      return this._stream:getPosition()
    end
    setPosition = function (this, value)
      ThrowIfDisposed(this)
      this._stream:setPosition(value)
    end
    getReadTimeout = function (this)
      ThrowIfDisposed(this)
      return this._stream:getReadTimeout()
    end
    setReadTimeout = function (this, value)
      ThrowIfDisposed(this)
      this._stream:setReadTimeout(value)
    end
    getWriteTimeout = function (this)
      ThrowIfDisposed(this)
      return this._stream:getWriteTimeout()
    end
    setWriteTimeout = function (this, value)
      ThrowIfDisposed(this)
      this._stream:setWriteTimeout(value)
    end
    BeginRead = function (this, buffer, offset, count, callback, state)
      ThrowIfDisposed(this)
      return this._stream:BeginRead(buffer, offset, count, callback, state)
    end
    BeginWrite = function (this, buffer, offset, count, callback, state)
      ThrowIfDisposed(this)
      return this._stream:BeginWrite(buffer, offset, count, callback, state)
    end
    Close = function (this)
      System.base(this).Close(this)
      -- base class will call Dispose
    end
    CopyToAsync = function (this, destination, bufferSize, cancellationToken)
      ThrowIfDisposed(this)
      return this._stream:CopyToAsync3(destination, bufferSize, cancellationToken)
    end
    Dispose = function (this, disposing)
      if not this._disposed then
        if disposing then
          if this._ownsStream then
            this._stream:Dispose()
          end
        end
        this._disposed = true
      end
      System.base(this).Dispose1(this, disposing)
    end
    EndRead = function (this, asyncResult)
      ThrowIfDisposed(this)
      return this._stream:EndRead(asyncResult)
    end
    EndWrite = function (this, asyncResult)
      ThrowIfDisposed(this)
      this._stream:EndWrite(asyncResult)
    end
    Flush = function (this)
      ThrowIfDisposed(this)
      this._stream:Flush()
    end
    FlushAsync = function (this, cancellationToken)
      ThrowIfDisposed(this)
      return this._stream:FlushAsync1(cancellationToken)
    end
    Read = function (this, buffer, offset, count)
      ThrowIfDisposed(this)
      return this._stream:Read(buffer, offset, count)
    end
    ReadAsync = function (this, buffer, offset, count, cancellationToken)
      ThrowIfDisposed(this)
      return this._stream:ReadAsync1(buffer, offset, count, cancellationToken)
    end
    ReadByte = function (this)
      ThrowIfDisposed(this)
      return this._stream:ReadByte()
    end
    ReadCString = function (this, encoding)
      if encoding == nil then
        System.throw(System.ArgumentNullException("encoding"))
      end
      ThrowIfDisposed(this)

      local bytes = ReadCStringBytes(this)
      return MongoDBBsonIO.Utf8Helper.DecodeUtf8String(bytes:getArray(), 0, bytes:getCount(), encoding)
    end
    ReadCStringBytes = function (this)
      ThrowIfDisposed(this)

      local memoryStream = SystemIO.MemoryStream(32)

      while true do
        local b = this._stream:ReadByte()
        if b == - 1 then
          System.throw(SystemIO.EndOfStreamException())
        end
        if b == 0 then
          local memoryStreamBuffer
          memoryStreamBuffer = memoryStream:GetBuffer()

          return ArraySegmentByte(memoryStreamBuffer, 0, System.toInt32(memoryStream:getLength()))
        end

        memoryStream:WriteByte(System.toByte(b))
      end
    end
    ReadDecimal128 = function (this)
      ThrowIfDisposed(this)
      local lowBits = System.toUInt64(ReadInt64(this))
      local highBits = System.toUInt64(ReadInt64(this))
      return MongoDBBson.Decimal128.FromIEEEBits(highBits, lowBits)
    end
    ReadDouble = function (this)
      ThrowIfDisposed(this)
      MongoDBBsonIO.BsonStreamExtensions.ReadBytes(this, this._temp, 0, 8)
      return System.BitConverter.ToDouble(this._temp, 0)
    end
    ReadInt32 = function (this)
      ThrowIfDisposed(this)
      MongoDBBsonIO.BsonStreamExtensions.ReadBytes(this, this._temp, 0, 4)
      return System.bor(System.bor(System.bor(this._temp:get(0), (System.sl(this._temp:get(1), 8))), (System.sl(this._temp:get(2), 16))), (System.sl(this._temp:get(3), 24)))
    end
    ReadInt64 = function (this)
      ThrowIfDisposed(this)
      MongoDBBsonIO.BsonStreamExtensions.ReadBytes(this, this._temp, 0, 8)
      return System.BitConverter.ToInt64(this._temp, 0)
    end
    ReadObjectId = function (this)
      ThrowIfDisposed(this)
      MongoDBBsonIO.BsonStreamExtensions.ReadBytes(this, this._temp, 0, 12)
      return MongoDBBson.ObjectId(this._temp, 0)
    end
    ReadSlice = function (this)
      ThrowIfDisposed(this)
      local position = this._stream:getPosition()
      local length = ReadInt32(this)
      local bytes = ArrayByte:new(length)
      this._stream:setPosition(position)
      MongoDBBsonIO.BsonStreamExtensions.ReadBytes(this, bytes, 0, length)
      return MongoDBBsonIO.ByteArrayBuffer(bytes, true)
    end
    ReadString = function (this, encoding)
      if encoding == nil then
        System.throw(System.ArgumentNullException("encoding"))
      end
      ThrowIfDisposed(this)

      local length = ReadInt32(this)
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

      return encoding:GetString(bytes, 0, length - 1)
    end
    Seek = function (this, offset, origin)
      ThrowIfDisposed(this)
      return this._stream:Seek(offset, origin)
    end
    SetLength = function (this, value)
      ThrowIfDisposed(this)
      this._stream:SetLength(value)
    end
    SkipCString = function (this)
      ThrowIfDisposed(this)

      while true do
        local b = this._stream:ReadByte()
        if b == - 1 then
          System.throw(SystemIO.EndOfStreamException())
        end
        if b == 0 then
          return
        end
      end
    end
    ThrowIfDisposed = function (this)
      if this._disposed then
        System.throw(System.ObjectDisposedException(this:GetType():getName()))
      end
    end
    Write = function (this, buffer, offset, count)
      ThrowIfDisposed(this)
      this._stream:Write(buffer, offset, count)
    end
    WriteAsync = function (this, buffer, offset, count, cancellationToken)
      ThrowIfDisposed(this)
      return this._stream:WriteAsync1(buffer, offset, count, cancellationToken)
    end
    WriteByte = function (this, value)
      ThrowIfDisposed(this)
      this._stream:WriteByte(value)
    end
    WriteCString = function (this, value)
      if value == nil then
        System.throw(System.ArgumentNullException("value"))
      end
      ThrowIfDisposed(this)

      local bytes
      local length

      if MongoDBBsonIO.CStringUtf8Encoding.GetMaxByteCount(#value) <= #this._tempUtf8 then
        bytes = this._tempUtf8
        length = MongoDBBsonIO.CStringUtf8Encoding.GetBytes(value, this._tempUtf8, 0, MongoDBBsonIO.Utf8Encodings.getStrict())
      else
        bytes = MongoDBBsonIO.Utf8Encodings.getStrict():GetBytes(value)
        if System.Array.IndexOf(bytes, 0) ~= - 1 then
          System.throw(System.ArgumentException("A CString cannot contain null bytes.", "value"))
        end
        length = #bytes
      end

      this._stream:Write(bytes, 0, length)
      this._stream:WriteByte(0)
    end
    WriteCStringBytes = function (this, value)
      if value == nil then
        System.throw(System.ArgumentNullException("value"))
      end
      ThrowIfDisposed(this)

      MongoDBBsonIO.BsonStreamExtensions.WriteBytes(this, value, 0, #value)
      WriteByte(this, 0)
    end
    WriteDecimal128 = function (this, value)
      ThrowIfDisposed(this)
      WriteInt64(this, System.toInt64(value:GetIEEELowBits()))
      WriteInt64(this, System.toInt64(value:GetIEEEHighBits()))
    end
    WriteDouble = function (this, value)
      ThrowIfDisposed(this)
      local bytes = System.BitConverter.GetBytesFromDouble(value)
      this._stream:Write(bytes, 0, 8)
    end
    WriteInt32 = function (this, value)
      ThrowIfDisposed(this)
      this._temp:set(0, System.toByte(value))
      this._temp:set(1, System.toByte(System.sr(value, 8)))
      this._temp:set(2, System.toByte(System.sr(value, 16)))
      this._temp:set(3, System.toByte(System.sr(value, 24)))
      this._stream:Write(this._temp, 0, 4)
    end
    WriteInt64 = function (this, value)
      ThrowIfDisposed(this)
      local bytes = System.BitConverter.GetBytesFromInt64(value)
      this._stream:Write(bytes, 0, 8)
    end
    WriteObjectId = function (this, value)
      ThrowIfDisposed(this)
      value:ToByteArray1(this._temp, 0)
      this._stream:Write(this._temp, 0, 12)
    end
    WriteString = function (this, value, encoding)
      if value == nil then
        System.throw(System.ArgumentNullException("value"))
      end
      if encoding == nil then
        System.throw(System.ArgumentNullException("encoding"))
      end
      ThrowIfDisposed(this)

      local bytes
      local length

      if encoding:GetMaxByteCount(#value) <= #this._tempUtf8 then
        bytes = this._tempUtf8
        length = encoding:GetBytes(value, 0, #value, this._tempUtf8, 0)
      else
        bytes = encoding:GetBytes(value)
        length = #bytes
      end

      WriteInt32(this, length + 1)
      this._stream:Write(bytes, 0, length)
      this._stream:WriteByte(0)
    end
    return {
      base = function (out)
        return {
          out.MongoDB.Bson.IO.BsonStream
        }
      end,
      _disposed = false,
      _ownsStream = false,
      getBaseStream = getBaseStream,
      getCanRead = getCanRead,
      getCanSeek = getCanSeek,
      getCanTimeout = getCanTimeout,
      getCanWrite = getCanWrite,
      getLength = getLength,
      getPosition = getPosition,
      setPosition = setPosition,
      getReadTimeout = getReadTimeout,
      setReadTimeout = setReadTimeout,
      getWriteTimeout = getWriteTimeout,
      setWriteTimeout = setWriteTimeout,
      BeginRead = BeginRead,
      BeginWrite = BeginWrite,
      Close = Close,
      CopyToAsync = CopyToAsync,
      Dispose = Dispose,
      EndRead = EndRead,
      EndWrite = EndWrite,
      Flush = Flush,
      FlushAsync = FlushAsync,
      Read = Read,
      ReadAsync = ReadAsync,
      ReadByte = ReadByte,
      ReadCString = ReadCString,
      ReadCStringBytes = ReadCStringBytes,
      ReadDecimal128 = ReadDecimal128,
      ReadDouble = ReadDouble,
      ReadInt32 = ReadInt32,
      ReadInt64 = ReadInt64,
      ReadObjectId = ReadObjectId,
      ReadSlice = ReadSlice,
      ReadString = ReadString,
      Seek = Seek,
      SetLength = SetLength,
      SkipCString = SkipCString,
      Write = Write,
      WriteAsync = WriteAsync,
      WriteByte = WriteByte,
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
