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
local ListObject = System.List(System.Object)
local DictStringObject = System.Dictionary(System.String, System.Object)
System.namespace("MongoDB.Bson", function (namespace)

  -- <summary>
  -- Represents options used by the BsonTypeMapper.
  -- </summary>
  namespace.class("BsonTypeMapperOptions", function (namespace)
    local __defaults, getDefaults, setDefaults, getDuplicateNameHandling, setDuplicateNameHandling, getIsFrozen, getMapBsonArrayTo, setMapBsonArrayTo, 
    getMapBsonDocumentTo, setMapBsonDocumentTo, getMapOldBinaryToByteArray, setMapOldBinaryToByteArray, Clone, Freeze, class, static, 
    __ctor__
    static = function (this)
      __defaults = class()
    end
    -- <summary>
    -- Initializes a new instance of the BsonTypeMapperOptions class.
    -- </summary>
    __ctor__ = function (this)
      this._mapBsonArrayTo = System.typeof(ListObject)
      this._mapBsonDocumentTo = System.typeof(DictStringObject)
    end
    getDefaults = function ()
      return __defaults
    end
    setDefaults = function (value)
      if getIsFrozen(value) then
        __defaults = value
      else
        __defaults = Freeze(Clone(value))
      end
    end
    getDuplicateNameHandling = function (this)
      return this._duplicateNameHandling
    end
    setDuplicateNameHandling = function (this, value)
      if this._isFrozen then
        System.throw(System.InvalidOperationException("BsonTypeMapperOptions is frozen."))
      end
      this._duplicateNameHandling = value
    end
    getIsFrozen = function (this)
      return this._isFrozen
    end
    getMapBsonArrayTo = function (this)
      return this._mapBsonArrayTo
    end
    setMapBsonArrayTo = function (this, value)
      if this._isFrozen then
        System.throw(System.InvalidOperationException("BsonTypeMapperOptions is frozen."))
      end
      this._mapBsonArrayTo = value
    end
    getMapBsonDocumentTo = function (this)
      return this._mapBsonDocumentTo
    end
    setMapBsonDocumentTo = function (this, value)
      if this._isFrozen then
        System.throw(System.InvalidOperationException("BsonTypeMapperOptions is frozen."))
      end
      this._mapBsonDocumentTo = value
    end
    getMapOldBinaryToByteArray = function (this)
      return this._mapOldBinaryToByteArray
    end
    setMapOldBinaryToByteArray = function (this, value)
      if this._isFrozen then
        System.throw(System.InvalidOperationException("BsonTypeMapperOptions is frozen."))
      end
      this._mapOldBinaryToByteArray = value
    end
    -- <summary>
    -- Clones the BsonTypeMapperOptions.
    -- </summary>
    Clone = function (this)
      local default = class()
      setDuplicateNameHandling(default, this._duplicateNameHandling)
      setMapBsonArrayTo(default, this._mapBsonArrayTo)
      setMapBsonDocumentTo(default, this._mapBsonDocumentTo)
      setMapOldBinaryToByteArray(default, this._mapOldBinaryToByteArray)
      return default
    end
    -- <summary>
    -- Freezes the BsonTypeMapperOptions.
    -- </summary>
    Freeze = function (this)
      if not this._isFrozen then
        this._isFrozen = true
      end
      return this
    end
    class = {
      _isFrozen = false,
      _duplicateNameHandling = 0,
      _mapOldBinaryToByteArray = false,
      getDefaults = getDefaults,
      setDefaults = setDefaults,
      getDuplicateNameHandling = getDuplicateNameHandling,
      setDuplicateNameHandling = setDuplicateNameHandling,
      getIsFrozen = getIsFrozen,
      getMapBsonArrayTo = getMapBsonArrayTo,
      setMapBsonArrayTo = setMapBsonArrayTo,
      getMapBsonDocumentTo = getMapBsonDocumentTo,
      setMapBsonDocumentTo = setMapBsonDocumentTo,
      getMapOldBinaryToByteArray = getMapOldBinaryToByteArray,
      setMapOldBinaryToByteArray = setMapOldBinaryToByteArray,
      Clone = Clone,
      Freeze = Freeze,
      static = static,
      __ctor__ = __ctor__
    }
    return class
  end)
end)
