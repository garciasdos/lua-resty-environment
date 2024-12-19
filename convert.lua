local lfs = require "lfs"
local M = require "tpl_module"  -- our module with core logic

local tplFiles = {}
for file in lfs.dir(".") do
    if file:match("%.tpl$") then
        table.insert(tplFiles, file)
    end
end

if #tplFiles == 0 then
    print("No .tpl files found in the current directory.")
    os.exit(1)
end

print("Select a .tpl file by number:")
for i, f in ipairs(tplFiles) do
    print(i .. ") " .. f)
end

local choice
while true do
    io.write("Enter a number between 1 and " .. #tplFiles .. ": ")
    choice = io.read("*l")
    local num = tonumber(choice)
    if num and tplFiles[num] then
        choice = tplFiles[num]
        break
    else
        print("Invalid selection. Please try again.")
    end
end

if M.validate_template(choice) then
    local escapedString = M.stringifyTemplate(choice)
    print(escapedString)
else
    os.exit(1)
end
