-- Generated by CSharp.lua Compiler
local System = System
local SystemIO = System.IO
local SystemCryptography = System.Security.Cryptography
local DCET
System.import(function (out)
  DCET = out.DCET
end)
System.namespace("DCET", function (namespace)
  namespace.class("MD5Helper", function (namespace)
    local FileMD5
    FileMD5 = function (filePath)
      local retVal
      System.using(SystemIO.FileStream(filePath, 3 --[[FileMode.Open]]), function (file)
        local md5 = SystemCryptography.MD5CryptoServiceProvider()
        retVal = md5:ComputeHash(file)
      end)
      return DCET.ByteHelper.ToHex2(retVal, "x2")
    end
    return {
      FileMD5 = FileMD5
    }
  end)
end)
