-- Generated by CSharp.lua Compiler
local System = System
local UnityEngineSceneManagement = UnityEngine.SceneManagement
local DCET
System.import(function (out)
  DCET = out.DCET
end)
System.namespace("DCET", function (namespace)
  namespace.class("SceneChangeComponentUpdateSystem", function (namespace)
    local Update
    Update = function (this, self)
      if self.loadMapOperation:getisDone() then
        self.tcs:SetResult(true)
      end
    end
    return {
      base = function (out)
        return {
          out.DCET.UpdateSystem_1(out.DCET.SceneChangeComponent)
        }
      end,
      Update = Update,
      __metadata__ = function (out)
        return {
          class = { 0x6, out.DCET.ObjectSystemAttribute() }
        }
      end
    }
  end)

  namespace.class("SceneChangeComponentDestroySystem", function (namespace)
    local Destroy
    Destroy = function (this, self)
      self.loadMapOperation = nil
      self.tcs = nil
    end
    return {
      base = function (out)
        return {
          out.DCET.DestroySystem_1(out.DCET.SceneChangeComponent)
        }
      end,
      Destroy = Destroy,
      __metadata__ = function (out)
        return {
          class = { 0x6, out.DCET.ObjectSystemAttribute() }
        }
      end
    }
  end)

  namespace.class("SceneChangeComponent", function (namespace)
    local ChangeSceneAsync, getProcess, Finish, __ctor__
    __ctor__ = function (this)
      DCET.Entity.__ctor__(this)
    end
    ChangeSceneAsync = function (this, sceneName)
      this.tcs = System.TaskCompletionSource()
      -- 加载map
      this.loadMapOperation = UnityEngineSceneManagement.SceneManager.LoadSceneAsync(sceneName)
      --this.loadMapOperation.allowSceneActivation = false;
      return this.tcs:getTask()
    end
    getProcess = function (this)
      if this.loadMapOperation == nil then
        return 0
      end
      return System.ToInt32(this.loadMapOperation:getprogress() * 100)
    end
    Finish = function (this)
      this.tcs:SetResult(true)
    end
    return {
      base = function (out)
        return {
          out.DCET.Entity
        }
      end,
      ChangeSceneAsync = ChangeSceneAsync,
      getProcess = getProcess,
      Finish = Finish,
      __ctor__ = __ctor__
    }
  end)
end)
