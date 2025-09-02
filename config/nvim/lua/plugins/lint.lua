return {
	"mfussenegger/nvim-lint",
	opts = function()
		local path = require("mason-core.path")
		local mason_data_path = path.concat({ vim.fn.stdpath("data"), "mason", "bin" })

		local linters = require("lint").linters

		linters.buildifier.command = path.concat({ mason_data_path, "buildifier" })
		linters.eslint_d.command = path.concat({ mason_data_path, "eslint_d" })
		linters.ruff.command = path.concat({ mason_data_path, "ruff" })

		linters.mypy.append_fname = true
		linters.mypy.args = vim.fn.extend(linters.mypy.args, {
			"--config-file",
			vim.env.HOME .. "/vistar/vistar/tools/mypy/mypy.ini",
			"--exclude",
			"'/bazel-[a-z]*/'",
			"--explicit-package-bases",
		})

		local elixir_linters = { "credo" }
		local javascript_linters = { "eslint_d" }
		return {
			linters_by_ft = {
				bzl = { "buildifier" },
				elixir = elixir_linters,
				leex = elixir_linters,
				heex = elixir_linters,
				eex = elixir_linters,
				fish = { "fish" },
				javascript = javascript_linters,
				javascriptreact = javascript_linters,
				json = { "jq" },
				typescript = javascript_linters,
				typescriptreact = javascript_linters,
				proto = { "buf_lint" },
				python = { "mypy" },
			},
		}
	end,
	config = function(_, opts)
		require("lint").linters_by_ft = opts.linters_by_ft

		vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
			callback = function()
				if require("diffview.lib").get_current_view() then
					return
				end
				local current_buf = vim.api.nvim_get_current_buf()
				local is_quickfix = vim.bo[current_buf].ft == "qf"
				if is_quickfix then
					return
				end
				require("lint").try_lint()
			end,
		})
	end,
}
