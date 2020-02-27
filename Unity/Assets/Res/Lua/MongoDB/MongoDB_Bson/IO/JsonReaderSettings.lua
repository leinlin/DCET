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
local MongoDBBsonIO
System.import(function (out)
  MongoDBBsonIO = MongoDB.Bson.IO
end)
System.namespace("MongoDB.Bson.IO", function (namespace)
  -- <summary>
  -- Represents settings for a JsonReader.
  -- </summary>
  namespace.class("JsonReaderSettings", function (namespace)
    local __defaults, getDefaults, setDefaults, Clone1, CloneImplementation, class, __ctor__
    -- <summary>
    -- Initializes a new instance of the JsonReaderSettings class.
    -- </summary>
    __ctor__ = function (this)
      MongoDBBsonIO.BsonReaderSettings.__ctor__[1](this)
    end
    getDefaults = function ()
      if __defaults == nil then
        __defaults = class()
      end
      return __defaults
    end
    setDefaults = function (value)
      __defaults = value
    end
    -- <summary>
    -- Creates a clone of the settings.
    -- </summary>
    Clone1 = function (this)
      return System.cast(class, this:CloneImplementation())
    end
    -- <summary>
    -- Creates a clone of the settings.
    -- </summary>
    CloneImplementation = function (this)
      local default = class()
      default:setGuidRepresentation(this:getGuidRepresentation())
      local clone = default
      return clone
    end
    class = {
      base = function (out)
        return {
          out.MongoDB.Bson.IO.BsonReaderSettings
        }
      end,
      getDefaults = getDefaults,
      setDefaults = setDefaults,
      Clone1 = Clone1,
      CloneImplementation = CloneImplementation,
      __ctor__ = __ctor__,
      __metadata__ = function (out)
        return {
          fields = {
            { "__defaults", 0x9, class }
          },
          properties = {
            { "Defaults", 0x10E, class, getDefaults, setDefaults }
          },
          class = { 0x6, System.SerializableAttribute() }
        }
      end
    }
    return class
  end)
end)
