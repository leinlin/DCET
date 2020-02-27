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
System.namespace("MongoDB.Bson.Serialization", function (namespace)
  -- <summary>
  -- Represents a serializer that has a representation converter.
  -- </summary>
  namespace.interface("IRepresentationConverterConfigurable", function ()
    return {}
  end)

  -- <summary>
  -- Represents a serializer that has a representation converter.
  -- </summary>
  namespace.interface("IRepresentationConverterConfigurable_1", function ()
    return function (TSerializer)
      return {
        base = function (out)
          return {
            out.MongoDB.Bson.Serialization.IRepresentationConverterConfigurable
          }
        end
      }
    end
  end)
end)
