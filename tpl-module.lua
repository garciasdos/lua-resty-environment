local template = require "resty.template"

local M = {}

function M.validate_template(filePath)
    local file, err = io.open(filePath, "r")
    if not file then
        io.stderr:write("Failed to open file: " .. (err or "Unknown error") .. "\n")
        return false
    end

    local content = file:read("*a")
    file:close()

    local ok, compiledTemplate = pcall(template.compile, content)
    if not ok then
        io.stderr:write("Template validation failed: " .. compiledTemplate .. "\n")
        return false
    end
    return true
end

function M.escapeString(str)
    return str:gsub('\n', '\\n'):gsub('"', '\\"')
end

function M.stringifyTemplate(filePath)
    local file, err = io.open(filePath, "r")
    if not file then
        error("File not found: " .. (err or "Unknown error"))
    end
    local content = file:read("*a")
    file:close()
    return M.escapeString(content)
end

return M
