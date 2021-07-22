local present, snap = pcall(require, "snap")

if not (present) then
  return
end

local fzf = snap.get('consumer.fzf')
local limit = snap.get('consumer.limit')
local rg_file = snap.get('producer.ripgrep.file')
local rg_vimgrep = snap.get('producer.ripgrep.vimgrep').args({
  "--vimgrep",
  "--hidden",
  "--no-heading",
  "--with-filename",
  "--line-number",
  "--column",
  "--smart-case"
})
local select_file = snap.get('select.file')
local select_vimgrep = snap.get('select.vimgrep')
local preview_file = snap.get('preview.file')
local preview_vimgrep = snap.get('preview.vimgrep')

-- fuzzy find
snap.register.map({'n'}, {'<C-p>'}, function()
  snap.run {
    producer = fzf(rg_file),
    select = select_file.select,
    multiselect = select_file.multiselect,
    views = { preview_file }
  }
end)

-- livegrep
snap.register.map({'n'}, {'<leader>ag'}, function()
  snap.run {
    producer = limit(10000, rg_vimgrep),
    select = select_vimgrep.select,
    multiselect = select_vimgrep.multiselect,
    views = { preview_vimgrep },
    -- i honestly don't know if i really ever _want_ this, and it broke
    -- just grepping from an empty buffer.  so let's just leave it
    -- initial_filter = vim.fn.expand('<cword>')
  }
end)
