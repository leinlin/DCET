-- Generated by CSharp.lua Compiler
local System = System
System.namespace("DCET.Hotfix", function (namespace)
  namespace.class("TestAwakeSystem", function (namespace)
    local Awake
    Awake = function (this, self)
      System.throw(System.NotImplementedException())
    end
    return {
      __inherits__ = function (out)
        return {
          out.DCET.Hotfix.AwakeSystem_1(out.DCET.Hotfix.Entity)
        }
      end,
      Awake = Awake
    }
  end)

  namespace.interface("IAwakeSystem", function ()
    return {}
  end)

  namespace.interface("IAwake", function ()
    return {}
  end)

  namespace.interface("IAwake_1", function ()
    return function (A)
      return {}
    end
  end)

  namespace.interface("IAwake_2", function ()
    return function (A, B)
      return {}
    end
  end)

  namespace.interface("IAwake_3", function ()
    return function (A, B, C)
      return {}
    end
  end)

  namespace.class("AwakeSystem_1", function (namespace)
    return function (T)
      local Type, Run
      Type = function (this)
        return System.typeof(T)
      end
      Run = function (this, o)
        this:Awake(System.cast(T, o))
      end
      return {
        __inherits__ = function (out)
          return {
            out.DCET.Hotfix.IAwakeSystem,
            out.DCET.Hotfix.IAwake
          }
        end,
        Type = Type,
        Run = Run
      }
    end
  end)

  namespace.class("AwakeSystem_2", function (namespace)
    return function (T, A)
      local Type, Run
      Type = function (this)
        return System.typeof(T)
      end
      Run = function (this, o, a)
        Awake(this, System.cast(T, o), a)
      end
      return {
        __inherits__ = function (out)
          return {
            out.DCET.Hotfix.IAwakeSystem,
            out.DCET.Hotfix.IAwake_1(A)
          }
        end,
        Type = Type,
        Run = Run
      }
    end
  end)

  namespace.class("AwakeSystem_3", function (namespace)
    return function (T, A, B)
      local Type, Run
      Type = function (this)
        return System.typeof(T)
      end
      Run = function (this, o, a, b)
        Awake(this, System.cast(T, o), a, b)
      end
      return {
        __inherits__ = function (out)
          return {
            out.DCET.Hotfix.IAwakeSystem,
            out.DCET.Hotfix.IAwake_2(A, B)
          }
        end,
        Type = Type,
        Run = Run
      }
    end
  end)

  namespace.class("AwakeSystem_4", function (namespace)
    return function (T, A, B, C)
      local Type, Run
      Type = function (this)
        return System.typeof(T)
      end
      Run = function (this, o, a, b, c)
        Awake(this, System.cast(T, o), a, b, c)
      end
      return {
        __inherits__ = function (out)
          return {
            out.DCET.Hotfix.IAwakeSystem,
            out.DCET.Hotfix.IAwake_3(A, B, C)
          }
        end,
        Type = Type,
        Run = Run
      }
    end
  end)
end)
