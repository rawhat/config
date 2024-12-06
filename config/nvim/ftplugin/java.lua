local path = require("mason-core.path")
local mason_data_path = path.concat({ vim.fn.stdpath("data"), "mason", "bin" })

local config = {
	cmd = { path.concat({ mason_data_path, "jdtls" }) },
	root_dir = vim.fs.dirname(vim.fs.find({ "WORKSPACE", ".git" }, { upward = true })[1]),
}

require("jdtls").start_or_attach(config)
