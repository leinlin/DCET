-- Generated by CSharp.lua Compiler
local System = System
local DCET = DCET
local DCETRuntime = DCET.Runtime
local FairyGUI = FairyGUI
local DictStringUIPackage = System.Dictionary(System.String, FairyGUI.UIPackage)
System.namespace("DCET", function (namespace)
  -- <summary>
  -- 管理所有UI Package
  -- </summary>
  namespace.class("FUIPackageComponent", function (namespace)
    local FUI_PACKAGE_DIR, AddPackage, AddPackageAsync, RemovePackage, class, __ctor__
    __ctor__ = function (this)
      this.packages = DictStringUIPackage()
      DCET.Entity.__ctor__(this)
    end
    FUI_PACKAGE_DIR = "Assets/Bundles/FUI"
    AddPackage = function (this, type)
      if DCETRuntime.Define.IsEditorMode then
        local uiPackage = FairyGUI.UIPackage.AddPackage(class.FUI_PACKAGE_DIR .. "/" .. type)
        this.packages:AddKeyValue(type, uiPackage)
      else
        local uiBundleDesName = DCETRuntime.AssetBundleHelper.StringToAB(type .. "_fui")
        local uiBundleResName = DCETRuntime.AssetBundleHelper.StringToAB(type)
        local resourcesComponent = DCET.Game.Scene:GetComponent(DCET.ResourcesComponent)
        resourcesComponent:LoadBundle(uiBundleDesName)
        resourcesComponent:LoadBundle(uiBundleResName)

        local desAssetBundle = resourcesComponent:GetAssetBundle(uiBundleDesName)
        local resAssetBundle = resourcesComponent:GetAssetBundle(uiBundleResName)
        local uiPackage = FairyGUI.UIPackage.AddPackage(desAssetBundle, resAssetBundle)
        this.packages:AddKeyValue(type, uiPackage)
      end
    end
    AddPackageAsync = function (this, type)
      return System.async(function (async, this, type)
        if DCETRuntime.Define.IsEditorMode then
          async:await(System.Task.getCompletedTask())

          local uiPackage = FairyGUI.UIPackage.AddPackage(class.FUI_PACKAGE_DIR .. "/" .. type)

          this.packages:AddKeyValue(type, uiPackage)
        else
          local uiBundleDesName = DCETRuntime.AssetBundleHelper.StringToAB(type .. "_fui")
          local uiBundleResName = DCETRuntime.AssetBundleHelper.StringToAB(type)
          local resourcesComponent = DCET.Game.Scene:GetComponent(DCET.ResourcesComponent)
          async:await(resourcesComponent:LoadBundleAsync(uiBundleDesName))
          async:await(resourcesComponent:LoadBundleAsync(uiBundleResName))

          local desAssetBundle = resourcesComponent:GetAssetBundle(uiBundleDesName)
          local resAssetBundle = resourcesComponent:GetAssetBundle(uiBundleResName)
          local uiPackage = FairyGUI.UIPackage.AddPackage(desAssetBundle, resAssetBundle)

          this.packages:AddKeyValue(type, uiPackage)
        end
      end, nil, this, type)
    end
    RemovePackage = function (this, type)
      local package

      local default
      default, package = this.packages:TryGetValue(type)
      if default then
        local p = FairyGUI.UIPackage.GetByName(package:getname())

        if p ~= nil then
          FairyGUI.UIPackage.RemovePackage(package:getname())
        end

        this.packages:RemoveKey(package:getname())
      end

      if not DCETRuntime.Define.IsEditorMode then
        local uiBundleDesName = DCETRuntime.AssetBundleHelper.StringToAB(type .. "_fui")
        local uiBundleResName = DCETRuntime.AssetBundleHelper.StringToAB(type)
        DCET.Game.Scene:GetComponent(DCET.ResourcesComponent):UnloadBundle(uiBundleDesName)
        DCET.Game.Scene:GetComponent(DCET.ResourcesComponent):UnloadBundle(uiBundleResName)
      end
    end
    class = {
      base = function (out)
        return {
          out.DCET.Entity
        }
      end,
      FUI_PACKAGE_DIR = FUI_PACKAGE_DIR,
      AddPackage = AddPackage,
      AddPackageAsync = AddPackageAsync,
      RemovePackage = RemovePackage,
      __ctor__ = __ctor__
    }
    return class
  end)
end)
