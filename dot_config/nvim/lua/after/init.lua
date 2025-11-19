local r = function(x)
    pcall(require, 'after.' .. x)
end
r 'persistent'
r 'saturated'
