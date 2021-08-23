local present, compe = pcall(require, "compe")

if not (present) then
  return
end

compe.setup {
  enabled = true;
  --[[ autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true; ]]

  source = {
    path = true;
    buffer = true;
    -- calc = true;
    nvim_lsp = true;
    --[[ nvim_lua = true;
    vsnip = true;
    ultisnips = true; ]]
  };
}

local opts = { noremap = true }
vim.api.nvim_set_keymap('i', '<C-Space>', ':compe#complete()', opts)
-- vim.api.nvim_set_keymap('i', '<CR>', ':compe#confirm(luaeval("require \'nvim-autopairs\'.autopairs_cr()"))', opts)
