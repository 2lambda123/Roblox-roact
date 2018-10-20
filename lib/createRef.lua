--[[
	A ref is nothing more than a binding with a special field 'current'
	that maps to the getValue method of the binding
]]
local Binding = require(script.Parent.Binding)

local function createRef()
	local binding, _ = Binding.create(nil)

	local ref = {}

	--[[
		A ref is just redirected to a binding via its metatable
	]]
	setmetatable(ref, {
		__index = function(self, key)
			if key == "current" then
				return binding:getValue()
			else
				return binding[key]
			end
		end,
		__newindex = function(self, key, value)
			binding[key] = value
		end,
	})

	return ref
end

return createRef