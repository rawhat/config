local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not (present) then
  return
end

treesitter.setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = {},
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
  },
  autotag = {
    enable = true,
  }
})
