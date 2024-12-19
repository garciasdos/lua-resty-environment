# tpl-stringify

**tpl-stringify** is a small command-line utility that:

- Lists available `.tpl` files in the current directory.
- Lets you pick one interactively.
- Validates the template using [lua-resty-template].
- Prints a fully escaped, single-line version of the template.

Great for embedding templates directly into Lua code or other contexts where inline strings are needed.

## Installation

```bash
luarocks install --server=https://luarocks.org/dev tpl-stringify
```

## Usage

From a directory with `.tpl` files:

```bash
tpl-stringify
```
Select the desired file by its number, and the escaped, validated template will be printed.

## Testing

```bash
busted spec
```
