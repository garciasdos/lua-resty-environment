-- Run these tests with: busted spec

local template = require "resty.template"

local M = dofile("tpl-module.lua")

describe("convert.lua", function()
    local function writeFile(path, content)
        local f = assert(io.open(path, "w"))
        f:write(content)
        f:close()
    end

    local validTplPath = "test-fixtures/valid_template.tpl"
    local invalidTplPath = "test-fixtures/invalid_template.tpl"

    setup(function()
        writeFile(validTplPath, [[{% local name = "world" %} Hello, {{ name }}!]])

        writeFile(invalidTplPath, [[
{% if true %}
Hello world!
        ]])
    end)

    teardown(function()
        
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
            assert.equals('{% local name = \\"world\\" %} Hello, {{ name }}!', output)
          end)

        it("throws an error if file not found", function()
            assert.has_error(function()
                M.stringifyTemplate("non_existent.tpl")
            end)
        end)
    end)
end)
