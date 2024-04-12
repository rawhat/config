local module = {}

function module.apply(config)
	config.default_prog = { "R:\\wsl\\Arch.exe" }
	config.ssh_domains = {
		{
			name = "laptop",
			remote_address = "laptop",
		},
		{
			name = "alex.wsl",
			remote_address = "localhost:2222",
			username = "alex",
		},
	}
	config.tls_clients = {
		{
			name = "alex.vistar.lenovo",
			remote_address = "192.168.173.220:8888",
			bootstrap_via_ssh = "alex@192.168.173.220",
		},
	}
	config.launch_menu = {
		{
			label = "ssh laptop",
			args = { "ssh", "laptop" },
			domain = { DomainName = "local" },
		},
		{
			label = "pwsh",
			args = { os.getenv("LOCALAPPDATA") .. "\\Microsoft\\WindowsApps\\pwsh.exe", "-nologo" },
			domain = { DomainName = "local" },
			cwd = "C:\\Users\\Alex",
		},
	}
end

return module
