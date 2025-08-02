local module = {}

function module.apply(config)
	config.ssh_domains = {
		{
			name = "skanderbeg",
			remote_address = "skanderbeg",
			username = "alex",
		},
	}
end

return module
