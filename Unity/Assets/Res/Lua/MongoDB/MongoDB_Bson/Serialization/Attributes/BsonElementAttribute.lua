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
System.namespace("MongoDB.Bson.Serialization.Attributes", function (namespace)
  -- <summary>
  -- Specifies the element name and related options for a field or property.
  -- </summary>
  namespace.class("BsonElementAttribute", function (namespace)
    local getElementName, getOrder, setOrder, Apply, __ctor1__, __ctor2__
    -- <summary>
    -- Initializes a new instance of the BsonElementAttribute class.
    -- </summary>
    __ctor1__ = function (this)
      System.Attribute.__ctor__(this)
    end
    -- <summary>
    -- Initializes a new instance of the BsonElementAttribute class.
    -- </summary>
    __ctor2__ = function (this, elementName)
      System.Attribute.__ctor__(this)
      this._elementName = elementName
    end
    getElementName = function (this)
      return this._elementName
    end
    getOrder = function (this)
      return this._order
    end
    setOrder = function (this, value)
      this._order = value
    end
    -- <summary>
    -- Applies a modification to the member map.
    -- </summary>
    Apply = function (this, memberMap)
      if not System.String.IsNullOrEmpty(this._elementName) then
        memberMap:SetElementName(this._elementName)
      end
      memberMap:SetOrder(this._order)
    end
    return {
      base = function (out)
        return {
          System.Attribute,
          out.MongoDB.Bson.Serialization.IBsonMemberMapAttribute
        }
      end,
      _order = 2147483647 --[[Int32.MaxValue]],
      getElementName = getElementName,
      getOrder = getOrder,
      setOrder = setOrder,
      Apply = Apply,
      __ctor__ = {
        __ctor1__,
        __ctor2__
      }
    }
  end)
end)
