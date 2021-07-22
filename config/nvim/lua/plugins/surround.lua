local present, surround = pcall(require, "surround")

if not present then
  return
end

surround.setup({})

vim.g.surround_pairs = {
  nestable = {
    {"(", ")"},
    {"[", "]"},
    {"{", "}"},
  },
  linear = {
    {"'", "'"},
    {'"', '"'},
    {" ", " "},
    {"`", "`"}
  }
}
