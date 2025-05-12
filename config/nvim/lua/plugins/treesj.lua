return {
	"Wansmer/treesj",
	keys = {
		{ "J", "<cmd>TSJToggle<cr>", desc = "Toggle split/join node under cursor" },
	},
	opts = function()
		local lang_utils = require("treesj.langs.utils")
		return {
			max_join_length = 256,
			use_default_keymaps = false,
			langs = {
				gleam = {
					arguments = lang_utils.set_preset_for_args({
						join = {
							space_in_brackets = false,
						},
					}),
					block = lang_utils.set_preset_for_statement({
						join = {
							force_insert = "",
						},
					}),
					list = lang_utils.set_preset_for_list({
						join = {
							space_in_brackets = false,
						},
					}),
					tuple = lang_utils.set_preset_for_list({
						join = {
							space_in_brackets = false,
						},
					}),
					unqualified_imports = lang_utils.set_preset_for_dict({
						join = {
							space_in_brackets = false,
						},
						both = {
							omit = { "{" },
						},
					}),
					function_parameters = lang_utils.set_preset_for_args(),
				},
			},
		}
	end,
}
