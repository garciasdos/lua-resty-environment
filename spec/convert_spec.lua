-- Run these tests with: busted spec

local template = require "resty.template"

-- We'll assume you've refactored the functions into a module so that we can require them here.
-- If not, you could directly require "convert.lua" if it returns a module, 
-- or copy/paste function definitions into this file for testing.
local M = dofile("tpl-module.lua") -- Adjust as needed if convert.lua doesn't return a module.

describe("convert.lua", function()
    local function writeFile(path, content)
        local f = assert(io.open(path, "w"))
        f:write(content)
        f:close()
    end

    local validTplPath = "test-fixtures/valid_template.tpl"
    local invalidTplPath = "test-fixtures/invalid_template.tpl"

    setup(function()
        -- Create a valid template
        writeFile(validTplPath, [[{% local name = "world" %} Hello, {{ name }}!]])

        -- Create an invalid template (e.g. missing a brace)
        writeFile(invalidTplPath, [[
{% if true %}
Hello world!
        ]])
    end)

    teardown(function()
        -- Clean up created files if needed
        -- os.remove(validTplPath)
        -- os.remove(invalidTplPath)
    end)

    describe("validate_template", function()
        it("returns true for a valid template", function()
            assert.is_true(M.validate_template(validTplPath))
        end)

        it("returns false for an invalid template", function()
            assert.is_false(M.validate_template(invalidTplPath))
        end)

        it("returns false for a non-existent file", function()
            assert.is_false(M.validate_template("non_existent.tpl"))
        end)
    end)

    describe("escapeString", function()
        it("escapes newline and double quotes", function()
            local input = 'Hello "world"\nNext line'
            local expected = 'Hello \\"world\\"\\nNext line'
            assert.equals(expected, M.escapeString(input))
        end)

        it("handles empty strings", function()
            assert.equals("", M.escapeString(""))
        end)

        it("handles strings without newlines or quotes", function()
            local input = "Just some text"
            assert.equals("Just some text", M.escapeString(input))
        end)
    end)

    describe("stringifyTemplate", function()
        it("reads and escapes a valid template file", function()
            local output = M.stringifyTemplate(validTplPath)
            assert.equals("{% local name = \\\"world\\\" %} Hello, {{ name }}!", output)
          end)

        it("throws an error if file not found", function()
            assert.has_error(function()
                M.stringifyTemplate("non_existent.tpl")
            end)
        end)
    end)
end)
