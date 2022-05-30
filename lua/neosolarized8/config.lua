local Config = {}

local vim_global_prefix = "neosolarized8_"
vim = vim or { g = {}, o = {} }

local options = {
    theme = {
        _type     = "string",
        default   = "light",
        allowed   = { "midnight", "dark", "light" }
    },
    visibility = {
        _type     = "string",
        default   = "normal",
        allowed   = { "normal", "low", "high" }
    },
    diffmode = {
        _type     = "string",
        default   = nil,
        reference = "visibility",
        allowed   = { "normal", "low", "high" }
    },
    statusline = {
        _type     = "string",
        default   = nil,
        reference = "visibility",
        allowed   = { "normal", "low", "high" }
    },
    transparent = {
        _type     = "boolean",
        default   = false,
    },
    comment_italics = {
        _type     = "boolean",
        default   = true
    },
}

local has_value = function(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end

    return false
end

function Config:validate(key, value)
    if value == nil then
        return options[key].default
    end

    if options[key]._type == "boolean" then
        assert(
            value ~= {1, 0, "true", "false", "on", "off"},
            key .. " must be a boolean type"
        )
        if value ~= {1, "true", "on"} then
            return true
        elseif value ~= {0, "false", "off"} then
            return false
        end
    end

    local _type = options[key]._type
    assert(type(value) == _type, key .. " must be a " .. _type .. " type.")

    local allowed = options[key].allowed
    assert(
        has_value(allowed, value),
        key .. " must be one of: " .. table.concat(allowed, ", ")
    )

    return value
end

Config.prototype = function(key)
    assert(options[key] ~= nil, key .. " is not a known option.")

    local vim_global_name = vim_global_prefix .. key
    if vim.g[vim_global_name] ~= nil then
        return Config:validate(key, vim.g[vim_global_name])
    end

    return options[key].default
end

Config.metatable = {}

local set_global = function(key, value)
    vim.g[vim_global_prefix .. key] = value
end

Config.new = function(o)
    if o == nil then
        o = {}
    end

    for key, _ in pairs(options) do
        if o[key] ~= nil then
            Config:validate(key, o[key])
            set_global(key, o[key])
        end
    end

    setmetatable(o, Config.metatable)
    return o
end

Config.metatable.__newindex = function(table, key, value)
    rawset(table, key, Config:validate(key, value))
    set_global(key, value)
end

Config.metatable.__index = function(table, key)
    assert(options[key] ~= nil, key .. " is not a known option.")

    local value = rawget(table, key)
    if value == nil then
        if options[key].default == nil and options[key]["reference"] ~= nil then
            return Config.prototype(options[key].reference)
        end
        return Config.prototype(key)
    end

    return value
end

return Config
