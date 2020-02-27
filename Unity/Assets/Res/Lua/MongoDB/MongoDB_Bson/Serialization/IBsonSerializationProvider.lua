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
  -- An interface implemented by serialization providers.
  -- </summary>
  namespace.interface("IBsonSerializationProvider", function ()
    return {}
  end)

  -- <summary>
  -- An interface implemented by serialization providers that are aware of registries.
  -- </summary>
  -- This interface was added to preserve backward compatability (changing IBsonSerializationProvider would have been a backward breaking change).
  -- </remarks>
  namespace.interface("IRegistryAwareBsonSerializationProvider", function ()
    return {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.IBsonSerializationProvider
        }
      end
    }
  end)
end)
