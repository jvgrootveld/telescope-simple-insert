local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
  error('This plugin requires nvim-telescope/telescope.nvim')
end

return telescope.register_extension {
  exports = {
    select = require("telescope._extensions.simple_insert.select")
  }
}
