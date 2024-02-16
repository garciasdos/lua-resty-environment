local template = require "resty.template"

local function validate_template(filePath)
    local file = io.open(filePath, "r")
    if not file then
        print("Failed to open file: " .. err)
        return false
    end

    local content = file:read("*a")
    file:close()

    local ok, compiledTemplate = pcall(template.compile, content)
    if not ok then
        print("Template validation failed: " .. compiledTemplate) -- compiledTemplate variable contains the error message in this context
        return false
    else
        print("Template is valid.")
        return true
    end
end

local function escapeString(str)
    -- Escapes double quotes and newlines
    return str:gsub('\n', '\\n'):gsub('"', '\\"')
end

local function stringifyTemplate(filePath)
    local file = io.open(filePath, "r")
    if not file then
        error("File not found")
    end
    local content = file:read("*a")
    file:close()
    return escapeString(content)
end
local filePath = "./comments-api.tpl"
validate_template(filePath)
local escapedString = stringifyTemplate(filePath)
print(escapedString)
