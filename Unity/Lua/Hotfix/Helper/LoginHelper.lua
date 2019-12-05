-- Generated by CSharp.lua Compiler
local System = System
local DCETHotfix = DCET.Hotfix
local DCETModel = DCET.Model
System.namespace("DCET.Hotfix", function (namespace)
  namespace.class("LoginHelper", function (namespace)
    local OnLoginAsync
    OnLoginAsync = function (domain, account)
      return System.async(function (async, domain, account)
        System.try(function ()
          -- 创建一个ETModel层的Session
          local session = DCETModel.Game.getScene():GetComponent(DCETModel.NetOuterComponent):Create(DCETModel.GlobalConfigComponent.Instance.GlobalProto.Address)

          -- 创建一个ETHotfix层的Session, ETHotfix的Session会通过ETModel层的Session发送消息
          local realmSession = DCETHotfix.EntityFactory.Create(domain, session, DCETHotfix.Session, DCETModel.Session)
          local default = DCETHotfix.C2R_Login()
          default:setAccount(account)
          default:setPassword("111111")
          local r2CLogin = System.cast(DCETHotfix.R2C_Login, async:Await(realmSession:Call(default)))
          realmSession:Dispose()

          -- 创建一个ETModel层的Session,并且保存到ETModel.SessionComponent中
          local gateSession = DCETModel.Game.getScene():GetComponent(DCETModel.NetOuterComponent):Create(r2CLogin:getAddress())
          DCETModel.Game.getScene():AddComponent(DCETModel.SessionComponent).Session = gateSession

          -- 创建一个ETHotfix层的Session, 并且保存到ETHotfix.SessionComponent中
          DCETHotfix.Game.getScene():AddComponent(DCETHotfix.SessionComponent):setSession(DCETHotfix.EntityFactory.Create(DCETHotfix.Game.getScene(), gateSession, DCETHotfix.Session, DCETModel.Session))

          local extern = DCETHotfix.C2G_LoginGate()
          extern:setKey(r2CLogin:getKey())
          extern:setGateId(r2CLogin:getGateId())
          local g2CLoginGate = System.cast(DCETHotfix.G2C_LoginGate, async:Await(DCETHotfix.SessionComponent.Instance:getSession():Call(extern)))

          DCETHotfix.Log.Info("登陆gate成功!")

          -- 创建Player
          local player = DCETModel.EntityFactory.CreateWithId(DCETModel.Game.getScene(), g2CLoginGate:getPlayerId(), DCETModel.Player)
          local playerComponent = DCETModel.Game.getScene():GetComponent(DCETModel.PlayerComponent)
          playerComponent:setMyPlayer(player)

          DCETHotfix.Game.getEventSystem():Run("LoginFinish" --[[EventIdType.LoginFinish]])

          -- 测试消息有成员是class类型
          local g2CPlayerInfo = System.cast(DCETHotfix.G2C_PlayerInfo, async:Await(DCETHotfix.SessionComponent.Instance:getSession():Call(DCETHotfix.C2G_PlayerInfo())))
        end, function (default)
          local e = default
          DCETHotfix.Log.Error(e)
        end)
      end, nil, domain, account)
    end
    return {
      OnLoginAsync = OnLoginAsync
    }
  end)
end)
