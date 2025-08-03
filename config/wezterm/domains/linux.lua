local module = {}

function module.apply(config)
	config.ssh_domains = {
		{
			name = "skanderbeg",
			remote_address = "skanderbeg",
			username = "alex",
		},
	}
	config.launch_menu = {
		{
			label = "skanderbeg",
			domain = { DomainName = "skanderbeg" },
		},
	}
end

return module
