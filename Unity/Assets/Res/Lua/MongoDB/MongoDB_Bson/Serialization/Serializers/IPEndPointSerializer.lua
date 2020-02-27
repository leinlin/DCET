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
local SystemNet = System.Net
local SystemRegularExpressions = System.Text.RegularExpressions
System.namespace("MongoDB.Bson.Serialization.Serializers", function (namespace)
  -- <summary>
  -- Represents a serializer for IPEndPoints.
  -- </summary>
  namespace.class("IPEndPointSerializer", function (namespace)
    local DeserializeValue, SerializeValue
    -- <summary>
    -- Deserializes a value.
    -- </summary>
    -- <param name="args">The deserialization args.</param>
    -- <returns>A deserialized value.</returns>
    DeserializeValue = function (this, context, args)
      local bsonReader = context:getReader()
      this:EnsureBsonTypeEquals(bsonReader, 2 --[[BsonType.String]])

      local stringValue = bsonReader:ReadString()
      local match = SystemRegularExpressions.Regex.Match(stringValue, [[^(?<address>(.+|\[.*\]))\:(?<port>\d+)$]])
      if match:getSuccess() then
        local address
        local default
        default, address = SystemNet.IPAddress.TryParse(match:getGroups():get("address"):getValue(), nil)
        if default then
          local port
          local extern
          extern, port = System.Int32.TryParse(match:getGroups():get("port"):getValue(), nil)
          if extern then
            return SystemNet.IPEndPoint(address, port)
          end
        end
      end

      local message = System.String.Format("Invalid IPEndPoint value '{0}'.", stringValue)
      System.throw(System.FormatException(message))
    end
    -- <summary>
    -- Serializes a value.
    -- </summary>
    -- <param name="args">The serialization args.</param>
    -- <param name="value">The object.</param>
    SerializeValue = function (this, context, args, value)
      local bsonWriter = context:getWriter()

      local stringValue
      if value:getAddressFamily() == 2 --[[AddressFamily.InterNetwork]] then
        stringValue = System.String.Format("{0}:{1}", value:getAddress(), value:getPort())
        -- IPv4
      else
        stringValue = System.String.Format("[{0}]:{1}", value:getAddress(), value:getPort())
        -- IPv6
      end
      bsonWriter:WriteString(stringValue)
    end
    return {
      base = function (out)
        return {
          out.MongoDB.Bson.Serialization.Serializers.ClassSerializerBase_1(System.Net.IPEndPoint)
        }
      end,
      DeserializeValue = DeserializeValue,
      SerializeValue = SerializeValue
    }
  end)
end)
