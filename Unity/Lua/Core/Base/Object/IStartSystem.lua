-- Generated by CSharp.lua Compiler
local System = System
System.namespace("DCET.Hotfix", function (namespace)
  namespace.interface("IStartSystem", function ()
    return {}
  end)

  namespace.class("StartSystem_1", function (namespace)
    return function (T)
      local Run, Type
      Run = function (this, o)
        Start(this, System.cast(T, o))
      end
      Type = function (this)
        return System.typeof(T)
      end
      return {
        __inherits__ = function (out)
          return {
            out.DCET.Hotfix.IStartSystem
          }
        end,
        Run = Run,
        Type = Type
      }
    end
  end)
end)
