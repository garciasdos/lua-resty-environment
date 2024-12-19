package = "tpl-stringify"
version = "0.1-1"
source = {
   url = "https://github.com/yourusername/tpl-stringify/archive/v0.1.tar.gz",
   dir = "."
}

description = {
   summary = "A tool for validating and stringifying Lua Resty templates.",
   detailed = [[
A small command-line utility that lists `.tpl` files in the current directory, 
allows you to select one, validates it using lua-resty-template, and prints out 
a stringified version of the file.
   ]],
   homepage = "https://github.com/garciasdos/lua-editor",
   license = "MIT"
}

dependencies = {
   "lua >= 5.1",
   "lua-resty-template",
   "luafilesystem",
   "busted"
}

build = {
   type = "none",
   install = {
      bin = {
        "convert.lua"
      }
   }
}
