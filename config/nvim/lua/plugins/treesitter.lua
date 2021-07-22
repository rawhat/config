local present, treesitter = pcall(require, "treesitter.configs")

if not (present) then
  return
end

treesitter.setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
})
