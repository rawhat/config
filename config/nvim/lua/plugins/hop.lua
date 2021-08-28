local hop = require('hop')

hop.setup({keys = 'etovxqpdygfblzhckisuran'})

vim.api
    .nvim_set_keymap('n', '$', "<cmd>lua require('hop').hint_words()<cr>", {})
