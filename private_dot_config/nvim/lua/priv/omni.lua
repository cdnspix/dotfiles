local omniobj = {}
local metaomni = {}
metaomni.__call = function(s)
    return s
end
metaomni.__index = function(s, k)
    return s
end
setmetatable(omniobj, metaomni)
return omniobj
