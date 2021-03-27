# Telescope Simple Insert

An extension for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) that allows you to insert simple, predefined text.

## Demo

TODO

## Installation

```vim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'jvgrootveld/telescope-simple-insert'
```

## Setup

You can setup the extension by adding the following to your config:

```lua
require'telescope'.load_extension('simple_insert')
```

And by creating one or more `json` source files in the directory `data/simple-insert-sources/` with format:

```json
[
  { "display": "Item to search", "insert" : "Item to insert" },
  { "display": "Other item to search", "insert" : "Other item to insert" }
]
```

## Available functions:

### Insert

Select predefined entry to insert.

```lua
require'telescope'.extensions.simple_insert.select{}
```

## Example config: 

```lua
vim.api.nvim_set_keymap(
	'n',
	'<leader>i',
	":lua require'telescope'.extensions.simple_insert.select{}<CR>",
	{noremap = true, silent = true}
)
```

## Default mappings:
`<c-o>`: Open source file or show a select window if multiple source files are present.

## Ideas
Some ideas to add

- Add functionality to create new source file.
- Insert entry at the end of the current line on mapping.

If you have any ideas to add to this plugin, please create an issue!
