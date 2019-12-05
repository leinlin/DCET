-- Generated by CSharp.lua Compiler
local System = System
local FairyGUI = FairyGUI
local UnityEngine = UnityEngine
local ArrayGObject = System.Array(FairyGUI.GObject)
System.namespace("DCET.Hotfix", function (namespace)
  namespace.class("GComponentHelper", function (namespace)
    local GetRect, childRadiusDiss
    -- <summary>
    -- 获取组件包围盒
    -- </summary>
    GetRect = function (gcom)
      if gcom == nil then
        return UnityEngine.Rect.getzero()
      end

      local ax = 0
      local ay = 0
      local aw = 0
      local ah = 0

      local childs = ArrayGObject:new(4)
      local maxDisschild = nil
      local diss = 0

      local cnt = gcom:getnumChildren()

      if gcom:getnumChildren() > 0 then
        ax = 2147483647 --[[Int32.MaxValue]]
        ay = 2147483647 --[[Int32.MaxValue]]

        local ar = -2147483648 --[[Int32.MinValue]]
        local ab = -2147483648 --[[Int32.MinValue]]

        local tmp

        for i = 0, cnt - 1 do
          local child = gcom:GetChildAt(i)

          tmp = child:getxMin()

          if tmp < ax then
            ax = tmp
            childs:set(0, child)
          end

          tmp = child:getyMin()

          if tmp < ay then
            ay = tmp
            childs:set(1, child)
          end

          tmp = child:getxMin() + child:getactualWidth()

          if tmp > ar then
            ar = tmp
            childs:set(2, child)
          end

          tmp = child:getyMin() + child:getactualWidth()

          if tmp > ab then
            ab = tmp
            childs:set(3, child)
          end
        end

        for i = 0, #childs - 1 do
          if diss <= childRadiusDiss(childs:get(i)) then
            diss = childRadiusDiss(childs:get(i))
            maxDisschild = childs:get(i)
          end
        end

        local ratio = UnityEngine.Mathf.Max(maxDisschild:getactualWidth(), maxDisschild:getheight()) / UnityEngine.Mathf.Min(maxDisschild:getactualWidth(), maxDisschild:getactualHeight())

        diss = diss * ratio

        aw = ar - ax + diss
        ah = ab - ay + diss

        ax = ax - diss * 0.5
        ay = ay - diss * 0.5

        return UnityEngine.Rect(ax, ay, aw, ah)
      end

      return UnityEngine.Rect(gcom:getx(), gcom:gety(), gcom:getactualWidth(), gcom:getactualHeight())
    end
    childRadiusDiss = function (child)
      local radius = UnityEngine.Mathf.Sqrt(child:getactualWidth() * child:getactualWidth() + child:getactualHeight() * child:getactualHeight()) * 0.5

      local diss = radius * UnityEngine.Mathf.Abs(UnityEngine.Mathf.Sin(child:getrotation()))

      return diss
    end
    return {
      GetRect = GetRect
    }
  end)
end)
