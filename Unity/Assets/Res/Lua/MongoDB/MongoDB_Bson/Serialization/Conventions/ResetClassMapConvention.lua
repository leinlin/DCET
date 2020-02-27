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
System.namespace("MongoDB.Bson.Serialization.Conventions", function (namespace)
  -- <summary>
  -- A convention that resets a class map (resetting any changes that earlier conventions may have applied).
  -- </summary>
  namespace.class("ResetClassMapConvention", function (namespace)
    local Apply
    -- <summary>
    -- Applies a modification to the class map.
    -- </summary>
    Apply = function (this, classMap)
      classMap:Reset()
    end
    return {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.Conventions.ConventionBase,
          out.MongoDB.Bson.Serialization.Conventions.IClassMapConvention
        }
      end,
      Apply = Apply
    }
  end)
end)
