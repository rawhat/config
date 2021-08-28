local present, blankline = pcall(require, "indent_blankline")

if not present then
    error("Didn't have indent blankline...")
    return
end

blankline.setup({
    buftype_exclude = {"terminal"},
    show_current_context = true,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false
})
