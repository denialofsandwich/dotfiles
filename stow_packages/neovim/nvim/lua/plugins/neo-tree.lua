local bit = require("bit")
local git = require("neo-tree.git")
local popups = require("neo-tree.ui.popups")
local utils = require("neo-tree.utils")

local function format_permissions(mode)
  mode = tonumber(mode)
  if not mode then
    return "----------"
  end

  local types = {
    [0x8000] = "-", -- Regular file
    [0x4000] = "d", -- Directory
    [0xA000] = "l", -- Symbolic link
    [0x6000] = "b", -- Block device
    [0x2000] = "c", -- Character device
    [0x1000] = "p", -- FIFO/Pipe
    [0xC000] = "s", -- Socket
  }

  local ftype_bit = bit.band(mode, 0xF000)
  local ftype = types[ftype_bit] or "?"

  local function get_perms(m)
    local r = (bit.band(m, 4) ~= 0) and "r" or "-"
    local w = (bit.band(m, 2) ~= 0) and "w" or "-"
    local x = (bit.band(m, 1) ~= 0) and "x" or "-"
    return r .. w .. x
  end

  local user = get_perms(bit.band(bit.rshift(mode, 6), 7))
  local group = get_perms(bit.band(bit.rshift(mode, 3), 7))
  local other = get_perms(bit.band(mode, 7))

  return ftype .. user .. group .. other
end

local default_filetime_format = "%Y-%m-%d %I:%M %p"

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_gitignored = true,
          hide_dotfiles = false,
          hide_hidden = false, -- windows os
          hide_by_name = {
            ".git",
          },
        },
        window = {
          mappings = {
            ["i"] = "show_fs_stat",
            ["s"] = "none",
          },
        },
        commands = {
          show_fs_stat = function(state)
            local node = assert(state.tree:get_node())
            if node.type == "message" then
              return
            end
            local stat = utils.get_stat(node)
            local left = {}
            local right = {}
            table.insert(left, "Name")
            table.insert(right, node.name)
            table.insert(left, "Path")
            table.insert(right, node.path)
            table.insert(left, "Type")
            table.insert(right, node.type)
            table.insert(left, "Mode")
            table.insert(right, format_permissions(stat.mode))
            if stat.size then
              table.insert(left, "Size")
              table.insert(right, utils.human_size(stat.size))
              table.insert(left, "Created")
              local created_format = state.config.created_format or default_filetime_format
              table.insert(right, utils.date(created_format, stat.birthtime.sec))
              table.insert(left, "Modified")
              local modified_format = state.config.modified_format or default_filetime_format
              table.insert(right, utils.date(modified_format, stat.mtime.sec))
            end

            local status_code = git.find_existing_status_code(node.path)
            if status_code then
              table.insert(left, "Git code")
              table.insert(right, type(status_code) == "table" and status_code[1] or status_code)
            end

            local lines = {}
            for i, v in ipairs(left) do
              local line = string.format("%9s: %s", v, right[i])
              table.insert(lines, line)
            end

            popups.alert("File Details", lines)
          end,
        },
      },
    },
  },
}
