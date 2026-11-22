--- ncdu-like size view for yazi.
---
--- * `Linemode:size_bar()` renders size + bar relative to the largest entry.
--- * Works around yazi caching directory sizes forever (they are never
---   invalidated) and not calculating sizes after `hidden toggle`:
---     plugin sizebar all      recalculate every dir in the current pane
---     plugin sizebar missing  only dirs without a known size
---     plugin sizebar dirty    only dirs affected by delete/trash/move/copy
---   `dirty` runs automatically via DDS events. Nothing happens unless the
---   tab is sorted by size.

local M = {}

local BAR_WIDTH = 12
-- Line glyphs instead of full blocks: they don't fill the cell, so the bar
-- still reads correctly when the hovered row inverts its colors.
local BAR_FULL = "━"
local BAR_HALF = "╸"

--------------------------------------------------------------------------------
-- Linemode
--------------------------------------------------------------------------------

local function max_size()
	local files = cx.active.current.files
	local pref = cx.active.pref

	-- Fast path: sorted largest-first and dirs not pulled to the top, so the
	-- first entry is the largest one.
	if pref.sort_by == "size" and pref.sort_reverse and not pref.sort_dir_first then
		local first = files[1]
		return first and first:size() or 0
	end

	local max = 0
	for i = 1, #files do
		local s = files[i]:size()
		if s and s > max then
			max = s
		end
	end
	return max
end

local function bar(ratio)
	local halves = math.floor(ratio * BAR_WIDTH * 2 + 0.5)
	local full = math.floor(halves / 2)
	local s = string.rep(BAR_FULL, full)
	if halves % 2 == 1 and full < BAR_WIDTH then
		s = s .. BAR_HALF
		full = full + 1
	end
	return s .. string.rep(" ", BAR_WIDTH - full)
end

-- True while the listing may still change: some dir in the current folder has
-- no size yet (yazi is still calculating) or this plugin is recalculating.
local function incomplete(state)
	if state.running > 0 then
		return true
	end
	local files = cx.active.current.files
	for i = 1, #files do
		local f = files[i]
		if f.cha.is_dir and f:size() == nil then
			return true
		end
	end
	return false
end

local function linemode(state, file)
	local size = file:size()
	local line
	if not size then
		line = ui.Line(string.format("%7s %s", "-", string.rep(" ", BAR_WIDTH + 2)))
	else
		local max = max_size()
		local ratio = max > 0 and math.min(size / max, 1) or 0
		line = ui.Line({
			ui.Span(string.format("%7s ", ya.readable_size(size))),
			ui.Span("["),
			ui.Span(bar(ratio)),
			ui.Span("]"),
		})
	end

	if cx.active.pref.sort_by == "size" and incomplete(state) then
		-- Yellow in default and tokyo-night themes.
		line = line:style(th.status.perm_read)
	end
	return line
end

--------------------------------------------------------------------------------
-- Size recalculation
--------------------------------------------------------------------------------

-- Mark every ancestor of `url` as dirty: their cached sizes are now wrong.
local function mark(state, url)
	local p = url and url.parent
	while p do
		state.dirty[tostring(p)] = true
		p = p.parent
	end
end

local collect = ya.sync(function(state, mode)
	local tab = cx.active
	if tab.pref.sort_by ~= "size" then
		return {}
	end

	local urls = {}
	local function scan(folder)
		if not folder then
			return
		end
		for i = 1, #folder.files do
			local f = folder.files[i]
			if f.cha.is_dir then
				local key = tostring(f.url)
				local want = mode == "all"
					or (mode == "missing" and f:size() == nil)
					or (mode == "dirty" and state.dirty[key])
				if want then
					state.dirty[key] = nil
					urls[#urls + 1] = f.url
				end
			end
		end
	end

	scan(tab.current)
	-- Parent pane only for invalidated entries: sizing every sibling of the
	-- cwd (e.g. all of / when in /usr) would be far too expensive.
	if mode == "dirty" then
		scan(tab.parent)
	end
	state.running = state.running + #urls
	return urls
end)

local done = ya.sync(function(state)
	state.running = math.max(state.running - 1, 0)
	ui.render()
end)

function M:entry(job)
	for _, url in ipairs(collect(job.args[1] or "all")) do
		local it, size = fs.calc_size(url), 0
		if not it then
			done()
		else
			while true do
				local n = it:recv()
				if not n then
					break
				end
				size = size + n
			end
			ya.emit("update_files", { op = fs.op("size", { url = url.trail, sizes = { [url.key] = size } }) })
			done()
		end
	end
end

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

function M:setup()
	local state = self
	Linemode.size_bar = function(lm) return linemode(state, lm._file) end

	self.dirty = {}
	self.running = 0

	local function changed(urls)
		for _, u in ipairs(urls) do
			mark(self, u)
		end
		ya.emit("plugin", { "sizebar", "dirty" })
	end

	ps.sub("delete", function(body) changed(body.urls) end)
	ps.sub("trash", function(body) changed(body.urls) end)
	ps.sub("move", function(body)
		local urls = {}
		for _, item in ipairs(body.items) do
			urls[#urls + 1] = item.from
			urls[#urls + 1] = item.to
		end
		changed(urls)
	end)
	ps.sub("duplicate", function(body)
		local urls = {}
		for _, item in ipairs(body.items) do
			urls[#urls + 1] = item.to
		end
		changed(urls)
	end)

	-- Dirty dirs may only become visible later (e.g. after navigating up).
	local function revisit()
		if next(self.dirty) then
			ya.emit("plugin", { "sizebar", "dirty" })
		end
	end
	ps.sub("cd", revisit)
	ps.sub("load", revisit)
end

return M
