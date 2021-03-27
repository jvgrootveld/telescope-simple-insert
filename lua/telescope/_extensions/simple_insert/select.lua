local themes = require('telescope.themes')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values
local path = require('telescope.path')

local source_file_path = "data/simple-insert-sources/*.json"

local get_items = function()
  local files = vim.api.nvim_get_runtime_file(source_file_path, true)

  if #files == 0 then
    print("No Simple Insert JSON source file found! Add in path: " .. source_file_path)
    return
  end

  local items = {}

  for _, file in ipairs(files) do
    for _, item in ipairs(vim.fn.json_decode(path.read_file(file))) do
      table.insert(items, item)
    end
  end

  return items
end

local open_source_file = function (prompt_bufnr)
  actions.close(prompt_bufnr)

  local files = vim.api.nvim_get_runtime_file(source_file_path, true)

  if #files == 0 then
    print("No Simple Insert JSON source file found! Add in path: " .. source_file_path)
    return
  elseif #files == 1 then
    vim.cmd("edit " .. files[1])
    return
  end

  pickers.new({}, {
    prompt_title = 'Source Files',
    finder = finders.new_table {
      results = files,
      entry_maker = function(file_path)
        return {
          value = file_path,
          ordinal = file_path,
          display = file_path
        }
      end
    },
    sorter = conf.file_sorter({}),
  }):find()
end

local map_both = function(map, keys, func)
      map("i", keys, func)
      map("n", keys, func)
end

return function(opts)

  if #opts == 0 then
    opts = themes.get_dropdown {
      width = 0.50
    }
  end

  local results = get_items()

  if results == nil then
    return
  end

  pickers.new(opts, {
    prompt_title = "[ Select Simple Insert ]",

    finder = finders.new_table {
      results = results,
      entry_maker = function(item)
        return {
          value = item,
          ordinal = item.display,
          display = item.display
        }
      end
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_put({selection.value.insert}, '', true, true)
      end)

      map_both(map, "<c-o>", function() open_source_file(prompt_bufnr) end)

      return true
    end,
  }):find()
end
