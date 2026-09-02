local registry = require("mason-registry")
registry.refresh()

local pending = 0
for _, pkg in ipairs(registry.get_installed_packages()) do
	local installed = pkg:get_installed_version()
	local latest = pkg:get_latest_version()
	if installed ~= latest then
		pending = pending + 1
		print(("[mason] updating %s: %s -> %s"):format(pkg.name, installed, latest))
		pkg:install({}, function(ok, result)
			if not ok then
				print(("[mason] failed to update %s: %s"):format(pkg.name, vim.inspect(result)))
			end
			pending = pending - 1
		end)
	end
end

vim.wait(10 * 60 * 1000, function()
	return pending <= 0
end, 200)

print("[mason] all packages up to date")
