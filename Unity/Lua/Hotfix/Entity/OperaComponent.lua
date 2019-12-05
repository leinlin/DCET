-- Generated by CSharp.lua Compiler
local System = System
local DCETHotfix = DCET.Hotfix
local DCETModel = DCET.Model
local UnityEngine = UnityEngine
System.namespace("DCET.Hotfix", function (namespace)
  namespace.class("OperaComponentAwakeSystem", function (namespace)
    local Awake
    Awake = function (this, self)
      self:Awake()
    end
    return {
      __inherits__ = function (out)
        return {
          out.DCET.Hotfix.AwakeSystem_1(out.DCET.Hotfix.OperaComponent)
        }
      end,
      Awake = Awake
    }
  end)

  namespace.class("OperaComponentUpdateSystem", function (namespace)
    local Update
    Update = function (this, self)
      self:Update()
    end
    return {
      __inherits__ = function (out)
        return {
          out.DCET.Hotfix.UpdateSystem_1(out.DCET.Hotfix.OperaComponent)
        }
      end,
      Update = Update
    }
  end)

  namespace.class("OperaComponent", function (namespace)
    local Awake, Update, TestActor, __ctor__
    __ctor__ = function (this)
      this.ClickPoint = System.default(UnityEngine.Vector3)
      this.frameClickMap = DCETModel.Frame_ClickMap()
      System.base(this).__ctor__(this)
    end
    Awake = function (this)
      this.mapMask = UnityEngine.LayerMask.GetMask("Map")
    end
    Update = function (this)
      if UnityEngine.Input.GetMouseButtonDown(1) then
        local ray = UnityEngine.Camera.getmain():ScreenPointToRay(UnityEngine.Input.getmousePosition())
        local hit
        local default
        default, hit = UnityEngine.Physics.Raycast(ray, nil, 1000, this.mapMask)
        if default then
          this.ClickPoint = hit:getpoint()
          this.frameClickMap:setX(this.ClickPoint.x)
          this.frameClickMap:setY(this.ClickPoint.y)
          this.frameClickMap:setZ(this.ClickPoint.z)
          DCETModel.SessionComponent.Instance.Session:Send(this.frameClickMap)

          -- 测试actor rpc消息
          TestActor(this):Coroutine()
        end
      end
    end
    TestActor = function (this)
      return System.async(function (async, this)
        System.try(function ()
          local default = DCETHotfix.C2M_TestActorRequest()
          default:setInfo("actor rpc request")
          local response = System.cast(DCETHotfix.M2C_TestActorResponse, async:Await(DCETHotfix.SessionComponent.Instance:getSession():Call(default)))
          DCETHotfix.Log.Info(response:getInfo())
        end, function (default)
          local e = default
          DCETHotfix.Log.Error(e)
        end)
      end, nil, this)
    end
    return {
      __inherits__ = function (out)
        return {
          out.DCET.Hotfix.Entity
        }
      end,
      mapMask = 0,
      Awake = Awake,
      Update = Update,
      TestActor = TestActor,
      __ctor__ = __ctor__
    }
  end)
end)
