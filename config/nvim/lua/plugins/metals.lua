local present, metals = pcall(require, "metals")

if not (present) then
  return
end

METALS_CONFIG = metals.bare_config
METALS_CONFIG.init_options.statusBarProvider = "on"
