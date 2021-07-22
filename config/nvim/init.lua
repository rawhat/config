require 'options'

local modules = {
  "pluginList",
  "mappings",
  "utils",
}

local async
async = vim.loop.new_async(
  vim.schedule_wrap(
    function()
      for i = 1, #modules, 1 do
        local ok, res = xpcall(require, debug.traceback, modules[i])
        if not (ok) then
          print("Error loading module:  " .. modules[i])
          print(res)
        end
      end
      async:close()
    end
  )
)

async:send()

--[[ require('settings')
require('plugins')
require('config')
require('keybinds') ]]
