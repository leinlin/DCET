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
System.namespace("MongoDB.Bson.IO", function (namespace)
  namespace.class("BsonBinaryWriterContext", function (namespace)
    local getParentContext, getContextType, getStartPosition, getIndex, setIndex, __ctor__
    __ctor__ = function (this, parentContext, contextType, startPosition)
      this._parentContext = parentContext
      this._contextType = contextType
      this._startPosition = startPosition
    end
    getParentContext = function (this)
      return this._parentContext
    end
    getContextType = function (this)
      return this._contextType
    end
    getStartPosition = function (this)
      return this._startPosition
    end
    getIndex = function (this)
      return this._index
    end
    setIndex = function (this, value)
      this._index = value
    end
    return {
      _contextType = 0,
      _startPosition = 0,
      _index = 0,
      getParentContext = getParentContext,
      getContextType = getContextType,
      getStartPosition = getStartPosition,
      getIndex = getIndex,
      setIndex = setIndex,
      __ctor__ = __ctor__
    }
  end)
end)
