local present, gitsigns = pcall(require, "gitsigns")

if not present then
	error("failed to require gitsigns")
	return
end

gitsigns.setup()
